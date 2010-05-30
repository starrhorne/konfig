module Konfig
  class SmtpAdapter < Adapter

    def adapt
      return unless data[:_smtp][Rails.env]

      ActionMailer::Base.smtp_settings = data[:_smtp][Rails.env]
      data[:_smtp][:_adapted] = true
      Rails.logger.info "[Konfig] Loaded SMTP setting"
    end

  end
end
