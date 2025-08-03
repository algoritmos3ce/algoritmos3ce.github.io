#import "@preview/polylux:0.4.0": *
#import "@preview/shadowed:0.2.0": shadowed

#let azul = rgb("#0088cc")
#let rojo = rgb("#cc2200")
#let verde = rgb("#228800")

#let default-style(it) = {
  import "defs.typ": *

  set page(paper: "presentation-16-9", margin: 1cm)
  set text(size: 16pt, font: "DejaVu Sans")
  set list(tight: false)
  set terms(separator: [*:* ])
  show raw.where(block: true): it => block(fill: rgb("#f0f0f0"), inset: 1em, it)
  show raw.where(block: false): it => box(fill: rgb("#f0f0f0"), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), it)

  set quote(block: true)
  show quote: set pad(x: 5em)
  show quote: emph

  show heading: set text(azul)
  show heading: set block(below: 1em)
  show link: set text(azul)

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

#let external-link = [
  #set text(font: "Font Awesome 5 Free", size: 0.75em)
  \u{f08e}
]

#let linklet(url) = link(url)[ #external-link ]

#let fuente(url) = {
  set text(size: 14pt)
  place(top + right)[
    #move(dx: 1cm, dy: -1cm)[
      #shadowed(fill: white, inset: 0.5em)[#linklet(url)]
    ]
  ]
}

#let malo(body) = text(rojo)[ #sym.crossmark.heavy #body ]
#let bueno(body) = text(verde)[ #sym.checkmark.heavy #body ]

#let bonustrack(content) = [
  #set page(
    margin: (left: 2cm),
    background: {
      place(top + left)[
        #box(
          fill: azul,
          height: 100%,
          width: 1cm,
        )[
          #set text(white)
          #place(center+horizon, clearance: 1em)[
            #rotate(-90deg, reflow: true)[ * Bonus track * ]
          ]
        ]
      ]
    },
  )

  #content
]
