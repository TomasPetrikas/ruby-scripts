# frozen_string_literal: true

# Node of binary tree
class Node
  include Comparable

  attr_accessor :value, :left, :right

  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
  end

  def <=>(other)
    @value <=> other.value
  end
end

# Balanced binary search tree
class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array, start = 0, last = array.size - 1)
    return if start > last

    mid = (start + last) / 2
    root = Node.new(array[mid])

    root.left = build_tree(array, start, mid - 1)
    root.right = build_tree(array, mid + 1, last)

    root
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?
    return node if value == node.value

    if value < node.value
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end

    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)
    else
      # Node with 1 or no children
      if node.left.nil?
        temp = node.right
        node = nil
        return temp
      elsif node.right.nil?
        temp = node.left
        node = nil
        return temp
      end

      # Node with 2 children
      temp = min_value_node(node.right)
      node.value = temp.value
      node.right = delete(temp.value, node.right)
    end

    node
  end

  def find(value, node = @root)
    return Node.new if node.nil?
    return node if node.value == value

    return find(value, node.left) if value < node.value

    find(value, node.right)
  end

  def level_order
    # TODO
  end

  def preorder
    # TODO
  end

  def inorder
    # TODO
  end

  def postorder
    # TODO
  end

  def height
    # TODO
  end

  def depth
    # TODO
  end

  def balanced?
    # TODO
  end

  def rebalance
    # TODO
  end

  # Not mine, from the Odin Project's Discord
  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end

  private

  def min_value_node(node)
    current = node
    current = current.left until current.left.nil?
    current
  end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(arr)

puts "#{tree.root.value}\n\n"
tree.pretty_print

tree.insert(30)
tree.insert(20)
tree.insert(40)
tree.insert(70)
tree.insert(60)
tree.insert(80)
tree.insert(80)

puts "#{tree.root.value}\n\n"
tree.pretty_print

tree.delete(80)
tree.delete(23)
tree.delete(1000)
tree.delete(8)

puts tree.root.value
puts "Found 1: #{tree.find(1).value}"
puts "Found 20: #{tree.find(20).value}"
puts "Found -3: #{tree.find(-3).value}\n\n"
tree.pretty_print
