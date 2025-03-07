import gleam/list

/// Function generate list of tiles from number to number.
pub fn generate_tiles(from from: Int, to to: Int) -> List(Int) {
  generate_tiles_loop(from, to, [])
}

fn generate_tiles_loop(from: Int, to: Int, accamulator: List(Int)) -> List(Int) {
  case to {
    number if to >= from -> {
      generate_tiles_loop(from, to - 1, [number, ..accamulator])
    }
    _ -> accamulator
  }
}

/// Simple shuffled tiles function
pub fn shuffled_tile(tiles: List(a)) -> List(a) {
  list.shuffle(tiles)
}
