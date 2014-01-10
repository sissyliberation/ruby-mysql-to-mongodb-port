require 'mysql'
require 'rubygems'
require 'mongo'

include Mongo

begin

    con = Mysql.new 'localhost', 'username', 'password', 'test_db'
    r = con.query("SELECT * FROM news")
    
    type = {
    	"17" => "News Release",
    	"19" => "Article",
    	"21" => "Video",
    	"23" => "Event"
    }

    mongo_client = MongoClient.new("localhost", 27017)

    db = mongo_client.db("mydb")
	db = MongoClient.new("localhost", 27017).db("mydb")
	coll = db.collection("news")

	r.each_hash {
		|i|
		tmp = "-1"
		r_type = con.query("SELECT * FROM news_to_type_rel")
		r_type.each_hash {
			|j|
			tmp = j['news_type_id'].to_s if j['news_id'] == i['id'] 
		}
		doc = {
			"id" => i['id'],
			"headline" => i['headline'],
			"body" => i['body'],
			"time" => i['time'],
			"hide" => i['hide'],
			"url" => i['url'],
			"event_time" => i['event_time'],
			"youtube" => i['youtube'],
			"vimeo" => i['vimeo'],
			"sponsored" => i['sponsored'],
			"event_until" => i['event_until'],
			"urlname" => i['news_id'],
			"type" => type[tmp]
		}
		coll.insert(doc)
	}
end