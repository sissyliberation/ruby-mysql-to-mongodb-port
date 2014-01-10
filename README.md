Ruby MySQL-to-MongoDB Port
==========================

Some code work, having to migrate mysql database to mongodb, and fixing relational-to-one-to-one issues.

Required
---------
1. [gem install mysql](https://rubygems.org/gems/mysql).
2. [gem install mongo](http://rubygems.org/gems/mongo).
3. Replace credentials and add appropriate queries

Description
-----------
Some code that I wrote to migrate MySQL database to MongoDB collection. 

Since relational databases can't be ported to MongoDB one-to-one, there's some code that fixes the relational issues.