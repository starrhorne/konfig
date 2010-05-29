module Konfig
  class SmtpAdapter < Adapter
    def adapt(data)
      begin
        c = data[:_smtp][Rails.env]
        ActionMailer::Base.smtp_settings = c.symbolize_keys

        c = data[:_smtp][:_adapted] = true
        Rails.logger.info "[Konfig] Loaded SMTP setting"
      rescue
      end
    end
  end
end
