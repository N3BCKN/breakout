class Ball
  attr_accessor :x_velocity, :y_velocity
  attr_reader :x, :y 

  def initialize
    reset
  end 

  def draw
    Circle.new(x: @x, y: @y, radius: 5, color: 'white')
  end

  def move 
    @x += @x_velocity
    @y += @y_velocity

    @x_velocity *= -1 if hit_wall? 

    if hit_top?
      @x_velocity *= -1
      @y_velocity *= -1
    end 
  end

  def reset
    @x = WIDTH /  2
    @y = HEIGHT - HEIGHT / 2.5 
    @x_velocity = 0
    @y_velocity = 3
  end

  def hit_bottom?
    @y >= HEIGHT
  end

  private
  def hit_wall? 
    @x >= WIDTH || @x <= 0 
  end

  def hit_top?
    @y <= 0
  end
end
