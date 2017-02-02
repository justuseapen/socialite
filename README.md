Socialite
=========
Socialite is a tool for social media entrpreneurs.

Users select influencers in a niche.

The user filters for the influencer's most valuable content.

They select their favorites to add to Buffer.

Get Feedback on These:
======================

* As a user, I want to know which tweets I've already queued up so I don't repeat myself too many times?

Up Next
=======

# Hacker Practice Twitter Bot

I want to make this bot. Every day it should dump the top 25 tweets from the previous day.

Pre-Requisites:
1. Select a profile to be the bot. (@justuseapen for now)
2. Select a list for the bot to curate (make this)
3. Select the time for list to be dumped every day (12pm the day after for now)
4. 

A Connected Buffer Account With the bot profile selected.

## Nightly queue and buffer jobs

1. Search for top tweets of the day from hacker sources
2. Buffers top 25 tweets in tech to go out on 

## BUILDING LISTS
DAILY: AGENT ACCESSES (BuzzSumo)[https://app.buzzsumo.com/amplification/twitter-influencers]

1. Mechanize ageny checks for new influencers in Startups, Business, etc. (Fishing Holes)
2. Job adds top influncers first, then repeat until fail.



# Test Suite Project

## Feature Tests
1. User registers with email and password [✓]
2. User connects new account to buffer [✓]
3. User adds buffer profiles to Socialite []
4. User creates a list []
5. User adds twitter accounts to the list []
6. User selects tweets from the list []
7. User buffers tweets []
8. User reviews updates []
9. User sees progress bar while buffering tweets []

*Refactor the tests so that changes to copy don't break everything.*

### User adds buffer profiles to Socialite []

1. User creates an account
2. User connects to buffer.
3. Backend pulls bufferprofiles
4. Backend creates profile records.
5. User sees profiles on dashboard.

## Unit Tests
1. User
2. Buffer Account
3. Buffer Profile
4. List
5. Twitter Account

* On buffering from list view:
	- for success: display tweet as green
	- for failure: display tweet as red
		- Show failure message

* If there are no recent tweets, pull all-time best tweets

	# If there are no tweets from the last two days
	# 	Pull all-time top tweets
	# 	You can pull up to 3200 tweets, 200 at a time per account
	# 	and rate limiting could (will) be an issue


* Handle images
	- Test: Buffer using entities.media[0].url
	- If it works. Use that.
	- If it doesn't, search for
		- Downloading image to aws bucket
		- use image url from aws

* Add multiple accounts to a list at one time

* Check for uniqueness of account within a given list

* On list view, pull all tweets for all accounts.
	* Filter based on inputs by user (quality, timeframe)


DONE
====
* Style the auth pages DONE SORT OF
* User logs in with buffer
	- OAuth Protocol DONE
		- Select "Login w/ Buffer" DONE
		- Opens Buffer login dialogue DONE
		- Enters buffer credentials DONE
		- Buffer returns auth token DONE
		- Use token in all calls to buffer DONE
* Deploy to Heroku staging env
* Buffer Profile Rearchitecture:
- On first buffer connection
	- add all buffer profiles for twitter as buffer_profiles on current user's 
	- buffer_profile is not in db?
		- buffer profile is "inactive"
NOT REALLY DONE BUT SORT OF WORKS^^^
* Handling for Images DONE
* Project Progress Bar DONE (9/28)