class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    previous_node = self.prev
    next_node = self.next
    previous_node.next = next_node
    next_node.prev = previous_node
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    get_node(key).nil? ? nil: get_node(key).val
  end

  def include?(key)
    !get_node(key).nil?
  end

  def append(key, val)
    last_node = last
    new_node = Node.new(key,val)
    last_node.next = new_node
    new_node.prev = last_node
    new_node.next = tail
    tail.prev = new_node
    new_node
  end
  
  def append_node(node)
    last_node = last
    new_node = node
    last_node.next = new_node
    new_node.prev = last_node
    new_node.next = tail
    tail.prev = new_node
    new_node
  end

  def update(key, val)
    updating_node = get_node(key)
    return nil if updating_node.nil?
    updating_node.val = val
  end

  def remove(key)
    get_node(key).remove
  end

  def each(&prc)
    node = first
    while node != tail
      prc.call(node)
      node = node.next
    end
    node
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private
  attr_reader :head, :tail
  def get_node(key)
    node = first
    until node == tail
      return node if node.key == key
      node = node.next
    end
    nil
  end
end
