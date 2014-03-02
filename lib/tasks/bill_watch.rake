require "dotenv"
require "nokogiri"
require "pony"

require "open-uri"

Dotenv.load(File.join(__dir__, *%w[.. .. .env]))

class Notification
  def self.email_account_options
    {
      via:         :smtp,
      via_options: {
        address:              "smtp.mandrillapp.com",
        port:                 587,
        enable_starttls_auto: true,
        user_name:            ENV.fetch("MANDRILL_USERNAME"),
        password:             ENV.fetch("MANDRILL_API_KEY"),
        authentication:       :plain,
        domain:               ENV.fetch("MANDRILL_DOMAIN")
      }
    }
  end

  def initialize(to: nil, subject: nil, message: nil)
    @to      = to
    @subject = subject
    @message = message
  end

  attr_reader :to, :subject, :message

  def deliver
    Pony.mail( self.class.email_account_options.merge( {
      from:    "tech.chair@oklahomaatheists.com",
      to:      to,
      subject: subject,
      body:    message
    } ) )
  end
end

class Agenda
  URL         = "http://www.okhouse.gov/FloorAgenda/Default.aspx"
  LAST_AGENDA = "last_agenda.txt"

  def initialize
    @last_measures    = nil
    @current_measures = nil
  end

  def have_last_agenda?
    File.exist?(LAST_AGENDA)
  end

  def last_measures
    return @last_measures if @last_measures

    @last_measures = [ ]
    if have_last_agenda?
      File.foreach(LAST_AGENDA) do |line|
        @last_measures << line.strip
      end
    end
    @last_measures
  end

  def current_measures
    return @current_measures if @current_measures

    calendar          = Nokogiri.HTML(open(URL, &:read))
    odd_rows          = calendar.css("table.rgMasterTable tr.rgRow td:first")
    even_rows         = calendar.css("table.rgMasterTable tr.rgAltRow td:first")
    @current_measures = odd_rows.zip(even_rows).flatten.compact.map { |measure|
      measure.text[/H\w{4,}/]
    }
  end

  def new_measures(bills_of_interest)
    bills_of_interest & (current_measures - last_measures)
  end

  def save
    open(LAST_AGENDA, "w") do |f|
      f.puts current_measures
    end
  end
end

class BillTracker
  URL = "http://www.oklegislature.gov/BasicSearchForm.aspx"

  def initialize(bill_number)
    @bill_number      = bill_number
    @existing_history = nil
    @update_history   = nil
  end

  def bill_history?
    File.exist?("#{@bill_number}.txt")
  end

  def updates
    updated_history - existing_history
  end

  def has_changes?
    (updated_history - existing_history).size > 0
  end

  def existing_history
    return @existing_history if @existing_history

    @existing_history = [ ]

    if bill_history?
      File.foreach("#{@bill_number}.txt") do |f|
        @existing_history << f.strip
      end
    end
    @existing_history
  end

  def updated_history
    return @updated_history if @updated_history

    @updated_history = []
    page = Nokogiri.HTML(open(build_url_for_bill, &:read))
    page.css('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_tblHouseActions tr').each do |t|
      next if t.css('td').size <= 1
      next if t.css('td').first.text == "Action"
      @updated_history << t.css('td')[0].text
    end
    @updated_history
  end

  def save
    File.open("#{@bill_number}.txt", "w") do |f|
      f.puts updated_history
    end
  end

  def build_url_for_bill
    "http://www.oklegislature.gov/BillInfo.aspx?Bill=#{@bill_number}&Session=#{get_current_session}"
  end

  def get_current_session
    html = Nokogiri.HTML(open(URL, &:read))
    html.css("select option:first").attr("value").value
  end
end

desc "Watches bills in the OK House"
task :bill_watch do
  subscriber          = "james@graysoftinc.com"
  # subscriber          = "5803092033@txt.att.net"
  subscribed_to_bills = %w[HB1674]

  agenda = Agenda.new
  if agenda.have_last_agenda?
    measures = agenda.new_measures(subscribed_to_bills)
    unless measures.empty?
      measures_sentence = if measures.size == 1
                            measures.first
                          elsif measures.size == 2
                            measures.join(" and ")
                          else
                            measures[0..-2].join(", ") + ", and #{measures[-1]}"
                          end
      notification = Notification.new(
                                      to:      subscriber,
                                      subject: "Measures Added to the OK House Agenda",
                                      message: "#{measures_sentence}."
                                      )
      notification.deliver
      agenda.save
    end
  else
    agenda.save
  end

  subscribed_to_bills.each do |bill|
    tracker = BillTracker.new(bill)
    if tracker.bill_history?
      if tracker.has_changes?
        notification = Notification.new(
                                        to:      subscriber,
                                        subject: "Changes for #{bill}",
                                        message: tracker.updates.map { |line| "#{line}\n" }.join +
                                        tracker.build_url_for_bill
                                        )
        notification.deliver
        tracker.save
      end
    else
      tracker.save
    end
  end
end
