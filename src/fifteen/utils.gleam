import gleam/list

/// Function generate list of tiles from number to number.
pub fn generate_tiles(from from: Int, to to: Int) -> List(Int) {
  list.range(from, to)
}

/// Simple shuffled tiles function
pub fn shuffled_tile(tiles: List(Int)) -> #(Int, List(Int)) {
  let res = list.shuffle(tiles)
  let assert Ok(idx) = find_zero(res)

  #(idx, res)
}

fn find_zero(tiles: List(Int)) {
  find_zero_loop(tiles, 0)
}

fn find_zero_loop(tiles: List(Int), idx: Int) {
  case tiles {
    [el, ..] if el == 0 -> Ok(idx)
    [_, ..rest] -> find_zero_loop(rest, idx + 1)
    _ -> Error("Error find element of 0 value in tiles list")
  }
}
