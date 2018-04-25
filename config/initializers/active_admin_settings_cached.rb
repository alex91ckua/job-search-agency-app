ActiveadminSettingsCached.configure do |config|
  config.display = {
      phone: :phone,
      email: :email,
      twitter: :url,
      linkedin: :url,
      google_play: :url,
      app_store: :url,
      privacy_policy_text: :froala_editor, input_html:
          {
              data: {
                  options: {
                      height: 500
                  }
              }
          }
  }
end