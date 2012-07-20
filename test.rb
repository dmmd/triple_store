require "./lib/simple_graph"

include SimpleGraph

graph = Graph.new

=begin
graph.add("The Papers of Samuel Tilden", "Written By", "samuel_tilden")
graph.add("The Papers of Samuel Tilden", "Written By", "some_guy")
graph.add("The Papers of Samuel Tilden", "Described By", "some_other_gal")


graph.add("The Papers of Robert Fulton", "Written By", "robert_fulton")
graph.add("The Autobiography of Samuel Tilden", "Written By", "samuel_tilden")
graph.add("samuel_tilden", "name", "Samuel Tilden")
graph.add("robert_fulton", "name", "Robert Fulton")
graph.add("some_other_gal", "name", "Kit Messick")

puts "\nRemove test"
puts "initial triples with subj => 'The Papers of Samuel Tilden'"
puts graph.triples("The Papers of Samuel Tilden", nil, nil)
puts "\nremoving\n" << graph.triples("The Papers of Samuel Tilden", "Written By", "samuel_tilden").to_s
graph.remove("The Papers of Samuel Tilden", "Written By", "samuel_tilden")
puts "\nremaining triples"
puts graph.triples("The Papers of Samuel Tilden", nil, nil)

puts "\nall triples"
puts graph.triples(nil, nil, nil)
=end

graph.load('./data/movies.csv')
puts "\nall triples"
puts graph.triples(nil, nil, "/en/roger_moore")

