# frozen_string_literal: true

# Single node of a linked list
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

# Entire linked list
class LinkedList
  attr_reader :head, :tail, :size

  # May be initialized with zero or one starting values
  def initialize(value = nil)
    @head = Node.new
    @tail = Node.new
    @size = 0

    append(value) unless value.nil?
  end

  # Adds a new node the end of the list and returns it
  def append(value)
    @size += 1

    if @head.value.nil? && @head.next_node.nil?
      @head = Node.new(value)
      @tail = @head
    else
      @tail.next_node = Node.new(value)
      @tail = @tail.next_node
    end

    @tail
  end

  # Adds a new node to the start of the list and returns it
  def prepend(value)
    @size += 1

    if @head.value.nil? && @head.next_node.nil?
      @head = Node.new(value)
      @tail = @head
    else
      @head = Node.new(value, @head)
    end

    @head
  end

  # Returns a node at a certain index, or an empty node if out of bounds
  def at(index)
    return Node.new if index >= @size

    current_node = @head
    index.times { current_node = current_node.next_node }
    current_node
  end

  # Removes a node from the top and returns its value
  def pop
    return if @size.zero?

    val = @tail.value

    if @size == 1
      @head = Node.new
      @tail = Node.new
    else
      current_node = @head
      current_node = current_node.next_node while current_node.next_node != @tail

      @tail = current_node
      @tail.value = current_node.value
      @tail.next_node = nil
    end

    @size -= 1
    val
  end

  # Returns true if value is in the list, false otherwise
  def contains?(value)
    current_node = @head
    until current_node.nil?
      return true if value == current_node.value

      current_node = current_node.next_node
    end

    false
  end

  # Returns index of node containing value or nil if not found
  def find(value)
    return nil if @size.zero?

    current_node = @head
    index = 0
    until current_node.nil?
      return index if value == current_node.value

      current_node = current_node.next_node
      index += 1
    end

    nil
  end

  # Inserts a new node with value at a given index and returns it
  # If index >= @size, inserts at @tail
  def insert_at(value, index)
    return if index.negative?
    return prepend(value) if index.zero?
    return append(value) if index >= @size

    @size += 1

    current_node = @head
    (index - 1).times { current_node = current_node.next_node }
    next_node = current_node.next_node

    new_node = Node.new(value)
    current_node.next_node = new_node
    new_node.next_node = next_node
    new_node
  end

  # Removes node at a given index and returns its value
  # If index >= @size, does nothing
  def remove_at(index)
    return if index.negative? || index >= @size
    return pop if index == @size - 1

    @size -= 1

    current_node = @head.next_node
    previous_node = @head
    (index - 1).times do
      previous_node = current_node
      current_node = current_node.next_node
    end

    previous_node.next_node = current_node.next_node
    current_node.value
  end

  def to_s
    return 'nil' if @size.zero?

    current_node = @head
    result = ''

    until current_node.nil?
      result += "(#{current_node.value}) -> "
      current_node = current_node.next_node
    end

    "#{result}nil"
  end
end

# RSpec? Never heard of it.
# Uncomment the block below for "testing".

=begin

list = LinkedList.new
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}"
puts "At index 0: #{list.at(0).value}"
puts "Contains 1: #{list.contains?(1)}"
puts "Index of 1: #{list.find(1)}\n\n"
list.append(123)
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}"
puts "At index 0: #{list.at(0).value}"
puts "Contains 1: #{list.contains?(1)}"
puts "Contains 123: #{list.contains?(123)}"
puts "Index of 1: #{list.find(1)}"
puts "Index of 123: #{list.find(123)}\n\n"
list.append(456)
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"
list.prepend(1)
puts list
list.prepend(2)
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}"

p "At index 0: #{list.at(0).value}"
p "At index 1: #{list.at(1).value}"
p "At index 2: #{list.at(2).value}"
p "At index 3: #{list.at(3).value}"
p "At index 4: #{list.at(4).value}"
p "At index 10: #{list.at(10).value}"

puts "Contains 1: #{list.contains?(1)}"
puts "Contains 2: #{list.contains?(2)}"
puts "Contains 3: #{list.contains?(3)}"
puts "Contains 123: #{list.contains?(123)}"
puts "Contains 456: #{list.contains?(456)}"

puts "Index of 1: #{list.find(1)}"
puts "Index of 2: #{list.find(2)}"
puts "Index of 3: #{list.find(3)}"
puts "Index of 123: #{list.find(123)}"
puts "Index of 456: #{list.find(456)}"

puts '---------------------------------------------------------'

puts list.pop
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"
puts list.pop
puts list.pop
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"
puts list.pop
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"
list.prepend('b')
list.prepend('a')
list.append('c')
list.append('d')
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}"
puts "At index 2: #{list.at(2).value}"
puts "Contains 'a': #{list.contains?('a')}"
puts "Contains 'b': #{list.contains?('b')}"
puts "Contains 'c': #{list.contains?('c')}"
puts "Contains 'd': #{list.contains?('d')}"
puts "Contains 'e': #{list.contains?('e')}"
puts "Index of 'a': #{list.find('a')}"
puts "Index of 'b': #{list.find('b')}"
puts "Index of 'c': #{list.find('c')}"
puts "Index of 'd': #{list.find('d')}"
puts "Index of 'e': #{list.find('e')}"

puts '---------------------------------------------------------'

puts list
list.insert_at(0, 0)
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"
list.insert_at(1, 100)
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"
list.insert_at(20, 2)
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"

puts "Removed at index 2, return: #{list.remove_at(2)}"
puts "Removed at index 2, return: #{list.remove_at(2)}"
puts "Removed at index 2, return: #{list.remove_at(2)}"
puts "Removed at index 2, return: #{list.remove_at(2)}"
puts "Removed at index 2, return: #{list.remove_at(2)}"
puts "Removed at index 2, return: #{list.remove_at(2)}"
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"

puts "Popped, return: #{list.pop}"
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"

puts "Removed at index 0, return: #{list.remove_at(0)}"
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"

puts "Popped, return: #{list.pop}"
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}\n\n"

=end
