module Konfig
  class EmailAdapter < Adapter
    def adapt(data)
      begin
        c = data[:_smtp][Rails.env]
        ActionMailer::Base.smtp_settings = c.symbolize_keys
      rescue
      end
    end
  end
end
