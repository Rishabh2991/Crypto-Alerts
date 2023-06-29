class CryptoPrice < ApplicationRecord
  after_commit :reload_latest_price, on: :create
  after_commit :queue_alerts, on: :create


  private
  def reload_latest_price
    PriceFetch::Cache.new(current_price).update!
  end
  
  def queue_alerts
    UserAlerts::Client.new().alert!
  end
end
