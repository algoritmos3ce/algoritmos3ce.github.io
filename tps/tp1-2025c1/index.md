---
title: "TP1"
layout: default
parent: "Trabajos prácticos"
nav_order: 1
---

# TP1: Robots

El objetivo de este trabajo práctico es implementar el videojuego **Robots**,
que es una variente de un juego clásico conocido como
[Chase](https://en.wikipedia.org/wiki/Chase_(video_game)).

Se aplicarán conceptos de:

- Programación orientada a objetos
- Interfaces gráficas

El TP se desarrolla en forma **grupal**, en grupos de 2 integrantes.

## Reglas de juego

<video controls src="./robots.webm" type="video/webm"></video>

* Robots es un juego por turnos en el que el jugador debe escapar de unos robots
  que lo persiguen.
* El juego termina cuando el jugador es alcanzado por un robot.
* El juego se desarrolla en una sucesión infinita de niveles de dificultad incremental.
* Cada nivel se desarrolla en una grilla bidimensional de N filas y M columnas
  (valores configurables).
* El jugador comienza en el centro de la grilla.
* En cada nivel hay una cantidad de robots que comienzan en posiciones
  aleatorias.
* El jugador dispone de una cantidad limitada de usos de teletransportación
  segura. Al comenzar cada nivel se le otorga un uso adicional.
* En cada turno, el jugador puede:
  * Moverse a una celda vecina, en cualquiera de las 8 direcciones posibles
    (movimiento horizontal, vertical y diagonal).
  * Teletransportarse a una celda aleatoria (que puede o no estar ocupada por un
    robot).
  * Si tiene usos disponibles de teletransportación segura, teletransportarse a
    una celda a elección.
* Luego de cada movimiento del jugador, cada uno de los robots efectúan su
  movimiento.
* Hay dos tipos de robots:
  * 1x: siempre se mueve hacia el jugador, una celda por turno.
  * 2x: siempre se mueve hacia el jugador, dos celdas por turno.
* Si alguno de los robots llega a la celda en la que está el jugador, el juego
  termina.
* Si al finalizar el turno, dos o más robots se encuentran en la misma celda,
  los robots son destruidos y esa celda queda incendiada hasta que termina el
  nivel.
* Si el jugador toca una celda incendiada, termina el juego.
* Si un robot toca una celda incendiada, el robot es destruido.
* En cada escenario habrá 4 recursos recolectables, por ejemplo “diamantes”, ubicados en 
  celdas aleatorias y distintas y a al menos 3 celdas de distancia entre sí.
* Los casilleros con recursos recolectables NO son transitables para los robots, pero pero 
  sí para el jugador. 
* Cuando un jugador pisa una celda con un recurso recolectable, el recurso se considera
  "recolectado" y desaparece del tablero. La celda pasa a ser transitable para robots.
* Si al finalizar el turno, todos los robots están destruidos o se han recolectado todos
  los recursos, el jugador pasa al siguiente nivel.

## Interfaz gráfica

* Se debe implementar una interfaz gráfica para el juego, con JavaFX.
    - Ver [JavaFX en IntelliJ IDEA](/entorno/tutorial-javafx/)
* Debe ser posible jugar con el mouse o con el teclado.
* Se puede usar cualquier set de imágenes para representar los elementos del
  juego. Se provee una imagen que pueden usar, en formato
  [PNG](./robots_con_diamante.png) y [xcf (Gimp)](./robots.xcf).
* También se puede usar el modelo con un recurso de diamante agregado al anterior
  (./robots_con_diamante.png) o editar el archivo fuente .xcf.
* Se debe permitir configurar el tamaño de la grilla (cantidad de filas y
  columnas).
* En algún lugar se debe indicar la cantidad de recursos pendientes de recolección
  del nivel actual.
* Luego de perder una partida, se debe permitir comenzar de nuevo.

## Requerimientos adicionales

* El proyecto debe utilizar Maven.
    - Ver [Uso de Maven](/entorno/maven/)

* Deben estar bien separadas las clases relacionadas con la **lógica** y la
  **interfaz gráfica**, en 2 capas de abstracción.

* Se debe utilizar **polimorfismo** para implementar los comportamientos de los
  distintos robots y las celdas incendiadas.

* Agregar un **diagrama de clases** y/o **secuencia** en formato `png` o `pdf`.
  El diagrama debe incluir las clases principales de la capa **lógica**.

    {: .nota }
    Por convención, el código fuente se ubica dentro de la carpeta `src/main/java`
    (automáticamente creada por IntelliJ), y la documentación en la carpeta `doc`
    (que debe ser creada a mano).

## Entrega

**Fecha de entrega:** 1 de mayo 2025

**Fecha límite para aprobar:** 22 de mayo 2025

* El código debe estar alojado en un repositorio **privado** de Github dentro de el Github Classroom de la catedra:
- Para eso deberan entrar a este link https://classroom.github.com/a/UoY0NL5F y crear un grupo junto con su compañero de TP.
- Agregar en el Readme el padron y nombre de los integrantes
