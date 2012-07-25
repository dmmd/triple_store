require 'mongo'
require './config'

#db info
@connection = Mongo::Connection.new
db = @connection[DATABASE_NAME]

#triple store collections
@spo = db['spo']
@pos = db['pos']
@osp = db['osp']

#test info
subj = "movie"
pred = "written by"
obj = "some guy"

def add(subj, pred, obj)
  add_to_index(@spo, subj, pred, obj)
  add_to_index(@pos, pred, obj, subj)
  add_to_index(@osp, obj, subj, pred)
end

def add_to_index(index, a, b, c)
  index.save({a => [b => [c]]})  
end

add(subj, pred, obj)

