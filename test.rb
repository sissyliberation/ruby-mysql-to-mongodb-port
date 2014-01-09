require 'mysql'
require 'rubygems'
require 'mongo'

include Mongo

begin

    con = Mysql.new 'localhost', 'root', 'aoeu.123', 'test_db'
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
		|h|
		tmp = "-1"
		r_type = con.query("SELECT * FROM news_to_type_rel")
		r_type.each_hash {
			|i|
			tmp = i['news_type_id'].to_s if i['news_id'] == h['id'] 
		}
		doc = {
			"id" => h['id'],
			"headline" => h['headline'],
			"body" => h['body'],
			"time" => h['time'],
			"hide" => h['hide'],
			"url" => h['url'],
			"event_time" => h['event_time'],
			"youtube" => h['youtube'],
			"vimeo" => h['vimeo'],
			"sponsored" => h['sponsored'],
			"event_until" => h['event_until'],
			"urlname" => h['news_id'],
			"type" => type[tmp]
		}
		coll.insert(doc)
	}
end