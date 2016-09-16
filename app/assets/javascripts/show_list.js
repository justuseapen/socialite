var listId = parseInt($(".list").attr('id'))

function addTweetsToBufferQueue(tweets) {
	$.ajax({
	    url: '/updates',
	    type: "POST",
	    data: {
	    	listId: listId,
	    	tweetIds: tweets
	    },
	    dataType: 'json',
	    success: function(response){
	    	console.log("POSTed updates");
	    }
		})
}

function gatherCheckedTweets() {
	var checkedTweetIDs = []
	$(".selectTweet").each( function(){
		if(this.checked){
			checkedTweetIDs.push(this.id)
		}
	});
	return checkedTweetIDs
}

function bufferTweets(){
	var tweets = gatherCheckedTweets();
	addTweetsToBufferQueue(tweets);
}

$( document ).ready(function(){

	$('#topTweetLimit').slider({
		formatter: function(value) {
			return value + "%";
		}
	});

	$('#topTweetLimit').slider();

	function populateTweets(response){
		$('.tweet').remove();
		var tweetsJSON = JSON.parse(response.tweets);
		$.each(tweetsJSON,function(){
			console.log(this)
			// Only pulling the first image, need to correct this:
			tweetImageURL = "";
			if(typeof this.entities.media !== "undefined"){
				tweetImageURL = this.entities.media[0].media_url
			}
			var tweetText = this.text
			var tweetFavorites = this.favorite_count
			var tweetRetweets = this.retweet_count
			var tweetID = this.id_str
			var tweetHTML = "\
				<div class=\"tweet row well well-sm card\">\
						<div class=\"tweet-image col-sm-2\">\
							<img src=\""+ tweetImageURL +"\">\
						</div>\
						<div class=\"col-sm-8\">\
							<div class=\"tweet-text\">\
								<p>"+ tweetText +"</p>\
							</div>\
							<div class=\"tweet-stats\">\
								<div class=\"tweet-favorites\">\
									<i class=\"fa fa-star\"></i>\
									"+ tweetFavorites +"\
								</div>\
								<div class=\"tweet-retweets\">\
									<i class=\"fa fa-retweet\"></i>\
									"+ tweetRetweets +"\
								</div>\
							</div>\
						</div>\
						<div class=\"tweet-buffer col-sm-2\">\
							<label>Add to Buffer:</label>\
							<div class=\"center\">\
								<input type=\"checkbox\" class=\"selectTweet\" name=\"addTweetToBuffer\" id=\""+ tweetID +"\">\
							</div>\
						</div>\
					</div>"
		});
	}

	function fetchTweets(topPercentage) {
		console.log('Fetching tweets for list ' + listId)
		// Get tweets
		$.ajax({
	    url: '/tweets',
	    type: "GET",
	    data: {
	    	tweets: {
	      	list: listId,
	      	topPercentage: topPercentage
	      },
	    },
	    dataType: 'json',
	    success: function(response){
	    	console.log("ajax complete");
	    	populateTweets(response);
	    }
		})
	}

	fetchTweets(14);

	$('#topTweetLimit').on('slideStop',function(e){
		console.log(e.value);
		fetchTweets(e.value);
	});

});
