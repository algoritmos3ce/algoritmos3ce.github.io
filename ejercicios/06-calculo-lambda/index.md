---
title: "6. Cálculo Lambda"
layout: default
parent: Ejercicios
nav_order: 6
---

# Cálculo Lambda
{: .no_toc }

<!--
## Índice
{: .no_toc .text-delta }

1. Índice
{:toc}
-->

1. Escribir las siguientes expresiones con el menor número de paréntesis posible:

    {: .partes}
    1. `(λx.(λy.(λz.((x z) (y z)))))`
    1. `(((a b) (c d)) ((e f) (g h)))`
    1. `(λx.((λy.(y x)) (λv.v) z) u) (λw.w)`

2. Restaurar todos los paréntesis descartados en las siguientes expresiones:

    {: .partes}
    1. `x x x x`
    1. `λx.x λy.y`
    1. `λx.(x λy.y x x) x`

3. Para las siguientes expresiones lambda:

    * Identificar las ocurrencias de variables libres y ligadas.
    * Reducir a su forma normal aplicando las reglas alfa, beta y eta, utilizando
       orden normal y orden aplicativo, y comparar los resultados.

    {: .partes}
    1. `( λx.( ( λ y.y ) x ) ) z`
    1. `( λx.λy.x y ) ( z y )`
    1. `( λx.λy.x ) x y`
    1. `( λx.( ( λ z.z x ) ( λ x.x ) ) ) y`
    1. `( λx.( ( λ y.x y ) z ) ) ( λx.x y )`
    1. `( ( λy.( λx.( ( λ x.λy.x ) x ) ) y ) M ) N`
    1. `( λx.λy.λx.x y z ) (λx.λy.y) M N`
    1. `( ( λx.( λy.λz.z ) x ) ( ( λ x.x x x ) ( λ x.x x x ) ) ) x`

4. Probar que:

    {: .partes}
    1. `C I = λy z.z y`
    1. `K I = O`
    1. `S (K S) K = B`

5. Definir en Cálculo Lambda las siguientes operaciones lógicas: NOR, NAND,
   XNOR, y verificar para cada una su tabla de verdad.

6. Verificar que:

    {: .partes}
    1. `Pred 5 = 4`
    1. `IsZero 2 = False`
    1. `Add 2 3 = 5`
    1. `Sub 3 1 = 2`
    1. `Mul 2 3 = 6`
    1. `Div 6 2 = 3`
    1. `Pow 2 3 = 8`
    1. `Fibo 6 = 8`
    1. `Fact 3 = 6`

7. ¿Por qué a `(Y K)` se lo conoce como el Pac-Man? Reducir `(Y K) a b c d` usando la
   estrategia Call-by-name.

8. Reducir `YO` y confirmar que se haya traducido al inglés.

----

<details>
  <summary>Soluciones</summary>
  <a href="https://drive.google.com/file/d/1UPJF22SgJuIGdnYhveXQCrup9R4cKLgM/view?usp=sharing)">Ver</a>
</details>
