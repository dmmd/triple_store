
module SimpleGraph
  class Graph
    def initialize
      @spo = Hash.new
      @pos = Hash.new
      @osp = Hash.new
      puts "graph initialized"
    end

    def add(sub, pred, obj)
      add_to_index(@spo, sub, pred, obj)
      add_to_index(@pos, pred, obj, sub)
      add_to_index(@osp, obj, sub, pred)
    end

    def add_to_index(index, a, b, c)
      if ! index.include? a
        index[a] = {b => [c]}
      elsif ! index[a].include? b
        index[a][b] = [c]
      else
        index[a][b].push(c)
      end
    end

    def inspect
      puts "SPO: " << @spo.to_s
      puts "POS: " << @pos.to_s
      puts "OSP: " << @osp.to_s
    end
  end
end
