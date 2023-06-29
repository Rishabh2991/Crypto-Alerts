require 'sidekiq'

Sidekiq.configure_server do |config|
    #Sidekiq::Scheduler.reload_schedule!
    config.redis = { url: 'redis://btcalerts-redis-1:6379/0' }    
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://btcalerts-redis-1:6379/0'  }
end