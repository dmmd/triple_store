
module SimpleGraph
  class Graph
    attr_accessor :spo, :pos, :osp

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

    def remove(sub, pred, obj)
      
    end
    
    def remove_from_index(sub, pred, obj)
    end
    
    def inspect
      puts "SPO: " << @spo.to_s
      puts "POS: " << @pos.to_s
      puts "OSP: " << @osp.to_s
    end
    
    def triples(sub, pred, obj)
      if sub != nil
        if pred != nil
          if obj != nil
            if spo[sub][pred].include? obj
              puts [sub,obj,pred]
            end
          end
        end
      elsif pred != nil
        puts "predicate found"
      elsif obj != nil
        puts "object found"
      end
    end
  end
end
