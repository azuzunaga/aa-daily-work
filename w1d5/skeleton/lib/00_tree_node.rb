class PolyTreeNode
  attr_accessor :parent
  attr_reader :value, :children

  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end


  def parent=(node)
    parent.children.delete(self) unless parent.nil?
    @parent = node
    parent.children << self unless parent.nil? || parent.exists(self)
  end

  def inspect
    value
  end

  def exists(child)
    children.include?(child)
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    if exists(node)
      node.parent = nil
      # children.delete(node)
    else
      raise_error
    end
  end

  def dfs(target_value)
    return self if self.value == target_value
    return nil if children.empty?

    children.each do |child|

      found = child.dfs(target_value)
      return found if found
    end

    nil
  end

  def bfs(target_value)

    queue = []
    queue.unshift(self)
    until queue.empty?
      if queue.last.value == target_value
        return queue.last
      else
        queue = queue.last.children.reverse + queue
        queue.pop
      end
    end
    nil
  end

end
