import lustre
import lustre/attribute
import lustre/element
import lustre/element/html

pub fn main() {
  let app =
    lustre.element(
      html.div([], [
        html.div([attribute.class("centered")], [
          html.img([
            attribute.src("/priv/static/image/logo.png"),
            attribute.id("logo"),
          ]),
        ]),
        html.div([attribute.class("centered")], [
          html.div([attribute.class("game-container")], []),
        ]),
        html.div([attribute.class("centered")], [
          html.button([attribute.class("shuffle-btn")], [html.text("Shuffle")]),
        ]),
      ]),
    )

  let assert Ok(_) = lustre.start(app, "#app", Nil)
  Nil
}
