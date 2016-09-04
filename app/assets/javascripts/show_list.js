// On load:
// For each account in list
// Pull top 14% of tweets 
// Populate UI





function updateTweets(response){
	console.log(response.tweets)
	var tweetsJSON = JSON.parse(response.tweets)
	var html = ""
	$.each(tweetsJSON,function(){
		var row = ""
		var account = this.user.screen_name
		var text = this.text
		row = "<tr><td>" + account + "</td><td>" + text + "</td><td><input type=\"checkbox\"/></td>"
		html = html.concat(row)
	})
	console.log(html)
	$('tbody').html(html)
}

$('#topTweetLimit').slider({
	formatter: function(value) {
		return value + "%";
	}
});

$('#topTweetLimit').slider();

$('#topTweetLimit').on('slideStop', function(stop){
	console.log("slidestop")
	$.ajax({
    url: 'http://localhost:3000/tweets',
    type: "GET",
    data: {
    	tweets: {
      	list: <%= @list.id %>,
      	topPercentage: stop.value
      },
    },
    dataType: 'json',
    success: function(response){
    	console.log(response);
    	updateTweets(response);
    }
	})
});
