require 'minitest/autorun'
require_relative 'cube'

class CubeTest < MiniTest::Test
  TOP = 0
  LEFT = 1
  FRONT = 2
  RIGHT = 3
  REAR = 4
  BOTTOM = 5

  def test_cube_has_6_sides
    test_cube = Cube.new
    assert_equal 6, test_cube.cube.length
  end

  def test_initial_front_has_all_blue
    test_cube = Cube.new
    assert_equal [:b], test_cube.cube[2].flatten.uniq
  end

  def test_initial_right_has_all_white
    test_cube = Cube.new
    assert_equal [:w], test_cube.cube[3].flatten.uniq
  end

  def test_initial_rear_has_all_green
    test_cube = Cube.new
    assert_equal [:g], test_cube.cube[4].flatten.uniq
  end

  def test_initial_left_has_all_yellow
    test_cube = Cube.new
    assert_equal [:y], test_cube.cube[1].flatten.uniq
  end

  def test_initial_top_has_all_red
    test_cube = Cube.new
    assert_equal [:r], test_cube.cube[0].flatten.uniq
  end

  def test_initial_top_has_all_orange
    test_cube = Cube.new
    assert_equal [:o], test_cube.cube[5].flatten.uniq
  end

  def test_rotate_x_by_1_front_layer_1_does_not_have_all_blue
    test_cube = Cube.new
    test_cube.rotate_x(:clockwise, 1)
    refute_equal [:b], test_cube.cube[2].flatten.uniq
  end

  def test_rotate_x_by_1_front_layer_0_is_white_blue_blue
    layer_number = 0
    test_cube = Cube.new
    test_cube.rotate_x(:clockwise, layer_number)
    assert_equal [:w, :w, :w], test_cube.cube[2][layer_number]
    assert_equal [:b, :b, :b], test_cube.cube[2][layer_number + 1]
    assert_equal [:b, :b, :b], test_cube.cube[2][layer_number + 2]
  end

  def test_rotate_x_by_1_front_layer_1_is_blue_white_blue
    layer_number = 1
    test_cube = Cube.new
    test_cube.rotate_x(:clockwise, layer_number)
    binding.pry
    assert_equal [:b, :b, :b], test_cube.cube[2][layer_number - 1]
    assert_equal [:w, :w, :w], test_cube.cube[2][layer_number]
    assert_equal [:b, :b, :b], test_cube.cube[2][layer_number + 1]
  end

  def test_rotate_x_by_1_left_layer_1_is_yellow_blue_yellow
    test_cube = Cube.new
    test_cube.rotate_x(:clockwise, 1)
    assert_equal [:y, :y, :y], test_cube.cube[1][0]
    assert_equal [:b, :b, :b], test_cube.cube[1][1]
    assert_equal [:y, :y, :y], test_cube.cube[1][2]
  end

  def test_rotate_x_by_1_rear_layer_1_is_green_yellow_green
    test_cube = Cube.new
    test_cube.rotate_x(:clockwise, 1)
    assert_equal [:g, :g, :g], test_cube.cube[4][0]
    assert_equal [:y, :y, :y], test_cube.cube[4][1]
    assert_equal [:g, :g, :g], test_cube.cube[4][2]
  end

  def test_rotate_x_by_1_layer_1_rear_is_white_green_white
    test_cube = Cube.new
    test_cube.rotate_x(:clockwise, 1)
    assert_equal [:w, :w, :w], test_cube.cube[3][0]
    assert_equal [:g, :g, :g], test_cube.cube[3][1]
    assert_equal [:w, :w, :w], test_cube.cube[3][2]
  end

  def test_rotate_x_by_1_layer_1_top_still_is_all_red
    test_cube = Cube.new
    test_cube.rotate_x(:clockwise, 1)
    assert_equal [:r], test_cube.cube[0].flatten.uniq
  end

  def test_rotate_x_by_1_layer_1_bottom_still_is_all_orange
    test_cube = Cube.new
    test_cube.rotate_x(:clockwise, 1)
    assert_equal [:o], test_cube.cube[5].flatten.uniq
  end

  def test_rotate_y_layer_0
    # [:r, :b, :b]
    # [:r, :b, :b]
    # [:r, :b, :b]
    layer_number = 0 
    test_cube = Cube.new
    test_cube.rotate_y(:clockwise, layer_number)
    assert_equal [:r, :r, :r], [test_cube.cube[2][0][0], test_cube.cube[2][2][0], test_cube.cube[2][2][0]]
    assert_equal [:g, :g, :g], [test_cube.cube[0][0][0], test_cube.cube[0][2][0], test_cube.cube[0][2][0]]
    assert_equal [:o, :o, :o], [test_cube.cube[4][0][0], test_cube.cube[4][2][0], test_cube.cube[4][2][0]]
    assert_equal [:b, :b, :b], [test_cube.cube[5][0][0], test_cube.cube[5][2][0], test_cube.cube[5][2][0]]
  end

  def test_rotate_y_layer_1
    layer_number = 1 
    test_cube = Cube.new
    test_cube.rotate_y(:clockwise, layer_number)


    assert_equal [:r, :r, :r], [test_cube.cube[2][0][1], test_cube.cube[2][2][1], test_cube.cube[2][2][1]]
    assert_equal [:g, :g, :g], [test_cube.cube[0][0][1], test_cube.cube[0][2][1], test_cube.cube[0][2][1]]
    assert_equal [:o, :o, :o], [test_cube.cube[4][0][1], test_cube.cube[4][2][1], test_cube.cube[4][2][1]]
    assert_equal [:b, :b, :b], [test_cube.cube[5][0][1], test_cube.cube[5][2][1], test_cube.cube[5][2][1]]
  end

  def test_rotate_y_layer_2
    layer_number = 2
    test_cube = Cube.new
    test_cube.rotate_y(:clockwise, layer_number)
    assert_equal [:r, :r, :r], [test_cube.cube[2][0][2], test_cube.cube[2][2][2], test_cube.cube[2][2][2]]
    assert_equal [:g, :g, :g], [test_cube.cube[0][0][2], test_cube.cube[0][2][2], test_cube.cube[0][2][2]]
    assert_equal [:o, :o, :o], [test_cube.cube[4][0][2], test_cube.cube[4][2][2], test_cube.cube[4][2][2]]
    assert_equal [:b, :b, :b], [test_cube.cube[5][0][2], test_cube.cube[5][2][2], test_cube.cube[5][2][2]]
  end

  def test_solved
    test_cube = Cube.new
    assert_equal true, test_cube.solved?
  end
  
  def test_not_solved
    test_cube = Cube.new
    test_cube.rotate_y(:clockwise, 1)
    refute_equal true, test_cube.solved?
  end
end
