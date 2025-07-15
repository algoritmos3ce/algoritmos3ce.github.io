#import "@preview/polylux:0.4.0": *

#let azul = rgb("#0088cc")

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

#let titulo(it) = {
  set page(
    margin: (left: 2cm, right: 2cm),
    background: {
      place(top + left, image("barra-lateral.png", height: 100%))
      place(top + right, image("barra-lateral.png", height: 100%))
    },
  )

  slide[
    #it
  ]
}

#let caratula(it) = {
  titulo[
    #align(right)[ #box(image("./fiuba-logo.png", width: 8cm)) ]
    #v(1fr)
    #{
      set text(size: 26pt)
      it
    }
    #v(1fr)
    TB025 - Paradigmas de Programación #h(1fr) Curso Essaya
  ]
}

#let fin() = {
  titulo[
    #place(center + horizon, image("redes.png", width: 70%))
  ]
}
