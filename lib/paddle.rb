class Paddle
  def initialize
    @x = WIDTH / 2 
    @y = HEIGHT - 10
  end 

  def move_left
    @x -= 9 unless @x - 9 <= 0 
  end 

  def move_right
    @x += 9 unless @x + 49 >= WIDTH 
  end

  def draw 
    Rectangle.new(x: @x, y: @y, width: 40, height: 10, color: 'red')
  end

  def mid_position
    @x + 20 
  end

  def hit_ball?(x,y)
    draw.contains?(x,y)
  end
end 
