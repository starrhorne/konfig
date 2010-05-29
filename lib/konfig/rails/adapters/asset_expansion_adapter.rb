module Konfig
  class AssetExpansionAdapter < Adapter
    def adapt(data)
      javascripts(data)
      stylesheets(data)
    end

    def javascripts(data)
      return unless (d = data[:_javascript_expansions])
      ActionView::Helpers::AssetTagHelper.register_javascript_expansion(d)
      c = d[:_adapted] = true
      Rails.logger.info "[Konfig] Loaded javascript expansions"
    end

    def stylesheets(data)
      return unless (d = data[:_stylesheet_expansions])
      ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion(d)
      c = d[:_adapted] = true
      Rails.logger.info "[Konfig] Loaded stylesheet expansions"
    end
  end
end
