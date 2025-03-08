import fifteen/types.{type Tile}
import gleam/int
import gleam/list

/// Function generate list of tiles from number to number.
pub fn generate_tiles(from from: Int, to to: Int) -> List(Tile) {
  list.range(from, to)
}

pub fn is_adjucent(idx_a: Int, idx_b: Int) -> Bool {
  let row_a = idx_a / 4
  let col_a = idx_a % 4

  let row_b = idx_b / 4
  let col_b = idx_b % 4

  let row_test = int.absolute_value(row_a - row_b) == 1 && col_a == col_b
  let col_test = int.absolute_value(col_a - col_b) == 1 && row_a == row_b

  row_test || col_test
}

pub fn swap_empty(
  tiles: List(Tile),
  zero_idx: Int,
  tile: #(Int, Int),
) -> List(Tile) {
  use v, idx <- list.index_map(tiles)

  case idx {
    i if i == zero_idx -> tile.1
    i if i == tile.0 -> 0
    _ -> v
  }
}

/// Simple shuffled tiles function
pub fn shuffled_tile(tiles: List(Tile)) -> #(Int, List(Tile)) {
  let res = list.shuffle(tiles)
  #(find_empty(res), res)
}

pub fn find_empty(tiles: List(Tile)) -> Int {
  let assert Ok(idx) = find_empty_loop(tiles, 0)
  idx
}

fn find_empty_loop(tiles: List(Tile), idx: Int) -> Result(Int, String) {
  case tiles {
    [el, ..] if el == 0 -> Ok(idx)
    [_, ..rest] -> find_empty_loop(rest, idx + 1)
    _ -> Error("Error find element of 0 value in tiles list")
  }
}
