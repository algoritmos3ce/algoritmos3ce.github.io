#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.0"

#import "../defs.typ": *

#show: default-style

#caratula[
  = Programación Lógica
]

#slide[
  = Paradigmas de Programación

  - *Imperativos* (énfasis en la ejecución de instrucciones)

    - Programación Procedimental (ej. Pascal)

    - Programación Orientada a Objetos (ej. Smalltalk)

  - *Declarativos* (énfasis en la evaluación de expresiones)

    - Programación Funcional (ej. Haskell)

    - #emphbox-small[*Programación Lógica (ej. Prolog)*]

  La Programación Lógica se basa en expresar *proposiciones, reglas y hechos
  lógicos*, y utilizar un *motor de inferencia* para resolver problemas.

  Es un paradigma *declarativo*, ya que se enfoca en _qué_ se quiere lograr
  en lugar de _cómo_ lograrlo, permitiendo que el motor de inferencia se
  encargue de la ejecución.
]

#slide[
  = Programación Lógica

  #grid(columns: (1fr, auto, 1fr, auto, 1fr))[][
    Base de datos

    ```prolog
    padre(homero, bart).
    padre(homero, lisa).
    padre(homero, maggie).

    madre(marge, bart).
    madre(marge, lisa).
    madre(marge, maggie).

    hermanos(X, Y) :- padre(P, X), padre(P, Y),
                      madre(M, X), madre(M, Y),
                      X \= Y.
    ```
  ][][
    Consulta / Objetivo

    ```
    ?- hermanos(bart, X).
    X = lisa ;
    X = maggie.
    ```
  ][]

  #fuente("https://swish.swi-prolog.org/p/IajwiKgo.pl")
]

#slide[
  = Historia

  / 1960s: Las ideas fundamentales surgieron de la demostración automática de
    teoremas y la investigación en IA. El avance clave fue el
    *Principio de Resolución* en 1965, una regla de inferencia única y poderosa
    para la lógica de primer orden que las computadoras podían implementar.

  / 1970s: Se desarrolla la regla de *inferencia SLD*, una extensión del
    Principio de Resolución que permite la ejecución de programas lógicos.

    Inspirados por estas ideas, Alain Colmerauer y Philippe Roussel
    desarrollaron *Prolog* (*PROgrammation en LOGique*).
    Su propósito inicial era procesar el lenguaje natural (francés).

  / 1980s: Prolog y lenguajes similares son utilizados principalmente
    en ámbitos académicos y de investigación, para aplicaciones como
    *demostración de teoremas*, *sistemas expertos*,
    *sistemas de tipos* y *procesamiento de lenguaje natural*.

  / 1990s: Prolog es estandarizado como *ISO Prolog*.

  #fuente("https://en.wikipedia.org/wiki/Logic_programming")
]

#slide[
  = Definiciones

  / Proposición: una afirmación lógica que puede ser verdadera o falsa.

    Ejemplo: "Hoy es martes"

  / Axioma / Hecho: una proposición aceptada como verdadera sin necesidad de prueba.

  / Regla: una proposición que define una relación entre hechos y/o otras reglas.

    Ejemplo: "Si llueve, entonces la calle está mojada"

  / Base de datos: un conjunto de hechos y reglas que representan el conocimiento
    en un dominio específico.

  / Objetivo / Consulta: una proposición que se desea demostrar o refutar.

  / Estrategia de resolución: el proceso de buscar una solución a un objetivo
    utilizando la base de datos.

  / Programa lógico: Compuesto por una *base de datos* y un *objetivo*.
    Al ser ejecutado, un *motor de inferencia* se encarga de *probar* o
    *refutar* el objetivo, utilizando alguna *estrategia de resolución*.
]

#slide[
  = Prolog: tipos de datos

  #set text(size: 13pt)

  Prolog es *dinámicamente tipado*. Todo valor en Prolog se representa mediante
  un *término*, que tiene varios subtipos:

  / Términos atómicos:

    / Átomos: `x`, `azul`, `hola_mundo`, `'Hola, Mundo!'`.
    / Números: enteros y números de punto flotante. Ejemplos: `42`, `3.14`.
    / Variables: `X`, `Resultado`, `_temp`. \
      Las variables son *unificadas* con otros términos durante la resolución
      de objetivos.

      La variable `_` representa una variable anónima y significa "cualquier
      término".

  / Términos compuestos:
    / Estructuras: consisten en un átomo (el
      *functor*) seguido de una lista de argumentos entre paréntesis.
      Ejemplos: `padre(juan, maria)`, `suma(X, Y, Resultado)`.

      La *aridad* es el número de argumentos que tiene.
      La notación `f/n` se usa para referirse a un functor `f` con aridad `n`.
      Por ejemplo: `padre/2`.

      *Azucar sintáctica:* Algunos predicados que pueden ser escritos como
      operadores *infijos*. Por ejemplo: `=(X, Y)` es equivalente a `X = Y`.
    / Listas: `[]`, `[1, 2, 3]`, `[X, Y]` \
      Si `T` es una lista, `[H|T]` es una lista con cabeza `H` y cola `T`.
    / Cadenas: `"Hola, Mundo!"`

  #fuente("https://en.wikipedia.org/wiki/Prolog_syntax_and_semantics")
]

#slide[
  = Prolog: Cláusulas

  #set text(size: 15pt)

  Una base de datos Prolog se compone de un conjunto de *cláusulas*, que pueden
  ser *reglas* o *hechos*:

  ```prolog
  q :- p.   % regla
  h.        % hecho
  ```

  El operador `:-` se lee como $arrow.l.double$, de forma que la regla
  se lee como "`p` entonces `q`". El *encabezado* de la regla es `q`, y
  el *cuerpo* es `p`.

  Dos o más cláusulas con el mismo functor se consideran parte del mismo
  *predicado*. Por ejemplo:

  ```prolog
  padre(homero, bart).
  padre(homero, lisa).
  padre(homero, maggie).
  ```

  La *consulta* se escribe como `?- t.` donde `t` es un término. Por ejemplo:

  ```prolog
  ?- padre(homero, X).
  ```
]

#slide[
  = Predicados predefinidos

  Disponemos de una gran cantidad de predicados predefinidos, por ejemplo:

  / `true` / `false` (`fail`): Siempre evalúan a verdadero o falso, respectivamente.

  / `A, B`: Verdadero si `A` y `B` son ambos verdaderos (_and_).

  / `A; B`: Verdadero si `A` o `B` (o ambos) son verdaderos (_or_).

  / `X == Y`: Verdadero si `X` e `Y` son términos idénticos.

  / `X \== Y`: Verdadero si `X` e `Y` no son términos idénticos.

  / `X = Y`: *Unifica* `X` e `Y` (falso si no son unificables).

  / `X \= Y`: Verdadero si  `X` e `Y` no son unificables.

  / `var(X)` / `atom(X)` / `number(X)` / ...: Verdadero si `X` es una variable,
    átomo, número, etc.

  #fuente("https://www.swi-prolog.org/pldoc/man?section=builtin")
]

#slide[
  = Unificación

  Dos términos *unifican* si pueden representar la misma estructura.
  Si alguno de los términos contiene variables, éstas se *instancian*
  para lograr la unificación.

  Por ejemplo:

  - `padre(homero, bart)` #text(verde)[unifica] con `padre(homero, bart)`.
  - `padre(homero, bart)` #text(rojo)[no unifica] con `padre(homero, lisa)`.
  - `padre(homero, X)` #text(verde)[unifica] con `padre(homero, bart)` instanciando `X = bart`.
  - `padre(P, X)` #text(verde)[unifica] con `padre(homero, bart)` instanciando `P = homero`, `X = bart`.
  - `2 + 3` #text(rojo)[no unifica] con `5`.

  Para *resolver una consulta*, el motor de Prolog:

  - Intenta unificar el objetivo con alguna de las cláusulas de la base de datos (buscando de arriba hacia abajo).
  - Para las cláusulas de tipo `q :- p`, el objetivo debe unificar con `q`.
  - Si la cláusula unificada tiene un cuerpo `p`, se intenta resolver la consulta `?- p.`, con las variables instanciadas en la unificación de `q`.
]


#slide[
  #grid(columns: (1fr, auto), gutter: 0.5cm)[
    = Backtracking

    Es posible que un objetivo pueda ser unificado con más de
    una cláusula. En este caso, Prolog sigue una estrategia
    de búsqueda de tipo *depth-first*:
    unifica el objetivo con la primera de las alternativas y continúa la búsqueda.
    En caso de que alguno de los sub-objetivos falle, la búsqueda
    retrocede (*backtracking*), deshace todas las unificaciones hechas,
    y prueba con la siguiente alternativa.

    Notar que el orden de las cláusulas en la base de datos
    afecta el resultado de la consulta, ya que Prolog intentará unificar las cláusulas
    en el orden en que aparecen.
  ][
    #image("drstrange.jpg", width: 8cm)
  ]
]

#slide[
  = Árbol de búsqueda

  Un *árbol de búsqueda* es una manera de mostrar cómo Prolog resuelve una
  consulta.

  #grid(columns: (1fr, auto, 1fr, auto, 1fr))[][
    Base de datos:

    ```prolog
    f(a).
    f(b).
    g(a).
    g(b).
    h(b).
    k(X) :- f(X), g(X), h(X).
    ```

    Consulta:

    ```prolog
    ?- k(Y).
    ```
  ][][
    // https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22Page-1%22%20id%3D%223HUzLkMqPp62n1jcsH72%22%3E5Vldc6IwFP01zHQfdICg2MdWq33odrrb2V3tW5QA2SJxQqzaX78BwmcA3dWKne1DJzlJLsm995x8qIDhcjuhcOV%2BJRbyFF21tgoYKbpuaCr%2FHwK7GNAHAnAotmJIy4Bn%2FI4EmHRbYwsFhY6MEI%2FhVRFcEN9HC1bAIKVkU%2BxmE6%2F41RV0kAQ8L6Ano7%2BwxdwYHfTUDL9H2HGTL2uqaFnCpLMAAhdaZJODwJ0ChpQQFpeW2yHyQt8lfonHjWta04lR5LODBty82uTehv3J08sPYL9M%2BuZLxxBzY7tkwcji6xdVQplLHOJD7y5DbylZ%2BxYKraq8lvV5IGTFQY2DvxFjOxFMuGaEQy5beqIVbTGbhsO7PVGb5VpGW2E5quySis%2FoLjcorM7ybdmwqJaMk70kHBeQNV2gBtck2Qapg1hDPz3uF%2Fot9wERgwkiS8TnwztQ5EGG34p5BUV6Omm%2FLIK8IIJYkx%2BPjvbNMLzvtzYbP45Uc%2FLzvqP1Y8Nv0FuLT814NSqp08poP8A552whQtDDjs%2FLC%2B41RDnwhijDnBU3omGJLStOBhTgdziP7IX%2BXhHss2hRvVulN0ojEBpA2yrKisEZUQrBqk1a2cHCekftateGSGyhOkkwD46BsP4UriYzXR5BbDvguVGOWTqng8LYlHy5KCpg3OHI69XsS1cKY5GSGxcz9LyCUXpvuCwXg2sTn43hEnuhc4acBpiHmGcT2jTxRQpgbQBAIoG7VBPj%2BiYnoAJyc9oJ1OM5UelMc4%2B%2FjpIw%2FZI1TD9Qw%2FptaVjlbAZS8k9TCYPtSdheXTL%2FUuqaJMzQ%2BmaBRfpJFKzTK1odnEvQ9DpBs6%2BmXxR9GB710pLLSxcucrpRFDldlUUuxc6ichr4SJm7ZJXrH6hyWmtHtaZpy5RwrmBKBHjpRNAGJSIMZCJo%2BlmJUKs1n9CdoH9Gd1beKCrStOxBfrVdhcUFJUGw34eUME4vEm7CRigRNva85MoZEC%2BcTYQNiUdo9AV%2BpAz%2FOB7EUqV2gQ40wzSvr1WVi%2FEANN00pIjUyzoout%2BolHXZ%2B%2FpHeV8%2BC6UiMU9FYn6GrD7KraBNkai%2BJ6t7PPYpdsvSTlbcA6vXfXjsjjxqGqUTEtBKsYz3dTHqqBNn40qrtoFPR5j2t4FkV%2F3vCANaI8z1mQkD9u%2F0F0USo7xZGy1v1pr8nH5CjpitkeRET0%2F1B5yTc6n8Bple1%2FdwSX7y7ZUMlUkZL%2FDjSNmTSJk9hs2ldLv09%2FwG2rTwGlb6lUAziwb%2B5TWMV7Of9OLu2e%2Bi4O4P%3C%2Fdiagram%3E%3C%2Fmxfile%3E

    #image("arbol2.png", width: 10cm)
  ][]

  #fuente("https://lpn.swi-prolog.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse6")
]


#slide[
  = Árbol de búsqueda (cont.)

  #grid(columns: (1fr, auto, 1fr, auto, 1fr))[][
    Base de datos:

    ```prolog
    ama(vincent, mia).
    ama(marcellus, mia).
    celoso(A, B) :- ama(A, C), ama(B, C).
    ```

    Consulta:

    ```prolog
    ?- celoso(X, Y).
    ```
  ][][
    // https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22Page-1%22%20id%3D%223HUzLkMqPp62n1jcsH72%22%3E5VrLctowFP0azyQLGFuyDVkCScgi7WQm02lgp2Bhq7UtRohXvr4ylvwSEFoeMXQV6%2BpKsu695%2BjIwYC9aNlnaBJ8ox4ODWB6SwPeGwBYAJriT2JZpZa2LQ0%2BI550yg2v5ANLo3KbEQ9PS46c0pCTSdk4onGMR7xkQ4zRRdltTMPyqhPkY83wOkKhbv1JPB7IXThmbn%2FCxA%2FUypYpeyKknKVhGiCPLgom%2BGDAHqOUp0%2FRsofDJHgqLum4xy292YsxHPO9BnR%2Bj%2BnTGLn9l%2BEPOB723dawYct34yu1YeyJ%2FcsmZTygPo1R%2BJBbu4zOYg8ns5qilfs8UzoRRksYf2HOVzKZaMapMAU8CmUvXhL%2BlgxvOrI1KPTcL%2BXM68ZKNWLOVoVBSXNQ7MuHrVtqnB4lGbgpnbER3hEaVW2I%2BZjv8AOpXxK3wgIyB31MIyzeRzgwHCJO5uW6QrI8%2Fcwvz6B4kEn8i4Q66bxzFM7kSm%2BiuX4yOwZwQ7GV7jsTT37yNMg6uxsr4Rm9C0CXsodC4sfieSQiipkwzDHjRCCmIzsi4nlpoeAp%2BUDv6%2FmSXEwoifl6w07XcO43Z2dHlSYL4aWxAfZykRKySsGX7CNztXcq5EQvyYsLF7k2aJdH0PF4Kkqkmrps%2BX%2FPpqVl04CPjWTfOKRTeiNyKyY2B7dNLXtllC4CwvHrBK0rfiGoupzTMY35I4pImMSpJ5BBRGaB%2BR0vdkFIy4cedxWxliTBVUaTaXuRc6qlToagwKfq%2BDg6TlqfBOwgWgN15jWwJ6%2B5teK1toaETkZdcxInZKSzWy9ziQiqMb%2B1DuY3OaphNm3LbZWwdhzOa7SsMoLts3GgqWXuiFBtXQNU72oFVUs%2FtXKsRkhsOQxn08tFqyrIw%2BFqNk1HAelAfDrwXHgE2zQJitBNJxUkvdv0b2LqKlPdNYpd1ijA1DVKZjuLRrHgfytS3D2Zz6rX7cu608DR1WVKfZkNHsxsh8oMqwKm0%2FGYu4vHJGmJg6jutGW5Fdpqb7hagXPSlo6BiwysbdYtsIrsipGtdQirtQndTUeqHkFwsgjaFxZBULsIOqfUJLW%2Bje2tSexja5ItnyErBAWrSU93JEed4CKg7kGbxE7hnldfuaM%2Blh%2Fju4sJbTndgWk9nwLKKv%2Fq7hef%2F9MGngejNqxgtJrdU2NUlwyXdCHZemBe44VE1eTFiJOqQv5ycQIuTd45tYvg1cq7z4%2BEM8k2%2B%2B6LjwT9w8dlyTZwtbJNNPPfA6Xu%2Ba%2Bq4MMf%3C%2Fdiagram%3E%3C%2Fmxfile%3E

    #image("arbol.png", width: 12cm)
  ][]

  #fuente("https://lpn.swi-prolog.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse6")
]

#slide[
  = El modelo de seguimiento de Prolog

  #grid(columns: (1fr, auto), gutter: 0.5cm)[
    #set text(size: 13pt)
    Es podible _depurar_ un programa en Prolog utilizando el predicado `trace`.

    La ejecución del programa se describe de manera procedimental en términos
    de cuatro eventos:

    / *Call*: Se intenta resolver un objetivo.

    / *Exit*: El objetivo se resuelve exitosamente.

    / *Fail*: El objetivo no puede ser resuelto.

    / *Redo*: Se reintenta resolver un objetivo para encontrar más soluciones.
  ][
    #image("trace.png", width: 15cm)
  ]

  #place(bottom+center)[ #shadowed[ #image("trace3.png", width: 4.8cm) ] ]

  #fuente("https://www.amzi.com/articles/prolog_under_the_hood.htm")
]

#slide[
  = El modelo de seguimiento de Prolog (cont.)

  #grid(columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr))[][
    #set text(size: 13pt)

    #v(0.1fr)
    ```prolog
    f(a).
    f(b).
    g(a).
    g(b).
    h(b).
    k(X) :- f(X), g(X), h(X).
    ```

    ```prolog
    ?- k(Y).
    ```
    #v(0.1fr)
  ][][
    #v(0.1fr)
    #image("arbol2.png", width: 10cm)
    #v(0.1fr)
  ][][
    #v(0.1fr)
    #image("trace2.png", height: 1fr)
    #v(0.1fr)
  ][]

  #fuente("https://lpn.swi-prolog.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse6")
]

#slide[
  = Entrada/Salida básica

  / `read(X)`: Lee un *término* (terminado con `.`) de la entrada estándar y
    lo unifica con `X`.

  / `write(X)`: Escribe el *término* `X` en la salida estándar.

  / `nl`: Escribe un salto de línea en la salida estándar.

  #fuente("https://www.swi-prolog.org/pldoc/man?section=termrw")
]

#slide[
  = Predicados de control

  / `repeat`: Siempre tiene éxito, y provee un número infinito de soluciones
    mediante backtracking. Útil para generar bucles. Ejemplo:

    ```prolog
    pedir_clave :- repeat, write('Ingrese un numero: '), read(X), X == 42.
    ```

  / `!`: Proposición de corte. Siempre tiene éxito de
    inmediato, pero no puede ser resatisfecha a través del backtracking. Por lo tanto, las submetas a
    su izquierda, en una meta compuesta, tampoco pueden ser resatisfechas mediante backtracking.

    ```prolog
    f(a) :- !.
    f(b).
    ```

  / `\+`: "No demostrable". Verdadero si el objetivo no puede ser satisfecho.

    ```prolog
    ilegal(robar).
    ilegal(evadir_impuestos).
    legal(X) :- \+ ilegal(X).
    ```

  #fuente("https://www.swi-prolog.org/pldoc/man?section=control")
]

#slide[
  = El problema de la negación

  Prolog adopta el *modelo de mundo cerrado*: *todo lo que no se pueda
  demostrar como verdadero, es falso*.

  De esta manera el predicado `\+` implementa la *negación por falla*:

  ```prolog
  \+ P :- P, !, fail.
  \+ _ :- true.
  ```

  Esto puede llevar a resultados inesperados, dado que la _negación por falla_
  no es equivalente a la _negación lógica_.

  Por ejemplo, dada la regla `legal(X) :- \+ ilegal(X).`, la consulta
  `?- legal(X)` no puede ser usada para listar todos los valores de `X`
  que son legales.

  #fuente("https://www.swi-prolog.org/pldoc/doc_for?object=(%5C%2B)/1")
]

#slide[
  = Aritmética

  El operador `is` permite escribir predicados que involucran expresiones
  aritméticas, pero tiene algunas limitaciones. En su lugar, se recomienda
  usar la biblioteca `clp(fd)`:

  ```prolog
  :- use_module(library(clpfd)).
  ```

  / Comparaciones: `A #= B`, `A #< B`, `A #> B`, etc.
  / Operaciones: `A + B`, `A - B`, etc.

  Ejemplo:

  ```prolog
  R = 2 + 3.   % R se unifica con el término +(2, 3)
  R #= 2 + 3.  % R se unifica con el número 5
  ```

  #fuente("https://www.swi-prolog.org/pldoc/man?section=clpfd-predicate-index")
]

#slide[
  = Listas

  Los predicados que involucran listas suelen ser recursivos. Ejemplo:

  ```prolog
  longitud([], 0).
  longitud([_|T], L) :- longitud(T, L1), L is L1 + 1.
  ```

  Algunos predicados predefinidos para operar con listas:

  / `member(X, L)`: Verdadero si `X` es un elemento de la lista `L`.

  / `append(L1, L2, L3)`: Verdadero si `L3` es la concatenación de `L1` y `L2`.

  / `reverse(L, R)`: Verdadero si `R` es la lista `L` invertida.

  / `permutation(L1, L2)`: Verdadero si `L2` es una permutación de `L1`.

  #fuente("https://www.swi-prolog.org/pldoc/man?section=lists")
]

#slide[
  = Links

  / SWI-Prolog: #linklet("https://www.swi-prolog.org/")

    Entorno de programación Prolog y recursos adicionales

  / SWISH: #linklet("https://swish.swi-prolog.org/")

    Intérprete online de SWI-Prolog

  / SWISH Examples: #linklet("https://swish.swi-prolog.org/example/examples.swinb")

    Ejemplos de programas escritos en SWI-Prolog

  / Learn Prolog Now!: #linklet("https://lpn.swi-prolog.org/lpnpage.php?pageid=top")

    Libro online

  / The Power of Prolog: #linklet("https://www.metalevel.at/prolog")

    Libro online
]

#fin()
