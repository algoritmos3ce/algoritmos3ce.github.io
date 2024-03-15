---
title: "1. Objetos simples"
layout: default
parent: Ejercicios
nav_order: 1
---

# Objetos simples
{: .no_toc }

## Índice
{: .no_toc .text-delta }

1. Índice
{:toc}

## FIUBA

Diseñar e implementar un sistema que permita contabilizar las materias
aprobadas de un plan de estudios de FIUBA.

Cada materia de FIUBA tiene un código, un nombre y una cantidad de créditos, y
puede ser obligatoria u optativa.

Una carrera está compuesta por un listado de materias (que pueden ser
obligatorias u optativas), y una cantidad mínima de créditos. Para terminar la
carrera hay que aprobar todas las materias obligatorias y además cumplir la
cantidad de créditos.

El sistema ofrece sus servicios a múltiples usuarios. Cada usuario puede cursar
cero, una o más carreras. El sistema debe permitir al usuario inscribirse a una
carrera, marcar materias como aprobadas y consultar el estado de cada una de
sus carreras.

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/ObjetosSimples/FIUBA/Solucion)

## Chat

Diseñar e implementar un modelo de objetos para una aplicación de chat similar
a Whatsapp/Telegram. En la aplicación hay usuarios que se envían mensajes
privados. Cada usuario puede ver el historial de los mensajes que componen la
conversación con cualquier otro usuario.

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/ObjetosSimples/Chat/Solucion)

## Cartelera

Se desea informatizar la cartelera ubicada en el hall de entrada de un hostel
(actualmente, muchos mensajes se despegan y se pierden).

Diseñar un sistema de mensajería para instalar en una PC.

Los usuarios deberán poder autenticarse (solo los huéspedes y el personal del
hostel tienen acceso).

Un usuario autenticado podrá ver los listados de mensajes que ha enviado y que
ha recibido (ambos ordenados cronológicamente de más recientes a más antiguos)
y dejarle un mensaje a cualquier otro usuario registrado en el sistema.

Los usuarios autenticados deberán cerrar su sesión al salir. Si no lo hacen,
otros huéspedes podrán verle los mensajes y deberán cerrar la sesión para poder
autenticase y ver los mensajes propios.

Solo el personal del hostel puede salir del sistema (cerrar el programa).

Realizar los diagramas UML (casos de uso, de secuencia y de clases).

Implementar el sistema en Java.

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/ObjetosSimples/Cartelera/Solucion)

## Biblioteca

Diseñar e implementar un sistema de gestión para una biblioteca.

La biblioteca cuenta con una colección de libros. Cada libro tiene un código
único (ISBN), un título, una fecha de publicación y uno o más autores. La
biblioteca puede tener más de una copia de un libro.

La biblioteca tiene además clientes que piden libros prestados.

El sistema debe permitir agregar y quitar libros a la biblioteca, consultar el
stock de libros por título, fecha o autor, prestar libros a clientes, devolver
libros prestados y consultar los libros prestados a cada cliente.

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/ObjetosSimples/Biblioteca/Solucion)

## Caja de ahorro

Diseñar e implementar una caja de ahorro, donde el usuario pueda ingresar su
dinero y conocer la cantidad a retirar en x meses segun el intereses actual,
luego de calcular el saldo a recibir, el usuario puede elgir si depositar el
dinero o no. Una vez depositado, el deposito más los intereses ganados se suman
a los ahorros del usuario. Adicionalmente diseñar un sistema bancario donde
diferentes cuentas puedan ser creadas, interactuar y transferirse dinero.

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/ObjetosSimples/Cuenta/Solucion)

## Fecha

Crear una clase `Fecha` con las siguientes capacidades:

1. Imprimir la fecha en varios formatos, como:

   * `MM/DD/AAAA`
   * `Junio 14, 1992`
   * `DDD AAAA`

2. Usar diferentes constructores para crear objetos `Fecha` inicializados con
fechas de los formatos en la parte 1.
   * En el primer caso, el constructor debe recibir tres valores enteros.
   * En el segundo, debe recibir un objeto `String` y dos valores enteros.
   * En el tercero debe recibir dos valores enteros, el primero de los cuales
     representa el número de día en el año.

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/ObjetosSimples/Fecha/Solucion)
