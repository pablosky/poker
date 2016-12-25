class CycleList
  attr_accessor :nodes
  def initialize(nodes) #nodes is an array of nodes
    @nodes = create_list(nodes)
  end

  def create_list(nodes)
    node_list = []
    nodes.each do |node|
      node_list << Node.new(node)
    end
    for i in 0..(nodes.size - 1)
      if i !=  nodes.size - 1
        node_list[i].next = node_list[i + 1]   #if its different from the last
      else
        node_list[i].next = node_list.first
      end
    end
    node_list
  end

  def cycle_run
    
  end

end
