# config/initializers/imgkit.rb
IMGKit.configure do |config|
  if Rails.env == 'production'
    config.wkhtmltoimage = Rails.root.join('bin', 'wkhtmltoimage-amd64').to_s# if ENV['RACK_ENV'] == 'production'
  else
    config.wkhtmltoimage = '/usr/local/bin/wkhtmltoimage'
  end
  config.default_options = {
    :quality => 60
  }
  config.default_format = :png
end