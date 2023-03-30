require 'pry'

class Cube
  attr_accessor :cube
  TOP = 0
  LEFT = 1
  FRONT = 2
  RIGHT = 3
  REAR = 4
  BOTTOM = 5
  
  def initialize(cube)
    @cube = cube
  end

  def rotate_x_clockwise(layer_number)
    cube_dup = Marshal.load(Marshal.dump(cube))
    [[FRONT, RIGHT], [RIGHT, REAR], [REAR, LEFT], [LEFT, FRONT]].each do |side_a, side_b|
      swap_x(side_a, side_b, layer_number, cube_dup)
    end
  end

  def rotate_x_counter_clockwise(layer_number)
    cube_dup = Marshal.load(Marshal.dump(cube))
    [[FRONT, LEFT], [RIGHT, FRONT], [REAR, RIGHT], [LEFT, REAR]].each do |side_a, side_b|
      swap_x(side_a, side_b, layer_number, cube_dup)
    end
  end

  def rotate_y_clockwise(layer_number)
    cube_dup = Marshal.load(Marshal.dump(cube))
    [[FRONT, TOP], [TOP, REAR], [BOTTOM, FRONT], [REAR, BOTTOM]].each do |side_a, side_b|
      swap_y(side_a, side_b, layer_number, cube_dup)
    end
  end

  def rotate_y_counter_clockwise(layer_number)
    cube_dup = Marshal.load(Marshal.dump(cube))
    [[FRONT, BOTTOM], [TOP, FRONT], [REAR, TOP], [REAR, BOTTOM]].each do |side_a, side_b|
      swap_y(side_a, side_b, layer_number, cube_dup)
    end
  end

  def solved?
    (0..5).each_with_index do |_, i|
       cube_length = cube[i].flatten.uniq.length
       if cube_length != 1
       return false
     end
    end
    true
  end

  # U – Rotate the top layer of the cube clockwise
  # D – Rotate the bottom layer of the cube clockwise
  # F – Rotate the front layer of the cube clockwise
  # B – Rotate the back layer of the cube clockwise
  # R – Rotate the right layer of the cube clockwise
  # L – Rotate the left layer of the cube clockwise

  def top_layer_sequence
    self.rotate_y_clockwise(2)
    self.rotate_x_clockwise(2)
    self.rotate_y_clockwise(2)
    self.rotate_x_clockwise(2)
  end

  def top_layer_sequence_top
    self.rotate_y_clockwise(2)
    self.rotate_x_clockwise(2)
    self.rotate_y_clockwise(2)
  end

  def white_cross?
    (0..5).each do |i|
      result = (cube[i][1][0] == :w) &&
      (cube[i][0][1] == :w) && (cube[i][1][1] == :w) &&
      (cube[i][2][1] == :w) && (cube[i][1][2] == :w)

      if result && i == 0
        # self.rotate_y_clockwise(2)
        # self.rotate_x_clockwise(2)
        # binding.pry
        return result
      end
    end
    false
  end

  def print_cube
    puts "--- TOP ----"
    printf("%s\n", cube[0][0])
    printf("%s\n", cube[0][1])
    printf("%s\n", cube[0][2])

    puts "--- LEFT ----"
    printf("%s\n", cube[1][0])
    printf("%s\n", cube[1][1])
    printf("%s\n", cube[1][2])

    puts "--- FRONT ---"
    printf("%s\n", cube[2][0])
    printf("%s\n", cube[2][1])
    printf("%s\n", cube[2][2])

    puts "--- RIGHT ---"
    printf("%s\n", cube[3][0])
    printf("%s\n", cube[3][1])
    printf("%s\n", cube[3][2])

    puts "--- BACK ---"
    printf("%s\n", cube[4][0])
    printf("%s\n", cube[4][1])
    printf("%s\n", cube[4][2])

    puts "---BOTTOM ---"
    printf("%s\n", cube[5][0])
    printf("%s\n", cube[5][1])
    printf("%s\n", cube[5][2])
  end
  
  private

  def swap_x(side_a, side_b, layer_number, cube_dup)
    self.cube[side_a][layer_number][0] = cube_dup[side_b][layer_number][0]
    self.cube[side_a][layer_number][1] = cube_dup[side_b][layer_number][1]
    self.cube[side_a][layer_number][2] = cube_dup[side_b][layer_number][2]
  end

  def swap_y(side_a, side_b, layer_number, cube_dup)
    self.cube[side_a][0][layer_number] = cube_dup[side_b][0][layer_number]
    self.cube[side_a][1][layer_number] = cube_dup[side_b][1][layer_number]
    self.cube[side_a][2][layer_number] = cube_dup[side_b][2][layer_number]
  end
end
  
  cube_maxtrix_large = [
    # TOP
    [
      [:r, :r, :r],
      [:r, :r, :r],
      [:r, :r, :r],
    ],
    # LEFT
    [
      [:y, :y, :y],
      [:y, :y, :y],
      [:y, :y, :y],
    ],
    # FRONT
    [
      [:b, :b, :b],
      [:b, :b, :b],
      [:b, :b, :b],
    ],
    # RIGHT
    [
      [:w, :w, :w],
      [:w, :w, :w],
      [:w, :w, :w],
    ],
    # REAR
    [
      [:g, :g, :g],
      [:g, :g, :g],
      [:g, :g, :g],
    ],
    # BOTTOM
    [
      [:o, :o, :o],
      [:o, :o, :o],
      [:o, :o, :o],
    ]
  ]
  
  cube_maxtrix_small = [
    # TOP
    [
      [:r, :r],
      [:r, :r],
    ],
    # LEFT
    [
      [:y, :y],
      [:y, :y],
    ],
    # FRONT
    [
      [:b, :b],
      [:b, :b],
    ],
    # RIGHT
    [
      [:w, :w],
      [:w, :w],
    ],
    # REAR
    [
      [:g, :g],
      [:g, :g],
    ],
    # BOTTOM
    [
      [:o, :o],
      [:o, :o],
    ]
  ]


# sleep 5
cube = Cube.new(cube_maxtrix_large)
puts "randomizing cube"

(0..500).each do |i|
  binary_choice = rand(0..1)
  layer_number = rand(0..2)

  if binary_choice == 0
    cube.rotate_x_clockwise(layer_number)
  else
    cube.rotate_y_clockwise(layer_number)
  end
end

puts cube.print_cube
# sleep 5
puts "solving cube"

count = 1

MAX = 3
x_c_count = 0
y_c_count = 0 
x_cc_count = 0
y_cc_count = 0

while(true)
  binary_choice = rand(0..3)
  layer_number = rand(0..2)

  if binary_choice == 0
    if x_c_count > MAX
      x_c_count = 0
    else
      cube.rotate_x_clockwise(layer_number)
      x_c_count += 1
    end

  elsif binary_choice == 1
    if y_c_count > MAX
      y_c_count = 0
    else
      cube.rotate_y_clockwise(layer_number)
      y_c_count += 1
    end

  elsif binary_choice == 2
    if x_cc_count > MAX
      x_cc_count = 0
    else
      cube.rotate_x_counter_clockwise(layer_number)
      x_cc_count += 1
    end
  elsif binary_choice == 3
    if y_cc_count > MAX
      y_cc_count = 0
    else
      cube.rotate_y_counter_clockwise(layer_number)
      y_cc_count += 1
    end
  else
    throw "error"
  end

  if cube.solved?
    puts count
    puts "Solved!"
    cube.print_cube
    break
  end

  # if cube.white_cross?
  #   puts "HERE"
  #   puts count
  #   cube.print_cube
  #   break
  # end

  if count % 100_000 == 0
    puts count.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1_")
  end

  count += 1
end
