---
title: "2. Herencia y polimorfismo"
layout: default
parent: Ejercicios
nav_order: 2
---

# Herencia y polimorfismo
{: .no_toc }

## Índice
{: .no_toc .text-delta }

1. Índice
{:toc}

{: .ejercicio }
## Figuras

Sea el siguiente código:

```java
public class Main {
    public static void main(String[] args) {
        List<Figura> figuras = new ArrayList<>();
        figuras.add(new Circulo(3));       // un circulo de radio 3
        figuras.add(new Cuadrado(5));      // un cuadrado de lado 5
        figuras.add(new Rectangulo(2, 4)); // un rectangulo de 2x4
        System.out.println("El area total es: %f", (areaTotal(figuras)));
    }

    private static double areaTotal(List<Figura> figuras) {
        double total = 0;
        for (Figura f : figuras) {
            total += f.area();
        }
        return total;
    }
}
```

{: .partes}
1. Pensar cuáles son las relaciones entre `Figura`, `Circulo`, `Cuadrado` y
   `Rectangulo`. ¿Figura debe ser una clase, una clase abstracta o una
   interfaz?
2. ¿Dónde hay comportamiento polimórfico? ¿De qué tipo es?
3. Dibujar el diagrama de clases.
4. Implementar.

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/HerenciaYPolimorfosmo/AreaTotal/Solucion)

{: .ejercicio }
## Lista duplicante

Se desea implementar una clase `ListaDuplicante<T>`, que tenga los métodos:

* `add(T x)`, que agrega el elemento `x` al final de la lista **dos veces**.
* `get(int i)`, que obtiene el elemento que está en la posición `i`.

Basándose en la clase `java.util.ArrayList<T>`, implementar `ListaDuplicante<T>`:

{: .partes}
1. Usando composición
1. Usando herencia

¿Qué ventajas y desventajas tiene cada una de las implementaciones?

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/HerenciaYPolimorfosmo/ListaDuplicante/Solucion)

{: .ejercicio }
## FIUBA 2

Diseñar el modelo de objetos e implementar un sistema que funcione como un
registro de todos los alumnos y docentes de la FIUBA.

Cualquier integrante de FIUBA tiene un nombre y DNI. No puede haber dos
personas con el mismo DNI. Un integrante puede ser alumno o docente.

Los alumnos tienen número de padrón o legajo. No puede haber dos alumnos con el
mismo número de padrón.

Los docentes también tienen un número de legajo (independiente del de los
alumnos). No puede haber dos docentes con el mismo número de legajo.

El sistema debe permitir: cargar un nuevo integrante, listar todos los alumnos
(con todos sus datos), listar todos los docentes (con todos sus datos).

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/HerenciaYPolimorfosmo/FIUBA2/Solucion)

{: .ejercicio }
## Cartelera 2

Se proponen algunas mejoras al sistema de cartelera del hostel (de la guía de
Objetos Simples):

* Los mensajes pueden ser de distintos tipos:
  * Texto simple
  * Enlace simple (por ejemplo `https://en.wikipedia.org`)
  * Enlace a una imagen (por ejemplo
    `https://upload.wikimedia.org/wikipedia/en/a/a9/Example.jpg`)
  * Enlace a un video (por ejemplo `https://www.youtube.com/watch?v=dQw4w9WgXcQ`)
* Tanto los huéspedes como el personal del hostel se autentican mediante el
  mismo mecanismo de nombre de usuario/contraseña, y pueden enviar y recibir
  mensajes.
* El personal del hostel puede, además:
  * crear nuevas cuentas de usuario
  * cerrar el sistema

<!-- no hay solucion aun
[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/HerenciaYPolimorfismo/Cartelera2/Solucion)
-->

{: .ejercicio }
## Ajedrez

{: .label }
Difícil

Diseñar el modelo de objetos e implementar un sistema que permita representar
un tablero de ajedrez y efectuar movimientos básicos.

El tablero es de 8x8 casilleros (que pueden ser numerados a1 ... h8). En cada
casillero puede haber (o no) una ficha, que puede ser blanca o negra, y una de:

{: .partes}
1. peón (P)
1. torre (R)
1. caballo (N)
1. alfil (B)
1. dama (Q)
1. rey (K)

El sistema debe permitir mostrar el tablero en formato de texto, usando los
símbolos indicados para cada pieza (letras mayúsculas para las blancas y
minúsculas para las negras), y el símbolo `.` para los casilleros vacíos
oscuros y ` ` (espacio en blanco) para los casilleros vacíos claros.

Dada una pieza en el tablero y un casillero de destino, el sistema además debe
permitir averiguar si el movimiento es válido o no, y en caso de ser válido,
efectuarlo.

{: .nota }
Solo es necesario implementar las [reglas de
movimiento](https://en.wikipedia.org/wiki/Chess#Movement) básicas de las
piezas. Implementar las reglas del ajedrez en su totalidad es bastante complejo
y no es la idea de este ejercicio.


