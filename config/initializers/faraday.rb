# config/initializers/faraday.rb
module FaradayClient
  BASE_URL = 'http://jenrich.com.cn'.freeze
  CACHE_KEY = "jenrich_session_cookie".freeze

  def self.connection
    Faraday.new(url: BASE_URL) do |config|
      config.response :json
    	config.ssl.verify = false
    	config.request :url_encoded
      config.headers['Cookie'] = current_cookie
      config.adapter Faraday.default_adapter
    end
  end

  def self.current_cookie
    Rails.cache.read(FaradayClient::CACHE_KEY)
  end

  def self.login! 
  	unless current_cookie
	    resp = connection.post('/login.action', {
	      'loginAccount' => 'frbgy03',
	      'password' => '880102',
	      'saveLoginname' => '1'
	    })

	    if resp.status == 302
	    	raw_cookies = Array(resp.headers['set-cookie']).first
	    	Rails.cache.write(FaradayClient::CACHE_KEY, raw_cookies, expires_in: 30.minutes)
	    end
	  end
  end

  def self.execute(method, path, params = {})
  	login!
    connection.send(method, path, params)
  end
end