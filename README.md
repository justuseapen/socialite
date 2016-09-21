Socialite
=========

Socialite is a tool for social media entrpreneurs.

Users select influencers in a niche.

The user filters for the influencer's most valuable content.

They select their favorites to add to Buffer.

Up Next
=======

* Deploy to Heroku staging env

* On buffering from list view:
	- for success: display tweet as green
	- for failure: display tweet as red
		- Show failure message

* If there are no recent tweets, pull all-time best tweets

`
	# If there are no tweets from the last two days
	# 	Pull all-time top tweets
	# 	You can pull up to 3200 tweets, 200 at a time per account
	# 	and rate limiting could (will) be an issue
`

* Handle images
	- Test: Buffer using entities.media[0].url
	- If it works. Use that.
	- If it doesn't, search for
		- Downloading image to aws bucket
		- use image url from aws

* Handle user log in with buffer
* Add multiple accounts to a list
* On list view, pull all tweets for all accounts.
	* Filter based on inputs by user (quality, timeframe)

Get Feedback on These:
======================

* As a user, I want to know which tweets I've already queued up so I don't repeat myself too many times?
