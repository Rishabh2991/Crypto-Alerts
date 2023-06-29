module PriceFetch
  class Cache
    attr_accessor :current_price
    
    KEY_LATEST = "BTC:LATEST:"
    KEY_PREVIOUS = "BTC:FORMER:"
    
    def initialize(current_price)
      @current_price = current_price
    end

    def update!
      push_existing_app_price_to_former
      push_new_price_to_latest
    end

    def push_existing_app_price_to_former
      value = Rails.cache.read(KEY_PREVIOUS)
      Rails.cache.delete_matched(KEY_PREVIOUS) if value.present?
      value = existing_app_price
      Rails.cache.write(KEY_PREVIOUS, value)
    end


    def push_new_price_to_latest
      value = Rails.cache.read(KEY_LATEST)
      Rails.cache.delete_matched(KEY_LATEST) if value.present?
      value = current_price
      Rails.cache.write(KEY_LATEST, value)
    end

    def existing_app_price
      @existing_app_price = value = Rails.cache.read(KEY_LATEST)
    end
  end
end