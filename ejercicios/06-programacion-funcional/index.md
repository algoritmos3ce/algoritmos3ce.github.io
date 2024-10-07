---
title: "6. Programación funcional"
layout: default
parent: Ejercicios
nav_order: 6
---

# Programación funcional
{: .no_toc }

<!--
## Índice
{: .no_toc .text-delta }

1. Índice
{:toc}
-->

1. Definir la función `segundos` que reciba los cuatro valores (días, horas, minutos y
   segundos) del tiempo que dura un evento y devuelva el valor de ese tiempo expresado
   solamente en segundos.

1. Definir la función `capicua?` que reciba un número entero no negativo de hasta 5
   dígitos y devuelva true si el número es capicúa; si no, false.

1. Definir la función `aprox-pi` que reciba la cantidad de términos a considerar entre los
   paréntesis de la expresión `4 · (1 - 1/3 + 1/5 - 1/7 + ... + 1/n)` y devuelva la
   correspondiente aproximación de π.

1. Definir la función `nth-fibo` que reciba un número entero no negativo y devuelva el
   correspondiente término de la sucesión de Fibonacci.

1. Definir la función `qsort` que recibe una secuencia y la ordena usando el
   algoritmo Quicksort.

1. Definir la función `slice` que reciba una cadena `s` y un número `n` y devuelva una
   lista con todas las subcadenas contiguas de `s` cuyo tamaño sea `n`. Por ejemplo:

   ```
   (slice "abcde" 3) → ("abc" "bcd" "cde")
   ```

1. Definir una función que devuelva `true` si una frase es un pangrama (es decir, si
   contiene todas las letras del alfabeto); si no, `false`. Por ejemplo:

   ```
   (pangrama? "Fabio me exige, sin tapujos, que añada cerveza al whisky") → true
   ```

1. Definir una función que calcule la profundidad de una lista recursiva. Por ejemplo:

   ```
   (profundidad '((2 3)(3 ((7))) 5)) → 4
   ```

1. Comenzando desde la esquina superior izquierda de una grilla de 2x2, y solo
   pudiendo moverse hacia la derecha (`d`) y abajo (`a`), hay exactamente 6
   rutas a la esquina inferior derecha:

   ![](./0015.png)

   Definir la función `rutas` que reciba las dimensiones de la grilla y
   devuelva una colección con todas las rutas posibles. Por ejemplo:

   ```
   (rutas 2 2) → ("ddaa" "dada" "daad" "adda" "adad" "aadd")
   ```

----

<details>
  <summary>Soluciones</summary>
  <a href="https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/clojure">Ver</a>
</details>
