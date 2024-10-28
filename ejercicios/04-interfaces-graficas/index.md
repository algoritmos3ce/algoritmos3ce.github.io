---
title: "4. Programación Orientada a Eventos: Interfaces gráficas"
layout: default
parent: Ejercicios
nav_order: 4
---

# Programación Orientada a Eventos: Interfaces gráficas
{: .no_toc }

## Índice
{: .no_toc .text-delta }

1. Índice
{:toc}

{: .ejercicio }
## Hola, `<nombre>`

Implementar una aplicación en JavaFX que muestre un cuadro de texto, para que el
usuario ingrese su nombre, y un botón.
Al clickear el botón se debe saludar al usuario mediante un `Alert`.

{: .ejercicio }
## ChoiceBox

Implementar una aplicación en JavaFX que muestre un `ChoiceBox` con diferentes
colores, y un `Label` que cambie su color en base a la opción elegida.

{: .ejercicio }
## Calculadora

Implementar una calculadora básica, que permita sumar, restar, multiplicar y
dividir dos números ingresados por el usuario.

{: .ejercicio }
## Coordenadas

Escribir una aplicación que muestre en un `Label` las coordenadas del puntero
del mouse en la ventana.

{: .ejercicio }
## Teclado

Escribir una aplicación que, cuando el usuario presione cualquier tecla del
teclado, muestre un alerta informando cuál fue la tecla presionada.

{: .ejercicio }
## Lista de tareas

Implementar una aplicación que permita manipular una lista de tareas (*TODO
list*). El usuario debe poder:

* Agregar tareas (ingresando un título en un cuadro de texto),
* Ver un listado de tareas
* Marcar tareas como hechas (mediante un `CheckBox`)
* Eliminar tareas

{: .ejercicio }
## Lista de tareas 2.0

Agregar a la lista de tareas la capacidad de *persistir* el estado:

* Cada vez que el usuario hace alguna acción, guardar la lista y el estado de
  las tareas en un archivo.

* Al iniciar la aplicación, si el archivo existe, cargar la lista de tareas del
  mismo.

{: .ejercicio }
## Chat

Implementar una aplicación que simule un canal de chat con múltiples usuarios,
mediante el sistema de eventos de JavaFX.

* Crear una clase `NuevoMensaje` que hereda de `Event`, para representar el
  evento de un nuevo mensaje enviado al canal.
* En la ventana principal simular el *servidor* que permite conectar nuevos
  usuarios al chat.
* Cuando se conecta un nuevo usuario, mostrar una ventana nueva (cada
  ventana es un `Stage`), con la vista del chat correspondiente a ese usuario.
  Las ventanas de chat no se conocen entre sí.
  Cada una de las ventanas se comunicará exclusivamente con el servidor,
  invocando métodos y escuchando eventos. La ventana de chat se suscribe para
  escuchar eventos de tipo `NuevoMensaje` del servidor.
* Cuando un usuario envía un mensaje desde una ventana de chat:
  1. La ventana de chat envía el mensaje al servidor.
  1. El servidor lanza un evento `NuevoMensaje` (mediante el método `fireEvent`).
  1. Todas las ventanas reciben el evento y actualizan la vista para mostrar el
     mensaje nuevo.

{: .ejercicio }
## Dibujo

Implementar una aplicación que permita al usuario crear dibujos simples. La
aplicación debe permitir, usando exclusivamente el mouse:

* Crear figuras simples: círculos, rectángulos, etc.
* Seleccionar, mover y eliminar las figuras

{: .ejercicio }
## Animación

Utilizando un `Canvas`, dibujar un círculo que se mueve por la ventana y rebota
en los bordes.

{: .ejercicio }
## Pong

Implementar el juego [Pong](https://en.wikipedia.org/wiki/Pong).

[Solución](https://github.com/algoritmos3ce/pong)

{: .ejercicio }
## Ejercitación adicional

Usando JavaFX, implementar una interfaz gráfica simple para los modelos
implementados en las guías de [Objetos Simples](/ejercicios/01-objetos-simples) y
[Herencia y Polimorfismo](/ejercicios/02-herencia-polimorfismo).

