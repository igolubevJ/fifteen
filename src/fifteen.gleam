import fifteen/types.{type Tile}
import fifteen/utils
import gleam/int
import gleam/list
import lustre
import lustre/attribute.{type Attribute, class, id, src, style}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import tardis

const tile_size = 100

const tile_gap = 6

const logo_url = "/priv/static/image/logo.png"

// MAIN ----------------------------------------------------------------

pub fn main() {
  // let assert Ok(main) = tardis.single("main")

  let app = lustre.simple(init, update, view)
  // |> tardis.wrap(with: main)

  let assert Ok(_) = lustre.start(app, "#app", Nil)
  // |> tardis.activate(with: main)

  Nil
}

// MODEL ------------------------------------------------------------------

pub type Model {
  Model(tiles: List(Tile), empty_idx: Int)
}

pub fn init(_flags) -> Model {
  Model(tiles: utils.generate_tiles(from: 0, to: 15), empty_idx: 0)
}

// UPDATE -----------------------------------------------------------------

pub type Msg {
  Shuffle
  Move(Int, Int)
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    Shuffle -> handle_shuffle(model)
    Move(idx, value) -> handle_move(idx, value, model)
  }
}

fn handle_shuffle(model: Model) -> Model {
  model.tiles
  |> utils.shuffled_tile()
  |> update_model_after_shuffle()
}

fn update_model_after_shuffle(new_data: #(Int, List(Tile))) -> Model {
  Model(empty_idx: new_data.0, tiles: new_data.1)
}

fn handle_move(idx: Int, value: Tile, model: Model) -> Model {
  case utils.is_adjucent(idx, model.empty_idx) {
    True -> update_model_with_move(idx, value, model)
    False -> model
  }
}

fn update_model_with_move(idx: Int, value: Tile, model: Model) -> Model {
  Model(
    tiles: utils.swap_empty(model.tiles, model.empty_idx, #(idx, value)),
    empty_idx: idx,
  )
}

// VIEW -------------------------------------------------------------------

pub fn view(model: Model) -> Element(Msg) {
  html.div([], [
    html.div([class("centered")], [html.img([src(logo_url), id("logo")])]),
    html.div([class("centered")], [
      html.div([class("game-container")], tiles_view(model)),
    ]),
    html.div([class("centered")], [button_view("Shuffle", Shuffle)]),
  ])
}

fn tiles_view(model: Model) -> List(Element(Msg)) {
  use tile, idx <- list.index_map(model.tiles)

  case tile {
    0 -> empty_tile_view(idx)
    _ -> tile_view(idx, tile, Move(idx, tile))
  }
}

fn empty_tile_view(tile_idx: Int) -> Element(Msg) {
  html.div([class("tile empty"), generate_tile_style(tile_idx)], [html.text("")])
}

fn tile_view(tile_idx: Int, tile: Tile, event_msg: Msg) -> Element(Msg) {
  html.div(
    [class("tile"), generate_tile_style(tile_idx), event.on_click(event_msg)],
    [html.text(int.to_string(tile))],
  )
}

fn button_view(text: String, event_msg: Msg) -> Element(Msg) {
  html.button([class("shuffle-btn"), event.on_click(event_msg)], [
    html.text(text),
  ])
}

fn generate_tile_style(tile_idx: Int) -> Attribute(a) {
  style([
    #("top", int.to_string({ tile_idx / 4 } * tile_size + tile_gap) <> "px"),
    #("left", int.to_string({ tile_idx % 4 } * tile_size + tile_gap) <> "px"),
  ])
}
