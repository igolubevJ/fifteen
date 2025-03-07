import fifteen/utils
import gleam/io

pub fn main() {
  io.println("Hello from fifteen!")

  let res = utils.generate_tiles(from: 0, to: 15)
  io.debug(res)
}
