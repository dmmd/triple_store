
module SimpleGraph
  class Graph
    attr_accessor :spo, :pos, :osp

    def initialize
      @spo = Hash.new
      @pos = Hash.new
      @osp = Hash.new
      puts "graph initialized\n"
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
     triples(sub, pred, obj).each{|triple|
       remove_from_index(@spo, triple.sub, triple.pred, triple.obj)
       remove_from_index(@pos, triple.pred, triple.obj, triple.sub)
       remove_from_index(@osp, triple.obj, triple.sub, triple.pred)
     }
    end
    
    def remove_from_index(index, a, b, c)
      #sigh
    end
    
    def inspect
      puts "SPO: " << @spo.to_s
      puts "POS: " << @pos.to_s
      puts "OSP: " << @osp.to_s
    end
    
    def triples(sub, pred, obj)
      result = Array.new
      if sub != nil
        if pred != nil
          if obj != nil
            if spo[sub][pred].include? obj
              #puts "subject predicate and object"
              result.push ["sub".to_sym => sub, "pred".to_sym => pred, "obj".to_sym => obj]
            end
          else
            #puts "subject and predicate"
            spo[sub][pred].each{|x| 
              result.push ["sub".to_sym => sub, "pred".to_sym => pred, "obj".to_sym => x]
            }
          end  
        else
          #puts "subject only"
          spo[sub].each{|x|
            pred = x[0]
            x[1].each{|y| 
              result.push ["sub".to_sym => sub, "pred".to_sym => pred, "obj".to_sym => y ]
            } 
          }
        end
      elsif pred != nil
        puts "predicate found"
      elsif obj != nil
        puts "object found"
      end
      return result
    end
  end
end
