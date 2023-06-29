class PriceFetchJob
  include Sidekiq::Worker

  def perform(*args)
    sync!
  end

  private

  def sync!
    PriceFetch::Fetch.new().save!
  end
end