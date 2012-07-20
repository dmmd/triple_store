require "./lib/simple_graph"

include SimpleGraph

graph = Graph.new

graph.add("The Papers of Samuel Tilden", "Written By", "samuel_tilden")
graph.add("The Papers of Samuel Tilden", "Written By", "some_guy")
graph.add("The Papers of Samuel Tilden", "Described By", "some_other_gal")
graph.add("The Papers of Robert Fulton", "Written By", "robert_fulton")
graph.add("The Autobiography of Samuel Tilden", "Written By", "samuel_tilden")
graph.add("samuel_tilden", "name", "Samuel Tilden")
graph.add("robert_fulton", "name", "Robert Fulton")
graph.add("some_other_gal", "name", "Kit Messick")

puts graph.triples("The Papers of Samuel Tilden", "Written By", "samuel_tilden")
puts "\n"
puts graph.triples("The Papers of Samuel Tilden", "Written By", nil)
puts "\n"
puts graph.triples("The Papers of Samuel Tilden", "Described By", "some_other_gal")
puts "\n"
puts graph.triples("The Papers of Samuel Tilden", nil, nil)
puts "\n"
puts graph.triples(nil, "Written By", "samuel_tilden")
puts "\n"
puts graph.triples(nil, nil, "samuel_tilden")
puts "\ndone"
