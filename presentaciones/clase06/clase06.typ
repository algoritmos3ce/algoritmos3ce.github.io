#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.0"

#import "../defs.typ": *

#show: default-style

#caratula[
  = Programación Lógica
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
  = Paradigmas de Programación

  - *Imperativos* (énfasis en la ejecución de instrucciones)

    - Programación Procedimental (ej. Pascal)
    - Programación Orientada a Objetos (ej. Smalltalk)

  - *Declarativos* (énfasis en la evaluación de expresiones)

    - Programación Funcional (ej. Haskell)
    - *Programación Lógica (ej. Prolog)*

  La Programación Lógica se basa en expresar *proposiciones, reglas y hechos
  lógicos*, y utilizar un *motor de inferencia* para resolver problemas.

  Es un paradigma *declarativo*, ya que se enfoca en _qué_ se quiere lograr
  en lugar de _cómo_ lograrlo, permitiendo que el motor de inferencia se
  encargue de la ejecución.
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

    / Átomos: `x`, `azul`, `hola_munto`, `'Hola, Mundo!'`.
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

  / `X /== Y`: Verdadero si `X` e `Y` no son términos idénticos.

  / `X = Y`: *Unifica* `X` e `Y` (falso si no son unificables).

  / `X /= Y`: Verdadero si  `X` e `Y` no son unificables.

  / `var(X)` / `atom(X)` / `number(X` / ...: Verdadero si `X` es una variable,
    átomo, número, etc.

  #fuente("https://www.swi-prolog.org/pldoc/man?section=builtin")
]

#slide[
  = Unificación

  Para resolver una consulta, el motor de Prolog comienza intentando
  *unificar* el objetivo con alguna de las cláusulas de la base de datos.

  La unificación es un proceso
  que intenta encontrar una correspondencia entre los términos, *unificando*
  o *instanciando* variables con valores concretos si es necesario.

  Por ejemplo:

  - `padre(homero, bart)` se unifica con `padre(homero, bart)`.
  - `padre(homero, bart)` #text(red)[no] se unifica con `padre(homero, lisa)`.
  - `padre(homero, X)` se unifica con `padre(homero, bart)` con `X = bart`.
  - `padre(P, X)` se unifica con `padre(homero, bart)` con `P = homero`, `X = bart`.
  - `2 + 3` #text(red)[no] se unifica con `5`.

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
  consulta. Para dibujar el árbol:

  1. Escribir la consulta en un recuadro en la parte superior de la página.
     El recuadro actúa como una lista de tareas pendientes.

  2. Dibujar las ramas basándose en la cantidad de cláusulas definidas para
     el predicado al que se dirige la consulta.

  3. Proceder con las ramas de izquierda a derecha. Si una rama corresponde
     a un hecho, ir al paso 4. Si una rama corresponde a una regla, ir al paso 5.

  4. Si la consulta no se unifica con el hecho, dibujar una cruz ($crossmark$,
     denotando una rama muerta); de lo contrario (la consulta se unifica
     con el hecho) dibujar un recuadro vacío ($square.stroked.big$, señalando que no queda
     nada por hacer).

  5. Si la consulta no se unifica con el encabezado de la regla, dibujar una cruz;
     de lo contrario, dibujar un nuevo recuadro con el cuerpo de la regla como
     nueva consulta. Ir al paso 2.

  #fuente("https://lpn.swi-prolog.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse6")
]

#slide[
  = Ejemplo

  #grid(columns: (1fr, auto, 1fr, auto, 1fr))[][
    Base de datos:

    ```prolog
    ama(vincent, mia).
    ama(marcellus, mia).
    celoso(A, B) :− ama(A, C), ama(B, C).
    ```

    Consulta:

    ```prolog
    ?- celoso(X, Y).
    ```
  ][][
    // https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22Page-1%22%20id%3D%223HUzLkMqPp62n1jcsH72%22%3E7Vpbc%2BIgGP01mWkf7BBIoj6qvT10dzrT2dnaN2owYZcEJ%2BKtv36JIYkEte56t%2Ftk%2BLgEvsM5HFQLdaLpQ4IH4TfuE2ZB4E8tdGtBaEPUlB9pZJZFGg7IAkFCfdWoDLzQD6KCebMR9clQayg4Z4IO9GCPxzHpCS2Gk4RP9GZ9zvS3DnBAjMBLDzMz%2BpP6IlSrcEEZfyQ0CPM320DVRDhvrALDEPt8shBCdxbqJJyL7CmadghLk5fnJet3v6K2mFhCYrFRh9bvPn%2FsY%2B%2Fh%2Be0H6r89ePW3mqPmJmb5gokv16%2BKPBEhD3iM2V0ZbSd8FPskHRXIUtnmifOBDNoy%2BIsIMVNg4pHgMhSKiKlaMqXiNe1%2B46pSd6HmdqpGnhdmeSEWyWyhU1rsLtaV3ealvF%2B2vnRRK9OmQkM%2BSnpkTa7y7YeTgIg17WABrmQF4RGR85H9EsKwoGN9Hlhtz6BoVyIoHxSIfwGom407xmyk3vQqi%2FMn0LKgx%2BTM2%2B%2BJfArSp25R2V66E57wuyS0hh5mNIjlc08mkCQyMCaJoJIxLVURUd%2FPNgoZ0g%2F8Ph8vxWLAaSzmC3bblntboJMOQKbWEjqrziWJNNxWbmgz%2BUp9YDbKxlCogZ7Ticsmao6woffg%2Ff5Q7ogqdMXr%2Fx1N20DTQve1ND%2BE8SG%2FktjKgUH32gBPJ%2BkkpIK8DPB8f0%2BkUuuQ9nks7nFEWZqmjuQBlcBC8J1M1mFkcMhMe56wuoJvVqhkVp6UkmrnB0O4IKcI7Ikm9U8StpWqwbOSNbihrHnHlLWGQYRWoVxjGqdaZIpbp2gSUXwZ8lZfy7MauHFsr65xbTeSV6vbOoOdg0kgMJDbIVXrF0nV5jGpapuHVsnVCMsVMjYafgm22mA5EGp4cAPcnEhb8tNFh%2BIjXGVJcISvWpkf6Vxnn2moXYZO2qI4ukWBwLQoRewgFsVG%2Fz2K5j02ED77qHcvu2lwo226lIsQNrRlnle4DLtCpv3JmLdOxpRmyXPoxFXL9iqq1VhysYKHVC2TAueYVwecWl7tJefuSaewujWRt%2BxANTMI95ZB58wyCE8ug%2B4%2BHcnxrmKf2wpnS%2Buy85MSVgQKVUHP5qV67eEWANZYnYVL3kWYHXctTWvyGoccRY0tYT2c%2Fyn274XdLj7%2FdQZtrMNbgumgCker6O6bo6ZluNDryJ4APOB1JN%2BVZ2NOqg756OYEnpu9c08ug1%2FV3sFV9m73R0LzyEeC%2BbXHxdo2eF62TRbL%2FwJlzct%2FVKG7Pw%3D%3D%3C%2Fdiagram%3E%3C%2Fmxfile%3E

    #image("arbol.png", width: 10cm)
  ][]
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
  = Entrada/Salida básica

  / `read(X)`: Lee un *término* (terminado con `.`) de la entrada estándar y
    lo unifica con `X`.

  / `write(X)`: Escribe el *término* `X` en la salida estándar.

  / `nl`: Escribe un salto de línea en la salida estándar.

  #fuente("https://www.swi-prolog.org/pldoc/man?section=termrw")
]

#slide[
  = El Modelo de Seguimiento de Prolog

  #grid(columns: (1fr, auto), gutter: 0.5cm)[
    Es podible _depurar_ un programa en Prolog utilizando el predicado `trace`.

    La ejecución del programa se describe de manera procedimental en términos
    de cuatro eventos:

    / *Call*: Se intenta resolver un objetivo.

    / *Exit*: El objetivo se resuelve exitosamente.

    / *Fail*: El objetivo no puede ser resuelto.

    / *Redo*: Se reintenta resolver un objetivo para encontrar más soluciones.
  ][
    #shadowed[ #image("trace.png", width: 15cm) ]
  ]

  #fuente("https://www.amzi.com/articles/prolog_under_the_hood.htm")
]

#fin()
