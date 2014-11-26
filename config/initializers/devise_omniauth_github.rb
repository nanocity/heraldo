Devise.setup do |config|
  config.omniauth :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
end
