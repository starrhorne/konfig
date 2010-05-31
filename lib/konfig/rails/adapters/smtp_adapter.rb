module Konfig
  class SmtpAdapter < Adapter

    def adapt
      using(:_smtp) do |data|
        ActionMailer::Base.smtp_settings = data[Rails.env]
      end
    end

    # TODO: Implement something like this
    # configures :smtp do |data|
      # ActionMailer::Base.smtp_settings = data[Rails.env]
    # end

    has_template :smtp, :content => %[

      # SMTP Configuration
      # For more information: http://guides.rails.info/action_mailer_basics.html

      development:
        enable_starttls_auto: true
        address: smtp.gmail.com
        port: 587
        domain: example.com
        authentication: :login
        user_name: example@example.com
        password: password

      production:
        enable_starttls_auto: true
        address: smtp.gmail.com
        port: 587
        domain: example.com
        authentication: :login
        user_name: example@example.com
        password: password

      test:
    ]

  end
end
