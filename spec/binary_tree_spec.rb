require "./lib/binary_tree.rb"

describe "BinaryTree" do

  describe "#attr_accessors" do

    it "should have :value and :value=" do
      tree = BinaryTree.new
      expect(tree).to respond_to(:value)
      expect(tree).to respond_to(:value=)
    end


    it "should have :left and :left=" do
      tree = BinaryTree.new
      expect(tree).to respond_to(:left)
      expect(tree).to respond_to(:left=)
    end

    it "should have :right and :right=" do
      tree = BinaryTree.new
      expect(tree).to respond_to(:right)
      expect(tree).to respond_to(:right=)
    end

  end

  describe "#new" do 

    it "should accept a value" do
      tree = BinaryTree.new(5)
      expect(tree.value).to eql(5)
    end

  end

  describe "#insert" do

    before(:each) do 
      @tree = BinaryTree.new 
    end

    it "should update the :value if nil" do
      @tree.insert(5)
      expect(@tree.value).to eql(5)
    end

    it "should insert to the left for less than values" do
      @tree.insert(5)
      @tree.insert(4)
      left = @tree.left
      expect(left.value).to eql(4)
    end

    it "should insert to the right for greater than values" do
      @tree.insert(5)
      @tree.insert(6)
      right = @tree.right
      expect(right.value).to eql(6)
    end

    it "should return instance after insert" do
      return_val = @tree.insert(4)
      expect(return_val).to eql(@tree)
    end

  end

  describe "#height" do

    before(:each) do
      @tree = BinaryTree.new(50)
      @tree.insert(25).insert(75)
      @tree.insert(13).insert(37)
      @tree.insert(63).insert(87)
    end

    it "should consider a leaf as height 0" do
      @tree = BinaryTree.new(5)
      expect(@tree.height).to eql(0)
    end

    it "should find the height of balanced tree" do
      expect(@tree.height).to eql(2)
    end

    it "should find the height of left heavy tree" do
      @tree.insert(36)
      expect(@tree.height).to eql(3)
    end

    it "should find the height of right heavy tree" do
      @tree.insert(64)
      expect(@tree.height).to eql(3)
    end

  end

  describe "#include?" do

    before(:each) do
      @tree = BinaryTree.new(50)
      @tree.insert(25).insert(75)
      @tree.insert(13).insert(37)
      @tree.insert(63).insert(87)
    end

    it "should take the max height" do
      aggregate_failures("inclusions") do
        expect(@tree.include?(63)).to be(true)
        expect(@tree.include?(37)).to be(true)
        expect(@tree.include?(10)).to be(false)
      end
    end
  end

  describe "#leaf?" do

    before(:each) do
      @tree = BinaryTree.new(5)
    end

    it "should return true tree with no left and right trees" do
      expect(@tree.leaf?).to be(true)
    end

    it "should return false for tree with subtree" do
      @tree.insert(4)
      expect(@tree.leaf?).to be(false)
    end

  end

  describe "#to_arr" do

    before(:each) do
      @tree = BinaryTree.new(50)
      @tree.insert(25).insert(75)
      @tree.insert(13).insert(37)
      @tree.insert(63).insert(87)
    end

    it "should be return a sorted arr" do
      result = @tree.to_arr
      expect(result).to eql([13, 25, 37, 50, 63, 75, 87])
    end

  end

  describe "#get_first" do

    before(:each) do
      @tree = BinaryTree.new(50)
      @tree.insert(25).insert(75)
      @tree.insert(13).insert(37)
      @tree.insert(63).insert(87)
      @tree.insert(99).insert(88)
      @tree.insert(100).insert(99)
      @tree.insert(23).insert(11)
      @tree.insert(13)
    end

    it "should get closest subtree with matching value" do
      result_one = @tree.get_first(99)
      result_two = @tree.get_first(13)
      aggregate_failures("closeness properties") do
        expect(@tree.get_first(25)).to be(@tree.left)
        expect(@tree.get_first(75)).to be(@tree.right)
        expect(result_one.include?(99)).to be(true)
        expect(result_two.include?(13)).to be(true)
      end

    end

  end


  describe "levels" do

    before(:each) do
      @tree = BinaryTree.new(50)
      @tree.insert(25).insert(75)
      @tree.insert(13).insert(37)
      @tree.insert(63).insert(87)
    end

    it "should print out the appropriate levels" do
      levels = @tree.levels
      
      aggregate_failures "check each level" do
        expect(levels[1]).to eql([50])
        expect(levels[2]).to eql([25,75])
        expect(levels[3]).to eql([13, 37, 63, 87])
      end

    end

  end

end