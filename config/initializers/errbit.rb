Airbrake.configure do |config|
  config.api_key = 'd62c77c84ff5be9b19b0c63b33881d1f'
  config.host    = 'errbit.roachking.net'
  config.port    = 80
  config.secure  = config.port == 443
end
