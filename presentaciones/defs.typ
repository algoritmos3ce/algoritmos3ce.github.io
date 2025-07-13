#import "@preview/polylux:0.4.0": *

#let azul = rgb("#0088CC")

#let default-style(it) = {
  import "defs.typ": *

  set page(paper: "presentation-16-9", margin: 1cm)
  set text(size: 16pt, font: "DejaVu Sans")
  set list(tight: false)
  set terms(separator: [*:* ])
  show raw.where(block: true): it => block(fill: rgb("#f0f0f0"), inset: 1em, it)
  show raw.where(block: false): it => box(fill: rgb("#f0f0f0"), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), it)

  show heading: set text(azul)
  show heading: set block(below: 1em)
  show link: it => {
    set text(azul)
    underline(it)
  }

  it
}

#let caratula(it) = {
  set page(margin: (left: 2cm), background: place(top + left, box(fill: azul, width: 1cm, height: 100%)))

  slide[
    #grid(
      rows: (auto, 1fr, auto, 1fr, auto),
      [#h(1fr) #box(image("./fiuba-logo.png", width: 8cm))],
      [],
      it,
      [],
      [TB025 - Paradigmas de Programación #h(1fr) Curso Essaya],
    )
  ]
}
