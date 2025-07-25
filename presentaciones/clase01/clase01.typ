#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.0"

#import "../defs.typ": *

#show: default-style

#caratula[
  = Programación Orientada a Objetos
]

#slide[
  = Paradigmas de Programación

  - *Imperativos* (énfasis en la ejecución de instrucciones)

    - Programación Procedimental (ej. Pascal)
    - Programación Orientada a Objetos (ej. Smalltalk)

  - *Declarativos* (énfasis en la evaluación de expresiones)

    - Programación Funcional (ej. Haskell)
    - Programación Lógica (ej. Prolog)

  Los lenguajes más utilizados (por ejemplo, Java) son *multiparadigma*. Cabe a los
  programadores usar el estilo de programación más adecuado para cada trabajo.

  #fuente("https://en.wikipedia.org/wiki/Programming_paradigm")
]

#slide[
  #grid(
    columns: (2fr, 1.8fr),
    align: (auto, horizon + center),
    gutter: 1cm,
    [
      = OOP: Historia

      / 1950s: La idea de "objetos" surge del grupo de IA del MIT

      / 1960s: Simula: primer lenguage con objetos, clases y herencia

      / 1970s: Smalltalk (Alan Kay): Primer lenguaje OOP puro

      / 1980s: OOP gana popularidad
        - C++ (Bjarne Stroustrup)
        - Objective-C (Brad Cox $->$ NeXT $->$ Apple)
        - Eiffel (Bertrand Meyer)
        - Delphi (Object Pascal, Anders Hejlsberg $->$ Borland)
    ],
    image("smalltalk.png", width: 100%),
  )

  #fuente("https://en.wikipedia.org/wiki/Object-oriented_programming")
]

#slide[
  #grid(
    columns: (1fr, 0.6fr),
    align: (auto, horizon + center),
    gutter: 1cm,
    [
      = OOP: Historia (cont.)

      / 1990s-2000s: OOP es mainstream
        - Java (James Gosling $->$ Sun Microsystems $->$ Oracle)
        - Python (Guido van Rossum)
        - Ruby (Yukihiro Matsumoto)
        - .NET Framework, C#sym.hash, VB.NET (Microsoft)
        - Design patterns (GoF)
        - UML

      / 2010s–actualidad: Scala, Kotlin, Swift, Go, Rust, ...
        - Los lenguajes modernos tienden a combinar características de OOP y FP
    ],
    [
      #box(image("javalogo.png", width: 3cm), baseline: 50%)
      #box(image("pythonlogo.png", width: 3cm), inset: (x: 0.5cm), baseline: 50%)
      #box(image("rubylogo.png", width: 4cm), baseline: 50%)
      #box(image("netlogo.png", width: 4cm), baseline: 50%, inset: (x: 0.5cm))
      #box(image("gofdp.jpg", width: 4cm), baseline: 50%, inset: (x: 0.5cm))
    ],
  )
]

#slide[
  = Objetos

  #grid(
    columns: (0.8fr, 1fr),
    gutter: 2cm,
    align: horizon,
    [
      Un *objeto* es una entidad (habitualmente almacenada en memoria) que
      tiene *identidad*, *estado* y *comportamiento*.

      Un sistema orientado a objetos se forma de un conjunto de objetos que
      interactúan pasando *mensajes* entre sí.
    ],
    cetz.canvas({
      import cetz: coordinate
      import cetz.draw: *

      let o(center, name, ..rest) = {
        let w = 3.5
        rect((rel: (-w/2, -w/2), to: center), (rel: (w/2, w/2), to: center), name: name, ..rest)
        line((name+".north-west", 33%, name+".south-west"), (name+".north-east", 33%, name+".south-east"))
        content((name+".north", 17%, name+".south"), [*Objeto*])
        content((name+".north", 66%, name+".south"), [Estado])
      }

      o((angle: 0deg, radius: 4), "der")
      o((angle: 120deg, radius: 4), "arr")
      o((angle: 240deg, radius: 4), "ab")

      let m(a, b, c, anchor, name, ..rest) = {
        bezier-through(a, b, c, mark: (symbol: "straight", scale: 3, offset: 0.2, reverse: true), name: name, ..rest)
        content(name+".mid", box(inset: 0.2cm, [Mensajes]), anchor: anchor)
      }
      m("der.north", (angle: 60deg, radius: 4), "arr.east", "south-west", "m1")
      m("der.south", (angle: 300deg, radius: 4), "ab.east", "north-west", "m2")
      m("arr.south", ("arr.south", 50%, "ab.north"), "ab.north", "east", "m3")
    })
  )
]

#slide[
  = Estilos de OOP

  Una característica importante en los lenguajes orientados a objetos es la
  posibilidad de definir objetos con comportamiento similar. Hay dos variantes
  de lenguajes según cómo se implementa esto:

  / Basado en Clases: Todo objeto es una *instancia* de una *clase* específica.

    Ejemplos: Smalltalk, Java, C++, C#sym.hash, Python, Ruby, Swift, Kotlin

  / Basado en Prototipos: Todo objeto está asociado a otro (su *prototipo* o *padre*).

    Ejemplos: JavaScript, Lua
]

#slide[
  #grid(
    columns: (2fr, 0.5fr),
    align: (auto, horizon + center),
    gutter: 1cm,
    [
      = Java

      - Creado por James Gosling en 1995 en Sun Microsystems
      - De propósito general
      - Multiparadigma, principalmente OOP
      - Basado en clases
      - Recolector de basura automático
      - Tipado estático y fuerte
      - Compilación a bytecode y ejecución en una máquina virtual (JVM)
        - Portabilidad: "Write once, run anywhere"
        - Windows, Linux, macOS, Android, etc.
    ],
    [
      #v(1fr)
      #image("javalogo.png", width: 4cm)
      #v(1fr)
      #image("javaduke.svg", width: 3cm)
      #v(1fr)
    ]
  )
]

#slide[
  #grid(
    columns: (1fr, auto),
    gutter: 1cm,
    align: horizon,
    [
      #set text(size: 14pt)

      = Definiciones

      / Clase: Plantilla para crear objetos. Define los aspectos que
        comparten todos los objetos creados a partir de la clase (*atributos*
        y *métodos*).

      / Instancia: Un objeto creado a partir de una clase. Cada instancia tiene
        su propia *identidad*, que permite distinguirla de otras instancias.
        Al crearse una instancia se reserva memoria para almacenar su *estado*.

      / Atributos: Variables de instancia que almacenan el *estado* de un
        objeto. Alias: *miembros*, *campos*.

      / Métodos: Funciones que operan sobre un objeto. El conjunto de métodos
        definidos por una clase determinan el *comportamiento* del objeto.
        La forma de enviar un *mensaje* a un objeto es invocar uno de sus
        métodos.

      / Constructor: Método especial que es invocado automáticamente cuando
        se crea una instancia de la clase.
    ],
    [
        ```java
        class Punto {
            double x;
            double y;

            Punto(double x, double y) {
                this.x = x;
                this.y = y;
            }

            double norma() {
                return Math.sqrt(x * x + y * y);
            }
        }
        ```

        ```java
        Punto p = new Punto(2, 5);
        System.out.println(p.norma()); // 5.3851
        ```
    ],
  )
]

#slide[
  = Ejemplo: Número secreto

  #fuente("https://github.com/algoritmos3ce/algoritmos3ce.github.io/tree/main/presentaciones/clase01/ejemplos/adivina")

  #grid(
    columns: (auto, auto),
    gutter: 1cm,
    {
      set text(size: 11pt)
      let src = read("ejemplos/adivina/src/main/java/tb025/Juego.java").split("\n").slice(4).join("\n")
      raw(src, lang: "java", block: true)
    },
    {
      set text(size: 11pt)
      let src = read("ejemplos/adivina/src/main/java/tb025/Resultado.java").split("\n").slice(2).join("\n")
      raw(src, lang: "java", block: true)
    },
  )
]

#slide[
  = Ejemplo: Número secreto (cont.)

  #fuente("https://github.com/algoritmos3ce/algoritmos3ce.github.io/tree/main/presentaciones/clase01/ejemplos/adivina")

  #grid(columns: 2, gutter: 1cm,
    {
      set text(size: 11pt)
      let src = read("ejemplos/adivina/src/main/java/tb025/JuegoApp.java").split("\n").slice(4, 16).join("\n")
      raw(src, lang: "java", block: true)
    },
    {
      set text(size: 11pt)
      let src = read("ejemplos/adivina/src/main/java/tb025/JuegoApp.java").split("\n").slice(16).join("\n")
      raw(src, lang: "java", block: true)
    },
  )
]

#slide[
  = UML

  #grid(
    columns: (1fr, 0.5fr),
    align: (auto, horizon + center),
    gutter: 1cm,
    [
      *Unified Modeling Language:* proporciona una forma estándar de
      visualizar el diseño de un sistema.

      #image("umldiagrams.svg", width: 100%)
    ],
    [
      #image("umllogo.svg", width: 5cm)
    ],
  )

  #fuente("https://en.wikipedia.org/wiki/Unified_Modeling_Language")
]

#slide[
  = UML: Diagrama de clases

  #place(center + horizon)[
    #image("clases.svg", width: 80%)
  ]

  #fuente("https://www.planttext.com/?text=PL8zRy8m4DtpAsuCfQ3E31Me4nqwD6FLmJYdO1hVeVEvGaNzxpLn314TBClluvxlx7LG8nfzN-rTYs2Ts1whyENeQCHuy4nizy8UGILE6TkR43QgudPHSMkP6lU3y3IH24TgBGkX9BmQ7D1OGnVWN07CmP42uKctfFMi-YsYruWT3nA0HHP5Zy8DMa7b2PuMad8Oe7asrXV2czFRu7c4yRWTfRDHUu4xr0BN1N_747irBO_5ZGm5QNA_c-GycdRCFHe232yiWdQyv1oQD27gm2C5Sy3xYFg_x_7ESZ-MpV5uJIr0NQOQybvQ-MRNmY5sgOK2fGTNPpFZZQCwftryWf4k367N65wKvrgLoZVoOP7ZLoaWRPc0vVBvrbsrHchJv_e3")
]

#slide[
  = Relaciones entre clases (e interfaces)

  #grid(columns: (1fr, auto), align: center + horizon, gutter: 2cm,
    [#image("relaciones.png")],
    [#image("multiplicidad.png", width: 8cm)],
  )
]


#slide[
  = UML: Diagrama de secuencia

  #place(center + horizon)[
    #image("secuencia.svg", height: 95%)
  ]

  #fuente("https://www.planttext.com/?text=dLF1JiCm3BtdAtpS3Y3EQAh64IHE4wUTGcjL6MbSEIuVnvKVmstNT4t798WKHN7USvvVd7qKoz8rthIwkjArDWYyT5ZJKzkkWyQMGWnliRFio9YIqGhEX2FT5Ma7Zx3RZOYYw9dkSm5Ui4rYJHbkqKVq9RH2GMvSi0pX-wj19eYeR4dOfRBJaAR2B6yU67IQOywjBM-srqgwhEBiaX9UAGghiWP3j2S45zHLwutnH2qq3eCUnr7JVOto74H353TRAE31W8vhzYoG0ogh9X7pwjsPDY1M9kJthGkP-C2e7QIRCTCDve6yrYppyoprJXtL1oTIfZdaObCN_kRFg5AVAlpD7Isgys8h-gyzSuBnNYzp2312ISoeFsauxSUxjlb7sc6epBJsysfNxlL4F-uF")
]

#slide[
  = Java: Generalidades

  - El código se organiza en *paquetes* (carpetas) y *clases* (usualmente un archivo `.java` por cada clase).

  - Guía de estilo #linklet("https://github.com/pepperkit/java-style-guide")
    - Clases: `PascalCase` (ej. `Punto`)
    - Variables, atributos, y métodos: `camelCase` (ej. `x`, `calcularNorma`)
    - Constantes: `UPPER_CASE` (ej. `PI`, `MAX_INT`)

  - Crear una instancia de una `Clase`: `new Clase(...)`

  - Acceder a un atributo, invocar un método: `instancia.atributo`, `instancia.metodo(...)`

  - En un objeto mutable, es recomendable calificar sus atributos como `private`,
    para evitar que puedan ser manipulados desde fuera de la clase, y opcionalmente
    definir *métodos de acceso* (_getters_ y _setters_) públicos.

  - El modificador `final` indica que una variable o atributo es inmutable.

  - El modificador `static` indica que un atributo o método pertenece a la clase en sí, y no a una instancia específica.

  #fuente("https://docs.oracle.com/javase/tutorial/java/nutsandbolts/index.html")
]

#slide[
  = Tipos de datos

  #set text(size: 15pt)

  - Dos categorías: #linklet("https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html")
    - *Primitivos*: `int`, `double`, `boolean`, `char`, etc. (valor por defecto: `0`)
    - *Referencias*: apuntan a un objeto en memoria (ej: `Punto`, valor por defecto: `null`)

  - Arreglos: #linklet("https://docs.oracle.com/javase/tutorial/java/nutsandbolts/arrays.html")
    - Declaración: `int[] numeros;`
    - Inicialización: `numeros = new int[10];` #h(1em) `numeros = {1, 2, 3};`
    - Acceso: `numeros[0]` #h(1em) `numeros.length`
    - El tamaño de un arreglo es fijo una vez creado

  - Strings: #linklet("https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/lang/String.html")
    - Son instancias de la clase `String`
    - `"..."` es azúcar sintáctica para `new String(...)`
    - Inmutables

  - Colecciones dinámicas: #linklet("https://docs.oracle.com/javase/tutorial/collections/TOC.html")
    - Clases disponibles en la biblioteca estándar
    - `ArrayList`, `HashSet`, `HashMap`, etc.
]

#fin()
