require "/home/dm/triplestore/lib/simple_graph"

include SimpleGraph

graph = Graph.new

graph.add("The Papers of Samuel Tilden", "Written By", "Samuel_Tilden")
graph.add("The Papers of Robert Fulton", "Written By", "Robert_Fulton")
graph.inspect

puts "done"
