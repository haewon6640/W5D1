class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if self.count == num_buckets
      resize!
    end
    unless self.include?(key)
      self.count = count+1
      self[key] << key
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key)
      self.count -= 1
    end
  end

  private
  attr_accessor :store
  attr_writer :count

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    arr = Array.new()
    store.each do |bucket|
      bucket.each do |num|
        arr << num
      end
    end
    self.store = Array.new(num_buckets*2) {Array.new}
    arr.each do |num|
      self[num] << num
    end
  end
end
