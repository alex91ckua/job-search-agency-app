ActiveadminSettingsCached.configure do |config|
  config.display = {
      phone: :phone,
      email: :email,
      twitter: :url,
      linkedin: :url,
      google_play: :url,
      app_store: :url
  }
end