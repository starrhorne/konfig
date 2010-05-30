module Konfig
  class SmtpAdapter < Adapter

    def adapt
      using(:_smtp) do |data|
        ActionMailer::Base.smtp_settings = data[Rails.env]
      end
    end

    # has_template :_smtp, :content => 'xxx', :file => ''

  end
end
