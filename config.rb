# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end
activate :directory_indexes

# Layouts
# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page "/la-dulce-vida/*", :layout => "content"
page "/es/la-dulce-vida/*", :layout => "content"
page "/beach-club/*", :layout => "content"
page "/es/club-de-playa/*", :layout => "content"
page "/hacienda-pinilla/*", :layout => "content"
page "/es/hacienda-pinilla/*", :layout => "content"
page "/costa-rica/*", :layout => "content"
page "/es/costa-rica/*", :layout => "content"
page "/golf/*", :layout => "content"
page "/es/golf-de-18-hoyos", :layout => "content"
page "/enjoy-explore/*", :layout => "content"
page "/es/disfrute-y-explore/*", :layout => "content"

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

activate :i18n

# Proxy pages
proxy "_redirects", "netlify-redirects", ignore: true

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
helpers do
  def get_opposite_language(language)
    language == "en" ? "es" : "en"
  end
  def get_opposite_locale_path(language)
    language == "en" ? "es/" : "/"
  end
  def locale_prefix
    (I18n.locale == :en) ? "" : "/" + I18n.locale.to_s
  end
  def navigation_item_title(page)
    t("site_navigation.#{t(:paths).select{|k,v| v == page.split('/').last.to_s}.keys[0].to_s}")
  end
  def page_translation
    @locale = (I18n.locale == :en) ? "es" : ''
    @translated_locale = (I18n.locale == :en) ? :es : :en
    @url_array = current_page.url.split('/')
    @url = @url_array[-1].to_s
    @path = t("paths.#{t(:paths).select{|k,v| v == @url}.keys[0].to_s}", :locale => @translated_locale)
    @directory = @url_array.count > 1 ? "#{t(:paths).select{|k,v| v == @url_array[-2]}.keys[0].to_s}/" : ""

    if current_page.data.is_index
      @locale
    else
      @locale + @directory +  @path
    end
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
