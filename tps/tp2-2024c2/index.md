---
title: "TP2"
layout: default
nav_order: 2
nav_exclude: true
---

# TP2: Befunge
{: .no_toc }

1. Índice
{:toc}


El objetivo de este trabajo práctico es implementar un intérprete del lenguaje
[Befunge-93](https://en.wikipedia.org/wiki/Befunge), en Clojure.

El TP se desarrolla en forma **grupal**, en grupos de 2 integrantes.

La especificación oficial de Befunge-93 se encuentra en [este
documento](https://github.com/catseye/Befunge-93/blob/master/doc/Befunge-93.markdown).
A continuación se incluye una adaptación de dicho documento al español.

## Especificación de Befunge-93

_Un trenzado, desquiciado lenguaje de programación en la tradición de
[brainfuck](http://esolangs.org/wiki/Brainfuck) y
[FALSE](http://esolangs.org/wiki/FALSE)._

Probablemente el elemento más destacable de Befunge-93 es el
Contador de Programa (PC). En casi todos los lenguajes de programación de
computadoras el contador de programa es un número entero que se incrementa
continuamente a medida que se ejecuta el programa, ocasionalmente "saltando" a
otro punto del código (pero continuando hacia adelante a partir de entonces).

El PC en Befunge-93, sin embargo, está sujeto a reglas diferentes. Se puede ir
hacia adelante, hacia atrás, izquierda o derecha. Un programa Befunge-93 es
tratado como un toroide (una página que se envuelve sobre sí misma alrededor de los
bordes) de 80x25 caracteres ASCII. Ciertos comandos cambian la dirección de la
marcha del PC. De forma predeterminada, el PC apunta a la esquina superior izquierda
del programa, y está orientado a moverse hacia la derecha.

Cada comando en Befunge-93 es un único caracter. No hay
variables, solo una pila de valores numéricos. Además, un programa
Befunge-93 puede auto-modificarse.

### La pila

Similar a Forth y PostScript, Befunge-93 proporciona una pila LIFO de números
enteros con signo, que permite realizar operaciones como una calculadora en
Notación Polaca Inversa (RPN or _postfix_).
El acto de colocar un valor en la pila se llama _apilar_ (push), y el acto de
tomar un valor de la pila se llama _desapilar_ (pop).
Los dígitos de `0` a `9` son comandos Befunge-93 que apilan sus respectivos
valores en la pila. Una comilla doble (`"`) alterna el _modo cadena_, y
mientras este modo está activo, todos los caracteres de las celdas tendrán su
valor ASCII apilados en la pila hasta que la otra `"` se encuentre.

Hay algunos comandos básicos de cálculo:

    + sumar
    - restar
    / división entera
    * multiplicación
    % módulo
    ! negación lógica

Estos son explicados en mayor detalle en la sección de Comandos.

La única forma de apilar un número mayor que 9 en la pila es realizando
cálculos con números menores o iguales a 9. En cualquier otro lenguaje, esto sería
muy molesto. En Befunge-93 es una alegría. Por ejemplo, para apilar el número 123 en la
pila, uno podría apilar 9, 9, luego multiplicar (dejando 81), luego
apilar 7, luego 6, luego multiplicar (dejando 81 y 42), luego
sumar (dejando 123). En Befunge esto sería algo como:

```
99*76*+
```

Esto es, por supuesto, asumiendo que el PC se inicia en el primer 9
y se mueve hacia la derecha.

{: .nota }
Si la pila está vacía al desapilar un valor (_pop_), ¡esto no generará
un error! Simplemente se obtiene el valor 0, como si la pila hubiese contenido
ese valor antes de desapilar.

### El Contador de Programa (PC) en detalle

Hay 5 comandos que incondicionalmente controlan la dirección del PC: `>`, `<`, `v`, `^`, y
`?`. `>` hace que el PC viaje hacia la derecha; `<` a la izquierda; `v` abajo; `^` arriba;
y `?` en una dirección al azar. Así, el siguiente ejemplo es un bucle infinito:

```
><
```

Como es:

```
>v
^<
```

Como es:

```
>v>v
 >^
^  <
```

Tener en cuenta que el comando ` ` (espacio) es _noop_ (un comando que no hace nada).

Si el PC llega al "borde" del programa, por ejemplo si intentamos
ejecutar:

```
<
```

El PC se "teletransporta" al borde opuesto del programa. Este ejemplo, entonces, es un bucle infinito.

### Toma de decisiones

Los comandos en Befunge-93 que se comportan como `if` son `_` y `|`. Ambos
comandos desapilan un valor de la pila, comprueban si es verdadero (distinto de
cero), y cambiar la dirección de la PC en consecuencia:

* `_` actúa como `<` si el valor es verdadero o `>` si es falso
* `|` actúa como `^` si el valor es verdadero o `v` si es falso.

Un bucle `while` puede ser hecho insertando un `if` en un bucle
infinito. Por ejemplo,

```
>_@
```

Este fragmento de programa desapila todos los valores distintos de cero fuera
de la pila, y ante el primer valor cero, finaliza (`@` es el comando para
finalizar).

### Salida

El comando `.` desapila un valor y lo imprime en la salida estándar como un
valor decimal, seguido por un espacio. El comando `,` desapila un valor, lo
interpreta como el valor ASCII de un caracter, e imprime ese caracter en la
salida estándar (no seguido de un espacio).

Por ejemplo,

```
665+*1-,
```

Imprime el valor ASCII 65 (`"A"`).

```
665+*1-.
```

Imprime `"65 "`.

### Entrada

El comando `~` obtiene el siguiente byte de la entrada estándar y apila su
valor numérico.

El comando `&` obtiene de la entrada estándar un valor numérico expresado como
una serie de dígitos (leyendo caracteres de la entrada estándar hasta encontrar
el primer caracter que no sea un dígito), interpreta el número en notación
decimal y lo apila.

Por ejemplo,

```
&,
```

Imprime `"A"` si el usuario escribe `"65 "`.

```
~.
```

Imprime `"65 "` si el usuario escribe `"A"`.

### Comandos Especiales

El comando `#` es el "puente", que hace que el siguiente comando que
normalmente se ejecutaría sea salteado, y no se ejecute. Por ejemplo,

```
>123...@
```

Produciría la salida `"3 2 1 "`, pero

```
>123#...@
```

produce la salida `"3 2 "` con uno de los `.` omitidos.

El comando `:` desapila un valor y lo apila dos veces. Esto es útil, como se
demuestra en el siguiente programa:

```
v.<
>:|
  @
```

Este programa duplica cada valor de la pila, comprueba que no sea cero, y lo
imprime.

El comando `$` desapila un valor y lo descarta. Así,

```
123.$.@
```

Imprime `"3 1 "`.

El comando `\` intercambia los dos primeros elementos de la pila. Así,

```
123\...@
```

Imprime `"2 3 1 "`.

El comando `` ` `` (comilla invertida) es "mayor que". Desapila dos valores y
apila 1 si el primero es mayor que el segundo. Por ejemplo,

```
65`.
```

Imprime `"1 "`.

```
25`.
```

Imprime `"0 "`.

### Auto-modificación

Los dos últimos comandos que deben ser explicados son los que permiten examinar
y cambiar el contenido del toroide donde el programa se almacena. Este "campo de
juego" puede ser utilizado para el almacenamiento auxiliar cuando la pila sola
no sea suficiente, pero hay que tener en cuenta que también contiene el programa en
ejecución.

El comando `g` examina el contenido del campo de juego. Desapila una coordenada
`y`, luego una coordenada `x`. Apila el valor ASCII del caracter que se
encuentra en `(x, y)`. Desde el punto de vista del texto del programa, `x`
determina la columna e `y` determina la fila; `(0, 0)` se refiere a la primera
columna (izquierda) y la primera fila (superior) del código del programa.

El comando `p` modifica el contenido del campo de juego. Se desapila una
coordenada `y`, luego `x`, y a continuación un valor. Se coloca
el valor (interpretado como el valor ASCII de uun
caracter) en el toro en `(x, y)`.

### Apéndice A. Resumen de comandos

```
COMMAND         INITIAL STACK (bot->top)RESULT (STACK)
-------         -------------           -----------------
+ (add)         <value1> <value2>       <value1 + value2>
- (subtract)    <value1> <value2>       <value1 - value2>
* (multiply)    <value1> <value2>       <value1 * value2>
/ (divide)      <value1> <value2>       <value1 / value2> (nb. integer)
% (modulo)      <value1> <value2>       <value1 mod value2>
! (not)         <value>                 <0 if value non-zero, 1 otherwise>
` (greater)     <value1> <value2>       <1 if value1 > value2, 0 otherwise>
> (right)                               PC -> right
< (left)                                PC -> left
^ (up)                                  PC -> up
v (down)                                PC -> down
? (random)                              PC -> right? left? up? down? ???
_ (horizontal if) <boolean value>       PC->left if <value>, else PC->right
| (vertical if)   <boolean value>       PC->up if <value>, else PC->down
" (stringmode)                          Toggles 'stringmode'
: (dup)         <value>                 <value> <value>
\ (swap)        <value1> <value2>       <value2> <value1>
$ (pop)         <value>                 pops <value> but does nothing
. (output int)  <value>                 outputs <value> as integer
, (output char) <value>                 outputs <value> as ASCII
# (bridge)                              'jumps' PC one farther; skips
                                        over next command
g (get)         <x> <y>                 <value at (x,y)>
p (put)         <value> <x> <y>         puts <value> at (x,y)
& (input int)                           <value user entered>
~ (input character)                     <character user entered>
@ (end)                                 ends program
```

## Implementación en Clojure

El proyecto debe estar programado en Clojure utilizando Leiningen.

El programa debe recibir por la línea de comandos (que se recibirá como
parámetro en la función `-main`) la ruta del archivo que contiene el programa a
ejecutar.

Por ejemplo, si `hello.bf` contiene:

```
                 v
>v"Hello world!"0<
,:
^_25*,@
```

entonces al ejecutar:

```
$ lein run hello.bf
```

la salida debe ser:

```
Hello world!
```

{: .nota }
El toroide que contiene el programa tiene 80 columnas y 25 filas, pero normalmente
el archivo que contiene el código tendrá menos filas y columnas. Se asume que
todas las celdas del toroide que no hayan sido especificadas en el archivo
contienen el caracter ` ` (espacio).

{: .importante }
No se permite utilizar ninguna función que produzca efectos secundarios,
excepto aquellas necesarias para leer el código del programa, y para los
comandos `?`, `~`, `&`, `.` y `,`.

## Pruebas

[Este repositorio](https://github.com/catseye/Befunge-93/tree/master/eg)
contiene una colección de programas Befunge-93. Se espera que el intérprete sea
capaz de ejecutar por lo menos:

* [`hello.bf`](https://github.com/catseye/Befunge-93/blob/master/eg/hello.bf)
* [`maze.bf`](https://github.com/catseye/Befunge-93/blob/master/eg/maze.bf)
* [`chars.bf`](https://github.com/catseye/Befunge-93/blob/master/eg/chars.bf)
* [`prime.bf`](https://github.com/catseye/Befunge-93/blob/master/eg/prime.bf)
* [`serp2.bf`](https://github.com/catseye/Befunge-93/blob/master/eg/serp2.bf)
* [`palinqn.bf`](https://github.com/catseye/Befunge-93/blob/master/eg/palinqn.bf)
* [`life.bf`](https://github.com/catseye/Befunge-93/blob/master/eg/life.bf)

