---
title: "4. Programación concurrente"
layout: default
parent: Ejercicios
nav_order: 4
---

# Programación concurrente
{: .no_toc }

## Índice
{: .no_toc .text-delta }

1. Índice
{:toc}

{: .ejercicio }
## Creación de hilos básicos

{: .partes}
1. Escribir un programa que cree un hilo extendiendo la clase `Thread` y otro
    hilo implementando la interfaz `Runnable`. Ambos hilos deben imprimir
    mensajes en la consola en un ciclo infinito. Observar el orden en que se
    imprimen los mensajes.

2. Modificar el programa anterior para que los hilos compartan el acceso a una variable
   de tipo `int`. Ambos hilos deben, en un ciclo infinito, imprimir el valor
   actual de la variable y luego incrementarla.

   Observar el comportamiento. Agregar bloques `synchronized` donde corresponda
   para asegurar que el comportamiento es correcto.

{: .ejercicio }
## Pares e impares

Escribir un programa que utiliza 2 threads, uno imprimiendo números pares y el
otro números impares, alternándose desde 1 hasta un número dado. Implementar
sincronización utilizando Locks y Conditions para asegurar que los números se
imprimen en el orden correcto.

[Solución](https://github.com/algoritmos3ce/Ejercicios/tree/main/src/main/java/Concurrencia/ParesImpares/Numerador.java)

{: .ejercicio }
## Cuenta bancaria

Sean las clases `CuentaBancaria` y `Transaccion`. ¿Es la implementación
_thread-safe_? Si deseamos ejecutar muchas transacciones en paralelo, ¿qué
modificaciones habría que hacer? Implementar una simulación con N cuentas y
M transacciones ejecutándose en T threads.

```java
public class CuentaBancaria {
    private int saldo;

    public int verSaldo() { return saldol }
    public void depositar(int cantidad) { saldo += cantidad; }
    public void extraer(int cantidad) { saldo -= cantidad; }
}

public class Transaccion {
    private final CuentaBancaria origen;
    private final CuentaBancaria destino;
    private final int cantidad;

    public void ejecutar() {
        origen.extraer(cantidad);
        destino.depositar(cantidad);
    }
}
```

{: .ejercicio }
## Lectores y escritores

Modificar la implementación del ejercicio anterior para asegurar que varios
lectores pueden acceder en paralelo a `verSaldo`, pero solo un escritor
puede acceder a `depositar` o `extraer`, y ningún lector puede acceder mientras
un escritor está escribiendo.

{: .ejercicio }
## Sistema de reservas de asientos en un cine

Diseñar un sistema donde múltiples usuarios pueden reservar asientos en
un cine, en forma concurrente. Sincronizar correctamente para garantizar
que dos usuarios no reserven el mismo asiento al mismo tiempo.

{: .ejercicio }
## Cola sincronizada

Implementar una clase `ColaSincronizada`, que recibe como parámetro un número
entero N indicando su capacidad máxima. Si la cola está llena, el método
`encolar` debe bloquear hasta que haya lugar y el elemento haya sido encolado
satisfactoriamente. Si la cola está vacía, `desencolar` debe bloquear hasta que
haya un elemento para desencolar.

{: .ejercicio }
## Suma en paralelo

Crea un programa en Java que calcule la suma de un gran
arreglo de números en paralelo utilizando varios hilos. Dividir el arreglo en
partes iguales y asignar cada parte a un hilo para que calcule su suma.
Luego, sumar los resultados parciales para obtener el resultado final.

{: .ejercicio }
## Productor-Consumidor

Implementar el ejercicio anterior utilizando un modelo de productor-consumidor,
utilizando dos colas sincronizadas Q1 y Q2:

1. En 1 thread: Separar el arreglo en partes iguales. Encolar en Q1 cada una de
   las secciones.
2. En K threads: Desencolar de Q1 una sección del arreglo y sumar los elementos.
   Encolar en Q2 el resultado.
3. En 1 thread: Desencolar todos los resultados parciales de Q2 y sumarlos.

{: .ejercicio }
## Problema de los filósofos cenando

Implementar una solución al problema de los [filósofos
cenando](https://en.wikipedia.org/wiki/Dining_philosophers_problem) utilizando
hilos en Java. En este problema, varios filósofos comparten una mesa redonda y
alternan entre pensar y comer. Sin embargo, solo pueden comer si pueden agarrar
dos tenedores adyacentes. Sincronizar correctamente para evitar deadlocks.
