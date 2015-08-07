module Iterator

  ##
  # traverses breadth first through
  # a tree using a loop and queue 

  def bfs_each(&block)
    queue = Queue.new
    queue << self

    until queue.empty?
      tree = queue.pop
      block.call(tree.value, tree, self)
      tree.children.each do |t|
        queue << t if !t.nil?
      end
    end

    return self
  end

  ##
  # traverses bread first and tracks
  # the level changes as the the tree
  # grows

  def bfs_each_with_level(&block)
    curr_depth = 0
    next_lvl_count = 0
    curr_lvl_count = 1 # for root

    bfs_each do |_, tree|

      # counts children queued
      next_lvl_count += tree.child_count()
      # decrement count for current tree 
      curr_lvl_count -= 1

      handle_action(tree, curr_depth + 1, &block)

      if curr_lvl_count == 0
        curr_depth += 1

        # update level change count down
        curr_lvl_count = next_lvl_count
        next_lvl_count = 0
      end

    
    end
    self
  end

  ## 
  # an iterative pre-order depth first traversal


  def pre_each(&block)
    arr_stack = [self]

    until arr_stack.empty?
      tree = arr_stack.pop

      handle_action(tree, &block)

      tree.children.each do |t|
        arr_stack.push(t) if !t.nil?
      end 

    end

    return self
  end

  ##
  # an in order depth first iteration through the tree

  def each(&block)
    arr_stack = []
    tree = self

    until arr_stack.empty? && tree.nil?
      if tree
        arr_stack.push(tree)
        tree = tree.left
      else
        tree = arr_stack.pop()
        handle_action(tree, &block)
        tree = tree.right
      end
    end

    return self
  end

  ##
  # a post-order depth first traversal of the tree

  def post_each(&block)
    arr_stack = []
    tree = self
    prev_tree = nil

    until arr_stack.empty? && tree.nil?
      if tree
        arr_stack.push(tree)
        tree = tree.left
      else
        tree = arr_stack.last
        if !tree.right || tree.right == prev_tree
          handle_action(tree, &block)
          arr_stack.pop()
          prev_tree = tree
          tree = nil
        else
          tree = tree.right
        end
      end
    end

    self
  end

  private

  def handle_action(tree, *args, &block)
    norm_args = [tree.value, tree, self].concat(args)
    block.call(*norm_args)
  end

end