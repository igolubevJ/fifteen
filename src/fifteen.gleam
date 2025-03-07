import fifteen/types.{type Tile}
import fifteen/utils
import gleam/int
import gleam/list
import lustre
import lustre/attribute.{class, id, src, style}
import lustre/element/html
import lustre/event

const tile_size = 100

const tile_gap = 6

// MAIN ----------------------------------------------------------------

pub fn main() {
  let app = lustre.simple(init, update, view)

  let assert Ok(_) = lustre.start(app, "#app", Nil)

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
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    Shuffle -> {
      let #(empty_idx, tiles) = utils.shuffled_tile(model.tiles)
      Model(empty_idx:, tiles:)
    }
  }
}

// VIEW -------------------------------------------------------------------

pub fn view(model: Model) {
  html.div([], [
    html.div([class("centered")], [
      html.img([src("/priv/static/image/logo.png"), id("logo")]),
    ]),
    html.div([class("centered")], [
      html.div(
        [class("game-container")],
        list.index_map(model.tiles, fn(tile, idx) {
          let row = idx / 4
          let col = idx % 4

          let styles = [
            #("top", int.to_string(row * tile_size + tile_gap) <> "px"),
            #("left", int.to_string(col * tile_size + tile_gap) <> "px"),
          ]

          case tile {
            0 -> {
              html.div([class("tile empty"), style(styles)], [html.text("")])
            }
            _ -> {
              html.div([class("tile"), style(styles)], [
                html.text(int.to_string(tile)),
              ])
            }
          }
        }),
      ),
    ]),
    html.div([class("centered")], [
      html.button([class("shuffle-btn"), event.on_click(Shuffle)], [
        html.text("Shuffle"),
      ]),
    ]),
  ])
}
