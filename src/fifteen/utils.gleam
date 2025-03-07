/// Function generate list of tiles from number to number.
pub fn generate_tiles(from from: Int, to to: Int) {
  generate_tiles_loop(from, to, [])
}

fn generate_tiles_loop(from: Int, to: Int, accamulator: List(Int)) {
  case to {
    number if to >= from -> {
      generate_tiles_loop(from, to - 1, [number, ..accamulator])
    }
    _ -> accamulator
  }
}
