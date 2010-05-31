require 'rails/generators'

class KonfigGenerator < Rails::Generators::Base

  desc "Generates Konfig files"
  argument :name, :type => :string, :required => false, :desc => "Name of konfig template"

  def generate
    self.name ? render_template : show_instructions
  end

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  private

    def show_instructions
      print File.read(File.join(File.dirname(__FILE__), 'USAGE'))
    end

    def render_template
      if Konfig::Adapter.template_for(self.name).present?
        template('konfig.tt', File.join(Konfig.path, "#{ self.name }.yml"))
      else
        print("Invalid Template Name: #{ self.name }\n") 
      end
    end

end

