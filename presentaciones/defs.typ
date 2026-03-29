#import "@preview/polylux:0.4.0": *
#import "@preview/shadowed:0.2.0": shadowed

// from https://typst.app/universe/package/octique/
// https://github.com/0x6b/typst-octique/blob/main/packages/preview/octique/0.1.1/impl/octique.typ
#let icon-data = (
  link-external: "<path d=\"M3.75 2h3.5a.75.75 0 0 1 0 1.5h-3.5a.25.25 0 0 0-.25.25v8.5c0 .138.112.25.25.25h8.5a.25.25 0 0 0 .25-.25v-3.5a.75.75 0 0 1 1.5 0v3.5A1.75 1.75 0 0 1 12.25 14h-8.5A1.75 1.75 0 0 1 2 12.25v-8.5C2 2.784 2.784 2 3.75 2Zm6.854-1h4.146a.25.25 0 0 1 .25.25v4.146a.25.25 0 0 1-.427.177L13.03 4.03 9.28 7.78a.751.751 0 0 1-1.042-.018.751.751 0 0 1-.018-1.042l3.75-3.75-1.543-1.543A.25.25 0 0 1 10.604 1Z\" />",
  thumbsdown: "<path d=\"M7.083 15.986c-.763-.087-1.499-.295-2.011-.884-.504-.581-.655-1.378-.655-2.299 0-.468.087-1.12.157-1.638l.015-.112H3.167c-.603 0-1.174-.086-1.669-.334a2.415 2.415 0 0 1-1.136-1.2c-.454-.998-.438-2.447-.188-4.316l.04-.306C.32 4.108.41 3.424.526 2.864c.132-.63.316-1.209.669-1.672C1.947.205 3.211.053 4.917.053c1.848 0 3.234.332 4.388.652l.474.133c.658.187 1.201.341 1.726.415a1.75 1.75 0 0 1 1.662-1.2h1c.966 0 1.75.784 1.75 1.75v7.5a1.75 1.75 0 0 1-1.75 1.75h-1a1.75 1.75 0 0 1-1.514-.872c-.259.105-.59.268-.919.508-.671.491-1.317 1.285-1.317 2.614v.5c0 1.201-.994 2.336-2.334 2.183Zm4.334-13.232c-.706-.089-1.39-.284-2.072-.479l-.441-.125c-1.096-.304-2.335-.597-3.987-.597-1.794 0-2.28.222-2.529.548-.147.193-.275.505-.393 1.07-.105.502-.188 1.124-.295 1.93l-.04.3c-.25 1.882-.19 2.933.067 3.497a.923.923 0 0 0 .443.48c.208.104.52.175.997.175h1.75c.685 0 1.295.577 1.205 1.335-.022.192-.049.39-.075.586-.066.488-.13.97-.13 1.329 0 .808.144 1.15.288 1.316.137.157.401.303 1.048.377.307.035.664-.237.664-.693v-.5c0-1.922.978-3.127 1.932-3.825a5.878 5.878 0 0 1 1.568-.809Zm1.75 6.798h1a.25.25 0 0 0 .25-.25v-7.5a.25.25 0 0 0-.25-.25h-1a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25Z\" />",
  thumbsup: "<path d=\"M8.834.066c.763.087 1.5.295 2.01.884.505.581.656 1.378.656 2.3 0 .467-.087 1.119-.157 1.637L11.328 5h1.422c.603 0 1.174.085 1.668.333.508.254.911.679 1.137 1.2.453.998.438 2.447.188 4.316l-.04.306c-.105.79-.195 1.473-.313 2.033-.131.63-.315 1.209-.668 1.672C13.97 15.847 12.706 16 11 16c-1.848 0-3.234-.333-4.388-.653-.165-.045-.323-.09-.475-.133-.658-.186-1.2-.34-1.725-.415A1.75 1.75 0 0 1 2.75 16h-1A1.75 1.75 0 0 1 0 14.25v-7.5C0 5.784.784 5 1.75 5h1a1.75 1.75 0 0 1 1.514.872c.258-.105.59-.268.918-.508C5.853 4.874 6.5 4.079 6.5 2.75v-.5c0-1.202.994-2.337 2.334-2.184ZM4.5 13.3c.705.088 1.39.284 2.072.478l.441.125c1.096.305 2.334.598 3.987.598 1.794 0 2.28-.223 2.528-.549.147-.193.276-.505.394-1.07.105-.502.188-1.124.295-1.93l.04-.3c.25-1.882.189-2.933-.068-3.497a.921.921 0 0 0-.442-.48c-.208-.104-.52-.174-.997-.174H11c-.686 0-1.295-.577-1.206-1.336.023-.192.05-.39.076-.586.065-.488.13-.97.13-1.328 0-.809-.144-1.15-.288-1.316-.137-.158-.402-.304-1.048-.378C8.357 1.521 8 1.793 8 2.25v.5c0 1.922-.978 3.128-1.933 3.825a5.831 5.831 0 0 1-1.567.81ZM2.75 6.5h-1a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h1a.25.25 0 0 0 .25-.25v-7.5a.25.25 0 0 0-.25-.25Z\" />",
)

// Wrap path data into SVG
#let icon-svg(name) = {
  "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 16 16\" role=\"graphics-symbol\" aria-hidden=\"true\" focusable=\"false\" width=\"16\" height=\"16\" fill=\"#000000\">" + icon-data.at(name) + "</svg>"
}

// Returns decoded image for name
#let icon(name, color: rgb("#000000"), ..args) = {
  image(
    bytes(icon-svg(name).replace("#000000", color.to-hex())),
    format: "svg",
    ..args,
  )
}

#let azul = rgb("#0088cc")
#let rojo = rgb("#cc2200")
#let verde = rgb("#228800")

#let textsize = 16pt

#let default-style(it) = {
  set page(paper: "presentation-16-9", margin: 1cm)
  set text(size: textsize, font: "DejaVu Sans")
  set list(tight: false)
  set terms(separator: [*:* ])
  show raw.where(block: true): it => block(fill: rgb("#f0f0f0"), inset: 1em, it)
  show raw.where(block: false): it => box(fill: rgb("#f0f0f0"), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), it)
  set raw(syntaxes: "prolog.sublime-syntax")

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
    #place(center + horizon, image("redes.png", width: 50%))
  ]
}

#let external-link = box(baseline: 12%)[ #icon("link-external", color: azul, height: 0.9em, width: 0.9em) ]

#let linklet(url) = link(url)[ #external-link ]

#let fuente(url) = {
  set text(size: 14pt)
  place(top + right)[
    #move(dx: 1cm, dy: -1cm)[
      #shadowed(fill: white, inset: 0.5em)[#linklet(url)]
    ]
  ]
}

#let malo(body) = [ #box(baseline: 20%)[#icon("thumbsdown", color: rojo)] #text(rojo, body) ]
#let bueno(body) = [ #box[#icon("thumbsup", color: verde)] #text(verde, body) ]

#let special(color, label, content) = [
  #set page(
    margin: (left: 2cm),
    background: {
      place(top + left)[
        #box(
          fill: color,
          height: 100%,
          width: 1cm,
        )[
          #set text(white)
          #place(center+horizon, clearance: 1em)[
            #rotate(-90deg, reflow: true)[ *#label* ]
          ]
        ]
      ]
    },
  )

  #content
]

#let bonustrack(content) = special(azul, [Bonus Track], content)
#let ejercicio(content) = special(rojo, [Ejercicio], content)

#let hr = line(length: 100%, stroke: azul.transparentize(90%))

#let emphbox(body, ..args) = block(width: 100%, fill: azul.transparentize(90%), inset: 0.75em, ..args)[#body]
#let emphbox-small(body, ..args) = block(width: 100%, fill: azul.transparentize(90%), outset: 0.75em, ..args)[#body]
