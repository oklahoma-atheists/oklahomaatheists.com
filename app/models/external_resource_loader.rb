class ExternalResourceLoader
  def initialize(context)
    @context = context
    @threads = [ ]
  end

  attr_reader :context, :threads
  private     :context, :threads

  def start_loading(var_name, expires = 6.hours, &loader)
    threads << Thread.new do
      context.instance_variable_set(
        "@#{var_name}",
        Rails.cache.fetch( "external_data/#{var_name}",
                           expires_in: expires,
                           &loader )
      )
    end
  end

  def finish_loading
    threads.each(&:join)
  end
end
