require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(@map[key])
    else
      @map[key] = calc!(key)
      if @store.count > @max
        eject!
      end
    end
    @map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @store.append(key,@prc.call(key))
    # if @store.count > @max
    #   eject!
    # end
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @store.append_node(node)
  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.remove
  end
end
