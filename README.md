SambotDoesTwitter - A plugin for Sambot that adds support for getting tweets and tweeting messages.

# Installation
Copy the SambotDoesTwitter.rb file from the repo and add it to the plugins directory of your Sambot instance.

Make sure that the 'twitter' gem is installed:

	gem install twitter

# Configuration
Create a Twitter.yaml file in the Sambot config directory.  Add the following entries:

	consumer_key: <value>
	consumer_secret: <value>
	oauth_token: <value>
	oauth_token_secret: <value>
	
These values can be obtained from your twitter account page.

# Usage

	Tweet <message>

Sam post the message to your twitter feed (assuming its less than 140 chars)

	Twitter status <twitter_name>
	
Sam will display (or send a link to) the latest message for the twitter account specified.