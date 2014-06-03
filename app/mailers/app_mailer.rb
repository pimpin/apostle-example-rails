class AppMailer < ActionMailer::Base

  #
  # All methods here are going to be delayed with Resque so
  # don't pass whole objects as argument but only ids.
  #
  include Resque::Mailer # Assuming, you use resque and resque_mailer libs # TODO add them in Gemfile

  def self.safe_sending
    message = yield

    begin
      message.deliver # create entry in the job queue
    rescue Errno::ECONNREFUSED => e
      logger.error e.message
      message.deliver! # use fallback with synchrone delivery
    end
  end

end
