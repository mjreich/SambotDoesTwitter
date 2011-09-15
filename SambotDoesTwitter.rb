class SambotDoesTwitter < SambotPlugin
    
  def initialize(sambot)
    super sambot
    register({:terms => ['twitter status'], :handler => 'run_twitter_status', :args => "twitter status (\\w+)", :description => "Sam gets a users twitter status."})
    register({:terms => ['tweet'], :handler => 'run_tweet', :args => "tweet ([\\w\\s]+)", :description => "Sam tweets a message."})
    
    load_config
    
    Twitter.configure do |config|
      config.consumer_key = @config['consumer_key']
      config.consumer_secret = @config['consumer_secret']
      config.oauth_token = @config['oauth_token']
      config.oauth_token_secret = @config['oauth_token_secret']
    end
  end
  
  def load_config
    @config = YAML::load_file(File.dirname(__FILE__) + "/../config/Twitter.yaml")
  end
  
  def run_tweet(message, args)
    m = args[0]
    outmsg = SambotMessage.new(message.listener)
    outmsg.to = message.from
    outmsg.type = 'chat'
    if m.length < 140
      client = Twitter::Client.new
      client.update(m)
      outmsg.message = "Tweeted"
    else
      outmsg.message = "Sorry, something went wrong."
    end  
    outmsg.send   
  end
 
  def run_twitter_status(message, args)
    outmsg = SambotMessage.new(message.listener)
    outmsg.to = message.from
    outmsg.type = 'tweet'
    tweets = get_twitter(args[0])
    if tweets.length > 0
      tweet = tweets[0] 
      outmsg.message = "http://twitter.com/"+args[0].to_s+"/status/"+tweet['id_str']
      outmsg.send
    end
  end
  
  def get_twitter(user)
    base_url = "http://twitter.com/statuses/user_timeline/#{user}.json?count=1"
    resp = Net::HTTP.get_response(URI.parse(base_url))
    if resp.code == "200"
      data = resp.body
      result = JSON.parse(data)
    end
  end
  
end
