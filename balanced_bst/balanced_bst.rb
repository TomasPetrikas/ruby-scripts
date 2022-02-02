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
    array = []
    queue = []
    queue << @root

    until queue.empty?
      node = queue.shift
      block_given? ? (yield node) : array << node.value
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end

    array unless block_given?
  end

  def preorder(node = @root, array = [], &block)
    block_given? ? (yield node) : array << node.value
    preorder(node.left, array, &block) unless node.left.nil?
    preorder(node.right, array, &block) unless node.right.nil?

    array unless block_given?
  end

  def inorder(node = @root, array = [], &block)
    inorder(node.left, array, &block) unless node.left.nil?
    block_given? ? (yield node) : array << node.value
    inorder(node.right, array, &block) unless node.right.nil?

    array unless block_given?
  end

  def postorder(node = @root, array = [], &block)
    postorder(node.left, array, &block) unless node.left.nil?
    postorder(node.right, array, &block) unless node.right.nil?
    block_given? ? (yield node) : array << node.value

    array unless block_given?
  end

  # Returns the height of a node
  # Height is the number of edges in longest path from a given node to a leaf node
  def height(node = @root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    left_height > right_height ? left_height + 1 : right_height + 1
  end

  # Returns the depth of a node, or -1 if the node is not in the tree
  # Depth is the number of edges in path from a given node to the tree's root node
  def depth(node)
    depth_search(@root, node, 0)
  end

  def balanced?(node = @root)
    return true if node.nil?

    # Left and right subtree heights
    lh = height(node.left)
    rh = height(node.right)

    return true if (lh - rh).abs <= 1 && balanced?(node.left) && balanced?(node.right)

    false
  end

  def rebalance
    @root = build_tree(inorder.sort.uniq)
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

  def depth_search(current_node, searched_node, level)
    return -1 if current_node.nil?
    return level if current_node.value == searched_node.value

    down_level = depth_search(current_node.left, searched_node, level + 1)
    return down_level if down_level != -1

    depth_search(current_node.right, searched_node, level + 1)
  end
end

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
puts "Is the tree balanced? #{tree.balanced?}"
print "Level order: #{tree.level_order}\n"
print "Preorder: #{tree.preorder}\n"
print "Inorder: #{tree.inorder}\n"
print "Postorder: #{tree.postorder}\n"

5.times { |i| tree.insert(200 + i) }
tree.pretty_print
puts "Is the tree balanced? #{tree.balanced?}"

tree.rebalance
tree.pretty_print
puts "Is the tree balanced? #{tree.balanced?}"
print "Level order: #{tree.level_order}\n"
print "Preorder: #{tree.preorder}\n"
print "Inorder: #{tree.inorder}\n"
print "Postorder: #{tree.postorder}\n"

# More testing
=begin

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

p tree.level_order
tree.level_order { |node| print "#{node.value}, " }
puts ''
p tree.preorder
tree.preorder { |node| print "#{node.value}, " }
puts ''
p tree.inorder
tree.inorder { |node| print "#{node.value}, " }
puts ''
p tree.postorder
tree.postorder { |node| print "#{node.value}, " }
puts ''

puts "The height of this tree is #{tree.height}"
puts "The height of node 4 is #{tree.height(tree.find(4))}"
puts "The height of node 67 is #{tree.height(tree.find(67))}"
puts "The depth of 23 is #{tree.depth(tree.find(23))}"
puts "The depth of 7 is #{tree.depth(tree.find(7))}"
puts "The depth of 9 is #{tree.depth(tree.find(9))}"

puts "Is the tree balanced? #{tree.balanced?}\n\n"

tree2 = Tree.new([1])
tree2.root.left = Node.new(2)
tree2.root.right = Node.new(3)
tree2.root.left.left = Node.new(4)
tree2.root.left.right = Node.new(5)
tree2.root.left.left.left = Node.new(8)
tree2.pretty_print
puts "The height of this tree is #{tree2.height}"
puts "Is the tree balanced? #{tree2.balanced?}\n\n"

tree2.rebalance
tree2.pretty_print
puts "The height of this tree is #{tree2.height}"
puts "The height of node 5 is #{tree2.height(tree2.find(5))}"
puts "Is the tree balanced? #{tree2.balanced?}\n\n"

=end
