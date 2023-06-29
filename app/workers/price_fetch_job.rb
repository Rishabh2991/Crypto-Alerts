class PriceFetchJob
  include Sidekiq::Worker

  def perform(*args)
    #sync!
    puts "running"
  end

  private

  def sync!
    PriceFetch::Fetch.new().save!
  end
end