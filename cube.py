import random
from copy import deepcopy

class Cube:
    TOP = 0
    LEFT = 1
    FRONT = 2
    RIGHT = 3
    REAR = 4
    BOTTOM = 5

    def __init__(self, cube):
        self.cube = cube

    def rotate_x_clockwise(self, layer_number):
        cube_dup = deepcopy(self.cube)
        sides = [
            (self.FRONT, self.RIGHT),
            (self.RIGHT, self.REAR),
            (self.REAR, self.LEFT),
            (self.LEFT, self.FRONT)
        ]
        for side_a, side_b in sides:
            self.swap_x(side_a, side_b, layer_number, cube_dup)

    def rotate_x_counter_clockwise(self, layer_number):
        cube_dup = deepcopy(self.cube)
        sides = [
            (self.FRONT, self.LEFT),
            (self.RIGHT, self.FRONT),
            (self.REAR, self.RIGHT),
            (self.LEFT, self.REAR)
        ]
        for side_a, side_b in sides:
            self.swap_x(side_a, side_b, layer_number, cube_dup)

    def rotate_y_clockwise(self, layer_number):
        cube_dup = deepcopy(self.cube)
        sides = [
            (self.FRONT, self.TOP),
            (self.TOP, self.REAR),
            (self.BOTTOM, self.FRONT),
            (self.REAR, self.BOTTOM)
        ]
        for side_a, side_b in sides:
            self.swap_y(side_a, side_b, layer_number, cube_dup)

    def rotate_y_counter_clockwise(self, layer_number):
        cube_dup = deepcopy(self.cube)
        sides = [
            (self.FRONT, self.BOTTOM),
            (self.TOP, self.FRONT),
            (self.REAR, self.TOP),
            (self.REAR, self.BOTTOM)
        ]
        for side_a, side_b in sides:
            self.swap_y(side_a, side_b, layer_number, cube_dup)

    def solved(self):
        for i in range(6):
            cube_length = len(set([elem for row in self.cube[i] for elem in row]))
            if cube_length != 1:
                return False
        return True

    def print_cube(self):
        side_names = ["TOP", "LEFT", "FRONT", "RIGHT", "BACK", "BOTTOM"]
        for i, name in enumerate(side_names):
            print(f"--- {name} ---")
            for row in self.cube[i]:
                print(''.join(row))

    def swap_x(self, side_a, side_b, layer_number, cube_dup):
        self.cube[side_a][layer_number] = cube_dup[side_b][layer_number]

    def swap_y(self, side_a, side_b, layer_number, cube_dup):
        self.cube[side_a][0][layer_number], self.cube[side_a][1][layer_number], self.cube[side_a][2][layer_number] = \
            cube_dup[side_b][0][layer_number], cube_dup[side_b][1][layer_number], cube_dup[side_b][2][layer_number]


if __name__ == "__main__":
  cube_maxtrix_large = [
    # TOP
    [
        ['r', 'r', 'r'],
        ['r', 'r', 'r'],
        ['r', 'r', 'r'],
    ],
    # LEFT
    [
        ['y', 'y', 'y'],
        ['y', 'y', 'y'],
        ['y', 'y', 'y'],
    ],
    # FRONT
    [
        ['b', 'b', 'b'],
        ['b', 'b', 'b'],
        ['b', 'b', 'b'],
    ],
    # RIGHT
    [
        ['w', 'w', 'w'],
        ['w', 'w', 'w'],
        ['w', 'w', 'w'],
    ],
    # REAR
    [
        ['g', 'g', 'g'],
        ['g', 'g', 'g'],
        ['g', 'g', 'g'],
    ],
    # BOTTOM
    [
        ['o', 'o', 'o'],
        ['o', 'o', 'o'],
        ['o', 'o', 'o'],
    ]
]

  # Assuming cube_maxtrix_large is defined
  cube = Cube(cube_maxtrix_large)
  print("randomizing cube")

  for _ in range(500):
      binary_choice = random.randint(0, 1)
      layer_number = random.randint(0, 2)

      if binary_choice == 0:
          cube.rotate_x_clockwise(layer_number)
      else:
          cube.rotate_y_clockwise(layer_number)

  print(cube.print_cube)
  # sleep(5)
  print("solving cube")

  count = 1

  MAX = 3
  x_c_count = 0
  y_c_count = 0
  x_cc_count = 0
  y_cc_count = 0

  while True:
      binary_choice = random.randint(0, 3)
      layer_number = random.randint(0, 2)

      if binary_choice == 0:
          if x_c_count > MAX:
              x_c_count = 0
          else:
              cube.rotate_x_clockwise(layer_number)
              x_c_count += 1

      elif binary_choice == 1:
          if y_c_count > MAX:
              y_c_count = 0
          else:
              cube.rotate_y_clockwise(layer_number)
              y_c_count += 1

      elif binary_choice == 2:
          if x_cc_count > MAX:
              x_cc_count = 0
          else:
              cube.rotate_x_counter_clockwise(layer_number)
              x_cc_count += 1

      elif binary_choice == 3:
          if y_cc_count > MAX:
              y_cc_count = 0
          else:
              cube.rotate_y_counter_clockwise(layer_number)
              y_cc_count += 1

      else:
          raise ValueError("error")

      if cube.solved():
          print(count)
          print("Solved!")
          cube.print_cube()
          break

      # if cube.white_cross():
      #     print("HERE")
      #     print(count)
      #     cube.print_cube()
      #     break

      if count % 100_000 == 0:
          print(f"{count:,}")

      count += 1
