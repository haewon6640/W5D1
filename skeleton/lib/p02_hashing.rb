class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.to_s.hash
  end
end

class String
  def hash
    num = 0
    multiplier = 1
    self.each_char do |char|
      num += char.ord * multiplier
      multiplier += 1
    end
    num
  end 
 
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = []
    self.each do |key,val|
      arr << [key, val]
    end
    arr.sort.hash
  end
end
