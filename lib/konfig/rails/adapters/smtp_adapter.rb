module Konfig
  class SmtpAdapter < Adapter

    def adapt
      using(:_smtp) do |data|
        ActionMailer::Base.smtp_settings = data[Rails.env]
      end
    end

  end
end
