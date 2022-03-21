class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max,false)
    @max = max
  end

  def insert(num)
    unless num.between?(0,@max)
      raise "Out of bounds"
    end
    store[num] = true
  end

  def remove(num)
    store[num] = false
  end

  def include?(num)
    store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  attr_reader :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    
    if self.count == num_buckets
      resize!
    end
    unless self.include?(num)
      self.count = count+1
      self[num] << num
    end

  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      self.count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  attr_accessor :store
  attr_writer :count
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    #store all elements inside another 1d array
    # resize store 
    # refill store
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
    p "Length #{num_buckets}, Store #{store}"
  end
end
