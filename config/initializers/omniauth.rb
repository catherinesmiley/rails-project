Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '618535992091498', '5e9a2aebb4bf36d688308104ddbc4a3b'
  end