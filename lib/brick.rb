class Brick
  attr_reader :x, :y, :shape
  
  def initialize(x, y, color)
    @x = x 
    @y = y
    @color = color  
  end

  def draw
    @shape = Rectangle.new(x: @x, y: @y, width: 47 , height: 19, color: @color)
  end
end
