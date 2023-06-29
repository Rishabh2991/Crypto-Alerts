Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = {
      my_job: {
        'cron' => '*/5 * * * *',
        'class' => 'PriceFetchJob'
      }
    }
    Sidekiq::Scheduler.reload_schedule!
  end
end