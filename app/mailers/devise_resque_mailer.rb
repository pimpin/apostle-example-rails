class DeviseResqueMailer < Devise::Mailer
  include Resque::Mailer

  layout 'email'

  class DeviseMessageDecoy < Resque::Mailer::MessageDecoy
    def deliver
      record = @args.first
      resque.enqueue(@mailer_class, @method_name, record.class.name, record.id)
    end
  end

  class << self
    def method_missing(method_name, *args)
      return super if environment_excluded?

      if action_methods.include?(method_name.to_s)
        DeviseMessageDecoy.new(self, method_name, *args)
      else
        super
      end
    end

    def perform(action, class_name, record_id)
      record = class_name.constantize.find_by_id(record_id)
      send(:new, action, record).message.deliver
    end
  end

  protected

  def template_paths
    ['devise/mailer']
  end
end
