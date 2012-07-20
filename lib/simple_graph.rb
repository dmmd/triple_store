require 'csv'

module SimpleGraph
  class Graph
    attr_accessor :spo, :pos, :osp

    def initialize
      @spo = Hash.new
      @pos = Hash.new
      @osp = Hash.new
      puts "graph initialized\n"
    end

    def add(subj, pred, obj)
      add_to_index(@spo, subj, pred, obj)
      add_to_index(@pos, pred, obj, subj)
      add_to_index(@osp, obj, subj, pred)
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
       remove_from_index(@spo, triple[0][:subj], triple[0][:pred], triple[0][:obj])
       remove_from_index(@pos, triple[0][:pred], triple[0][:obj], triple[0][:subj])
       remove_from_index(@osp, triple[0][:obj], triple[0][:subj], triple[0][:pred])
     }
    end
    
    def remove_from_index(index, a, b, c)
      bset = index[a]
      cset = bset[b]      
      cset.slice! cset.index c
    end
    
    def inspect
      puts "SPO: " << @spo.to_s
      puts "POS: " << @pos.to_s
      puts "OSP: " << @osp.to_s
    end
    
    def triples(subj, pred, obj)
      result = Array.new
      if subj != nil
        if pred != nil
          if obj != nil
            if spo[subj][pred].include? obj
              #puts "subject predicate and object"
              result.push ["subj".to_sym => subj, "pred".to_sym => pred, "obj".to_sym => obj]
            end
          else
            #puts "subject and predicate"
            spo[subj][pred].each{|x| 
              result.push ["subj".to_sym => subj, "pred".to_sym => pred, "obj".to_sym => x]
            }
          end  
        else
          #puts "subject only"
          spo[subj].each{|x|
            pred = x[0]
            x[1].each{|y| 
              result.push ["subj".to_sym => subj, "pred".to_sym => pred, "obj".to_sym => y ]
            } 
          }
        end
      elsif pred != nil
        if obj != nil
          pos[pred][obj].each{|x|
            result.push ["subj".to_sym => x, "pred".to_sym => pred, "obj".to_sym => obj]
          }
        else 
          pos[pred].each{|x|
            obj = x[0]
            x[1].each{|y|
              result.push ["subj".to_sym => y, "pred".to_sym => pred, "obj".to_sym => obj]
            }
          }
        end
      elsif obj != nil
        osp[obj].each{|x|
          subj = x[0]
          x[1].each{|y|
            result.push ["subj".to_sym => subj, "pred".to_sym => y, "obj".to_sym => obj]
          }
        }
      else
        spo.each{|x|
          subj = x[0]
          x[1].each{|y|
            pred = y[0]
            y[1].each{|z|
              result.push ["subj".to_sym => subj, "pred".to_sym => pred, "obj".to_sym => z]
            }
          }
        }
      end
      return result
    end
    
    def load(filename)
      datas = CSV.read(filename)
      datas.each do |data|
        add(data[0], data[1], data[2])
      end
      puts 'File loaded'
    end
  end
end
