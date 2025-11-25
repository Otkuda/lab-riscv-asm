#include <stdio.h>

#define N 6
#define M 3

void sum_pos(int n, int m, int matrix[M][N], int* res) {
  for (size_t i = 0; i < m; i++) {
    for (size_t j = 0; j < n; j++) {
      if (matrix[i][j] > 0) {
        *res += matrix[i][j];
      }
    }
  }
}

int main() {
  int matrix[M][N] = {0};
  int result = 0;

  for (size_t i = 0; i < M; i++) {
    for (size_t j = 0; j < N; j++) {
      scanf("%d", &matrix[i][j]);
    }
  }

  sum_pos(N, M, matrix, &result);

  printf("%d\n", result);
}