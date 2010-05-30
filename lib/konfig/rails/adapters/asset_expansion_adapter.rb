module Konfig
  class AssetExpansionAdapter < Adapter

    def adapt
      using(:_javascript_expansions) do |data|
        ActionView::Helpers::AssetTagHelper.register_javascript_expansion(data)
      end

      using(:_stylesheet_expansions) do |data|
        ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion(data)
      end
    end

  end
end
