import fifteen.{type Model, Model, Move, Shuffle}
import fifteen/utils
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn initial_model_state_test() {
  fifteen.init(Nil)
  |> should.equal(Model(
    tiles: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
    empty_idx: 0,
  ))
}

pub fn shuffle_test() {
  let model = fifteen.init(Nil)
  should.equal(model.empty_idx, 0)

  let shuffle_one = fifteen.update(model, Shuffle)
  should.not_equal(model.tiles, shuffle_one.tiles)
  should.not_equal(model.empty_idx, shuffle_one.empty_idx)
}

pub fn shuffle_change_empty_tile_idx_test() {
  let model = fifteen.init(Nil)

  let shuffle_one = fifteen.update(model, Shuffle)

  utils.find_empty(shuffle_one.tiles)
  |> should.equal(shuffle_one.empty_idx)
}

pub fn move_test() {
  let model = fifteen.init(Nil)

  // We can move
  use idx <- list.map([1, 4])

  fifteen.update(model, Move(idx, idx))
  |> should.not_equal(model)

  // We can not move
  use idx <- list.map([0, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])

  fifteen.update(model, Move(idx, idx))
  |> should.equal(model)
}
