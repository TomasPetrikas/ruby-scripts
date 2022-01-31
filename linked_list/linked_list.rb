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

      # p "Tail: #{tail.value} #{tail.next_node}"
      # p "Curr: #{current_node.value} #{current_node.next_node}"

      @tail = current_node
      @tail.value = current_node.value
      @tail.next_node = nil

      # p "Tail: #{tail.value} #{tail.next_node}"
      # p "Curr: #{current_node.value} #{current_node.next_node}"
    end

    @size -= 1
    val
  end

  def contains?(value)
    # TODO
  end

  def find(value)
    # TODO
  end

  def insert_at(value, index)
    # TODO
  end

  def remove_at(index)
    # tODO
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

list = LinkedList.new
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}"
puts "At index 0: #{list.at(0).value}\n\n"
list.append(123)
puts list
puts "List size: #{list.size}"
puts "List head: #{list.head.value}"
puts "List tail: #{list.tail.value}"
puts "At index 0: #{list.at(0).value}\n\n"
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
puts "At index 2: #{list.at(2).value}\n\n"
