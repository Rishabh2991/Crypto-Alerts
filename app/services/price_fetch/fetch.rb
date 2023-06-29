module PriceFetch
  class Fetch

    def initialize()
      @time = Time.now
    end

    def save!
      CryptoPrice.new(payload).save! if delta?
    end

    def payload
      {
        coin: 'btc',
        current_price: current_price,
        payload: resp
      }
    end

    def current_price
      resp.first.dig("current_price")
    end

    def resp 
      url = URI(uri)
      request = Net::HTTP::Get.new(url)
      response = Net::HTTP.start(url.hostname, url.port, use_ssl: true){|http| http.request(request)}
      @resp ||= JSON.parse(response.read_body)
    end

    def delta?
      current_price != latest_price
    end
    
    private

    def latest_price
      CryptoPrice.where(coin: 'btc').order("created_at desc").pluck(:current_price).first
    end

    def uri
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin"
    end
  end
end