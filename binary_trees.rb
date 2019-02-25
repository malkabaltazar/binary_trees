class Tree
  def build_tree_presorted(arr, parent_node = nil) # Does it really work?
    if arr.length < 1
      return
    elsif arr.length < 2
      new_node = Node.new(arr[0], parent_node)
    else
      i = arr.length/2.to_i
      new_node = Node.new(arr[i], parent_node)
      new_node.left_child = build_tree_presorted(arr[0..i-1], new_node)
      new_node.right_child = build_tree_presorted(arr[i+1..-1], new_node)
    end
  end

  def build_tree(arr)
    @root = Node.new(arr[0]); arr.shift
    arr.each do |i|
      parent_node = @root
      loop do
        if i < parent_node.value
          if parent_node.left_child.nil?
            parent_node.left_child = Node.new(i, parent_node); break
          else
            parent_node = parent_node.left_child
          end
        else
          if parent_node.right_child.nil?
            parent_node.right_child = Node.new(i, parent_node); break
          else
            parent_node = parent_node.right_child
          end
        end
      end
    end
  end

  def breadth_first_search(target)
    return if @root == nil
    queue = [@root]
    queue.each do |node|
      return node if node.value == target
      queue.push(node.left_child) if node.left_child != nil
      queue.push(node.right_child) if node.right_child != nil
    end
    return nil
  end

  def depth_first_search(target)
    return if @root == nil
    stack = [@root]
    until stack.empty?
      node = stack.shift
      return node.value if node.value == target
      stack.unshift(node.left_child) unless node.left_child.nil?
      stack.unshift(node.right_child) unless node.right_child.nil?
    end
    return nil
  end

  def dfs_rec(target, node = @root)
    return node.value if node.value == target
    dfs_rec(target, node.left_child) unless node.left_child.nil?
    dfs_rec(target, node.right_child) unless node.right_child.nil?
  end
end

class Node
  attr_accessor :value, :parent_node, :left_child, :right_child

  def initialize(value = nil, parent_node = nil, left_child = nil,
    right_child = nil)
    @value = value
    @parent_node = parent_node
    @left_child = left_child
    @right_child = right_child
  end
end

my_tree = Tree.new
my_tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
