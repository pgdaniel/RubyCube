#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <limits.h>

#define TOP 0
#define LEFT 1
#define FRONT 2
#define RIGHT 3
#define REAR 4
#define BOTTOM 5

typedef struct {
    char cube[6][3][3];
} Cube;

  void rotate_x_clockwise(int layer_number, Cube *cube) {
    char temp[3];
    temp[0] = cube->cube[0][layer_number][0];
    temp[1] = cube->cube[0][layer_number][1];
    temp[2] = cube->cube[0][layer_number][2];

    cube->cube[0][layer_number][0] = cube->cube[4][layer_number][0];
    cube->cube[0][layer_number][1] = cube->cube[4][layer_number][1];
    cube->cube[0][layer_number][2] = cube->cube[4][layer_number][2];

    cube->cube[4][layer_number][0] = cube->cube[5][layer_number][0];
    cube->cube[4][layer_number][1] = cube->cube[5][layer_number][1];
    cube->cube[4][layer_number][2] = cube->cube[5][layer_number][2];

    cube->cube[5][layer_number][0] = cube->cube[2][layer_number][0];
    cube->cube[5][layer_number][1] = cube->cube[2][layer_number][1];
    cube->cube[5][layer_number][2] = cube->cube[2][layer_number][2];

    cube->cube[2][layer_number][0] = temp[0];
    cube->cube[2][layer_number][1] = temp[1];
    cube->cube[2][layer_number][2] = temp[2];
  }

  void rotate_y_clockwise(int layer_number, Cube *cube) {
    char temp[3];
    temp[0] = cube->cube[0][0][layer_number];
    temp[1] = cube->cube[0][1][layer_number];
    temp[2] = cube->cube[0][2][layer_number];

    cube->cube[0][0][layer_number] = cube->cube[1][0][layer_number];
    cube->cube[0][1][layer_number] = cube->cube[1][1][layer_number];
    cube->cube[0][2][layer_number] = cube->cube[1][2][layer_number];

    cube->cube[1][0][layer_number] = cube->cube[5][0][layer_number];
    cube->cube[1][1][layer_number] = cube->cube[5][1][layer_number];
    cube->cube[1][2][layer_number] = cube->cube[5][2][layer_number];

    cube->cube[5][0][layer_number] = cube->cube[3][0][layer_number];
    cube->cube[5][1][layer_number] = cube->cube[3][1][layer_number];
    cube->cube[5][2][layer_number] = cube->cube[3][2][layer_number];

    cube->cube[3][0][layer_number] = temp[0];
    cube->cube[3][1][layer_number] = temp[1];
    cube->cube[3][2][layer_number] = temp[2];
  }

  int binary_choice() {
    return rand() % 2;
  }

  int solved(Cube *cube) {
    for(int i = 0; i < 6; i++) {
        for(int j = 0; j < 3; j++) {
            for(int k = 0; k < 3; k++) {
                if(cube->cube[i][j][k] != cube->cube[0][0][0]) {
                    return 0;
                }
            }
        }
    }

    return 1;
  }

  void print_cube(Cube *cube) {
    for(int i = 0; i < 6; i++) {
        for(int j = 0; j < 3; j++) {
            for(int k = 0; k < 3; k++) {
                printf("%c ", cube->cube[i][j][k]);
            }
            printf("\n");
        }
        puts("-----------------");
    }
  }

// Initialize the cube
void init_cube(Cube *c, char initial_cube[6][3][3]) {
    memcpy(c->cube, initial_cube, 6 * 3 * 3 * sizeof(char));
}

// Rotate functions and other necessary functions go here

int main() {
    char initial_cube[6][3][3] = {
        // TOP
        {
            {'r', 'r', 'r'},
            {'r', 'r', 'r'},
            {'r', 'r', 'r'},
        },
        // LEFT
        {
            {'y', 'y', 'y'},
            {'y', 'y', 'y'},
            {'y', 'y', 'y'},
        },
        // FRONT
        {
            {'b', 'b', 'b'},
            {'b', 'b', 'b'},
            {'b', 'b', 'b'},
        },
        // RIGHT
        {
            {'w', 'w', 'w'},
            {'w', 'w', 'w'},
            {'w', 'w', 'w'},
        },
        // REAR
        {
            {'g', 'g', 'g'},
            {'g', 'g', 'g'},
            {'g', 'g', 'g'},
        },
        // BOTTOM
        {
            {'o', 'o', 'o'},
            {'o', 'o', 'o'},
            {'o', 'o', 'o'},
        },
    };

    Cube cube;
    init_cube(&cube, initial_cube);

    unsigned long long count = 0;
    unsigned long long overflow = 0;

    printf("Length of unsigned long long %llu\n", ULLONG_MAX);


    for(;;) {
      if(binary_choice()) {
        rotate_x_clockwise(0, &cube);
      } else {
        rotate_y_clockwise(1, &cube);
      }

      if(solved(&cube)) {
        printf("Solved!\n");
        print_cube(&cube);
        break;
      }

      if(count % 10000000 == 0) {
        printf("%llu\n", count);
      }

      if(count > ULLONG_MAX) {
        count = 0;
        overflow++;;
      }
      count++;
    }


    return 0;
}
