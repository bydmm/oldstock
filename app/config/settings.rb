configure do
  set :server, :puma
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
  I18n.backend.load_translations
  I18n.enforce_available_locales = true
  I18n.default_locale = :'zh-CN'
end

configure :development do
end

configure :production do
end
