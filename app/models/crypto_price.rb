class CryptoPrice < ApplicationRecord
  after_commit :reload_latest_price, on: :create

  private
  def reload_latest_price
    PriceFetch::Cache.new(current_price).update!
  end
end
