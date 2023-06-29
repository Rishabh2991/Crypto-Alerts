module UserAlerts
  class Client
    attr_accessor :btc_latest_price,
      :btc_former_price

    def initialize()
      @btc_latest_price = Rails.cache.read("BTC:LATEST:").to_i
      @btc_former_price = Rails.cache.read("BTC:FORMER:").to_i
    end

    def alert!
      alert_set = alerts_for_target_price + alerts_within_target_price
      alert_set.each do |alert|
        puts "{user=> #{alert.user.email},current_price=> #{btc_latest_price},target_price=>#{alert.target_price},Target Price Met}"
        #UserAlerts::Alert.new(alert).queue!
        alert.update!(trigger_count_history: '1')
      end
    end

    def alerts_for_target_price
      #this methods gets all alerts which have been set for current target price
      Alert.where(target_price: btc_latest_price,status: "active",trigger_count_history: nil)
    end

    def alerts_within_target_price
      #this method get all alerts whose target price was within the latest coin price from API and latest
      #coin price present on the app.
      Alert.where('target_price BETWEEN ? AND ?',[btc_latest_price,btc_former_price].min,[btc_latest_price,btc_former_price].max).where(status: 'active',trigger_count_history: nil)
    end
  end
end