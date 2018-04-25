class PrivacyPolicyController < ApplicationController
  def index
    @privacy_policy_text = Setting.privacy_policy_text
    set_meta_tags title: 'Privacy Policy',
                  og: { title: 'Privacy Policy' }
  end
end
