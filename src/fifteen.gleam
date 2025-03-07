import fifteen/utils
import gleam/int
import gleam/list
import lustre
import lustre/attribute
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

pub type Tile =
  Int

pub type Model {
  Model(tiles: List(Tile))
}

pub fn init(_flags) -> Model {
  Model(tiles: utils.generate_tiles(from: 0, to: 15))
}

// UPDATE -----------------------------------------------------------------
pub type Msg {
  Shuffle
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    Shuffle -> Model(tiles: utils.shuffled_tile(model.tiles))
  }
}

// VIEW -------------------------------------------------------------------

pub fn view(model: Model) {
  html.div([], [
    html.div([attribute.class("centered")], [
      html.img([
        attribute.src("/priv/static/image/logo.png"),
        attribute.id("logo"),
      ]),
    ]),
    html.div([attribute.class("centered")], [
      html.div(
        [attribute.class("game-container")],
        list.index_map(model.tiles, fn(tile, idx) {
          let row = idx / 4
          let col = idx % 4

          let style = [
            #("top", int.to_string(row * tile_size + tile_gap) <> "px"),
            #("left", int.to_string(col * tile_size + tile_gap) <> "px"),
          ]

          case tile {
            0 -> {
              html.div([attribute.class("tile empty"), attribute.style(style)], [
                html.text(""),
              ])
            }
            _ -> {
              html.div([attribute.class("tile"), attribute.style(style)], [
                html.text(int.to_string(tile)),
              ])
            }
          }
        }),
      ),
    ]),
    html.div([attribute.class("centered")], [
      html.button([attribute.class("shuffle-btn"), event.on_click(Shuffle)], [
        html.text("Shuffle"),
      ]),
    ]),
  ])
}
