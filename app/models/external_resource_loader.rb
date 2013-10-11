class ExternalResourceLoader
  def initialize(context)
    @context = context
    @threads = [ ]
  end

  attr_reader :context, :threads
  private     :context, :threads

  def start_loading(var_name, &loader)
    threads << Thread.new do
      context.instance_variable_set("@#{var_name}", loader.call)
    end
  end

  def finish_loading
    threads.each(&:join)
  end
end
