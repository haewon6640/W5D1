require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if self.count == num_buckets
      resize!
    end
    if self.include?(key)
      bucket(key).update(key,val)
    else
      self.count = count+1
      bucket(key).append(key,val)
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if self.include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    store.each do |bucket|
      bucket.each do |node|
        prc.call(node.key,node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  attr_accessor :store

  def num_buckets
    @store.length
  end

  def resize!
    arr = Array.new()
    store.each do |bucket|
      bucket.each do |node|
        arr << [node.key, node.val]
      end
    end
    @store = Array.new(num_buckets*2) {LinkedList.new}
    arr.each do |key, val|
      bucket(key).append(key, val)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
