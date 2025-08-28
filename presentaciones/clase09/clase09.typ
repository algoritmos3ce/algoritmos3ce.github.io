#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.0"

#import "../defs.typ": *

#show: default-style

#caratula[
  = Programación concurrente en Java
]

#slide[
  = Concurrencia y Paralelismo

  #emphbox[
    *Concurrencia* es la habilidad de lidiar con múltiples tareas que pueden
    estar en progreso al mismo tiempo (pero no necesariamente en ejecución).
  ]

  #emphbox[
    *Paralelismo* es la habilidad de ejecutar múltiples tareas en forma
    simultánea. Requiere soporte de hardware (múltiples CPUs o cores).
  ]

  #align(center)[ #image("conc-par.png", height: 1fr) ]
]

#slide[
  #grid(columns: (1fr, auto), gutter: 1em)[
    = I/O bound vs CPU bound

    Los programas generalmente se pueden categorizar en dos tipos:

    #v(1fr)

    #emphbox[
      Un programa es *I/O bound* cuando hace uso intensivo de operaciones
      de entrada/salida.
    ]

    Ejemplos: servidores, bases de datos, interfaces de usuario.

    Se benefician más de la *concurrencia*.

    #v(1fr)

    #emphbox[
      Un programa es *CPU bound* cuando hace uso intensivo del CPU.
    ]

    Ejemplos: simuladores, videojuegos, procesamiento de imágenes, criptografía, IA.

    Se benefician más del *paralelismo*.

    #v(1fr)
  ][
    #v(1fr)
    #shadowed[ #image("iobound.png", width: 6cm) ]
    #v(1fr)
    #shadowed[ #image("cpubound.png", width: 6cm) ]
    #v(1fr)
  ]

  #fuente("https://en.wikipedia.org/wiki/Concurrent_computing")
]

#slide[
  = Procesos

  Son unidades de ejecución independientes y aisladas, con su propio espacio
  de memoria.

  Son manejados por el sistema operativo. El *scheduler* asigna tiempo de CPU
  a cada proceso (y en el caso de sistemas multicore, puede ejecutar
  múltiples procesos en paralelo).

  #align(center)[ #image("scheduler.jpg", width: 80%) ]

  Requieren mecanismos de IPC (_comunicación inter-proceso_) como *pipes*
  o *sockets* para comunicarse entre sí.
]

#slide[
  = Ejemplo: sockets

  #grid(columns: (1fr, 1fr), gutter: 1em)[
    #set text(size: 12pt)
    Servidor:
    ```java
    try (ServerSocket serverSocket = new ServerSocket(1234)) {
        Socket clientSocket = serverSocket.accept();
        BufferedReader in = new BufferedReader(
            new InputStreamReader(clientSocket.getInputStream())
        );

        String line = in.readLine();
        // ...
    }
    ```
  ][
    #set text(size: 12pt)
    Cliente:
    ```java
    try (Socket clientSocket = new Socket(host, port)) {
        PrintWriter out = new PrintWriter(
            clientSocket.getOutputStream(),
            true
        );
        out.println("hola");
    }
    ```
  ]
]

#slide[
  = Hilos

  Son unidades de ejecución dentro de un proceso.

  Comparten el mismo espacio de memoria.

  Pueden ser manejados por el sistema operativo o por la propia
  aplicación (dependiendo del lenguaje y la biblioteca de threads
  utilizada).

  #align(center)[ #image("threads.png", height: 1fr) ]
]

#slide[
  = Hilos en Java

  La clase `Thread` representa un hilo de ejecución en Java.
  #linklet("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/lang/Thread.html")

  ```java
  public class Main {
      public static void main(String[] args) {
          Thread t = new Thread(() -> {
              System.out.println("Hola desde el hilo!");
          });
          t.start(); // Inicia el hilo

          System.out.println("Hola desde el hilo principal!");
      }
  }
  ```

  El proceso finaliza cuando no queda ningún hilo de tipo _non-daemon_ en
  ejecución. #linklet("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/lang/Runtime.html#shutdown")

  #fuente("https://docs.oracle.com/javase/tutorial/essential/concurrency/threads.html")
]

#slide[
  = Estados de los hilos de Java

  #align(center)[ #image("states.png", height: 1fr) ]
]

#slide[
  = Sincronización usando _interrupt_ y _join_

  #grid(columns: (1fr, auto))[
    #{
      set text(size: 11pt)
      let src = read("ejemplos/EjemploThreads1/src/main/java/tb025/Main.java").split("\n").slice(2, 27).join("\n")
      raw(src, lang: "java", block: true)
    }
  ][
    #{
      set text(size: 11pt)
      let src = read("ejemplos/EjemploThreads1/src/main/java/tb025/Main.java").split("\n").slice(28).join("\n")
      raw(src, lang: "java", block: true)
    }
  ]

  #fuente("https://github.com/algoritmos3ce/algoritmos3ce.github.io/tree/main/presentaciones/clase09/ejemplos/EjemploThreads1")
]

#ejercicio[
  #set text(size: 14pt)

  ```java
  public class Main {
      static int a = 0;

      static void incThread() {
          for (int i = 0; i < 100000; i++) {
              a++;
          }
      }

      static void decThread() {
          for (int i = 0; i < 100000; i++) {
              a--;
          }
      }

      public static void main(String[] args) throws InterruptedException {
          Thread t1 = new Thread(Main::incThread);
          Thread t2 = new Thread(Main::decThread);
          t1.start();
          t2.start();
          t1.join();
          t2.join();
          System.out.println(a); // ¿Qué valor imprime?
      }
  }
  ```
]

#slide[
  = Condiciones de carrera

  #emphbox[ Una *condición de carrera* ocurre cuando el orden de las
  operaciones realizadas por dos o más hilos afecta el resultado final,
  a menudo provocando bugs. ]

  #align(center)[
    #stack(dir: ltr, spacing: 1cm)[
      ```java
      x = 5;

      // en thread 1:
      x++;

      // en thread 2:
      x++;
      ```
    ][
      #image("race1.png", width: 8cm)
    ][
      #image("race2.png", width: 8cm)
    ]
  ]

  Las condiciones de carrera son solo una de las posibles causas de
  bugs en programas concurrentes.

  La JVM define un *modelo de memoria* que especifica cómo y cuándo los
  cambios hechos por un hilo son visibles para otros hilos.
  #linklet("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/concurrent/package-summary.html#MemoryVisibility")

  #fuente("https://en.wikipedia.org/wiki/Race_condition#In_software")
]

#slide[
  = Sincronización: Candados

  #emphbox[ Un *candado* (*lock* / *mutex*) es un mecanismo de sincronización que
  permite a los hilos coordinar el acceso a recursos compartidos,
  previniendo condiciones de carrera. ]

  #grid(columns: (auto, 1fr), gutter: 1em)[
    #set text(size: 12pt)
    ```java
    public class Main {
        static int a = 0;
        static Object candado;

        static void incThread() {
            for (int i = 0; i < 100000; i++) {
                synchronized(candado) {
                    a++;
                }
            }
        }

        static void decThread() {
            for (int i = 0; i < 100000; i++) {
                synchronized(candado) {
                    a--;
                }
            }
        }
    }
    ```
  ][
    Todos los mecanismos de sincronización en Java se construyen en base a
    un *candado intrínseco* (o *monitor*) asociado a cada objeto.

    El entrar al bloque `synchronized(candado) { ... }` el hilo intenta
    *adquirir* el candado intrínseco del objeto `candado`.

    - Si el candado está libre, el hilo lo adquiere y entra al bloque.
    - Si el candado está ocupado por otro hilo, el hilo actual se *bloquea*
      hasta que el candado se libere.

    Al finalizar el bloque, el hilo *libera* el candado.
  ]

  #fuente("https://docs.oracle.com/javase/tutorial/essential/concurrency/locksync.html")
]

#slide[
  = Métodos sincronizados

  #grid(columns: (1fr, auto, 1fr, auto, 1fr))[][
    ```java
    public class ContadorSincronizado {
        private int c = 0;

        public void incrementar() {
            synchronized(this) {
                c++;
            }
        }

        public int valor() {
            synchronized(this) {
                return c;
            }
        }
    }
    ```
  ][][
    Azúcar sintáctica:

    ```java
    public class ContadorSincronizado {
        private int c = 0;

        public synchronized void incrementar() {
            c++;
        }

        public synchronized int valor() {
            return c;
        }
    }
    ```
  ][]
]

#slide[
  = Candados explícitos

  También es posible utilizar candados explícitos provistos por la
  biblioteca estándar.

  La interfaz `Lock` provee los métodos `lock()` y `unlock()`, ofreciendo
  un control más fino sobre la adquisición y liberación del candado.

  #set text(size: 13pt)
  ```java
  public class ContadorSincronizado {
      private int c = 0;
      private final ReentrantLock lock = new ReentrantLock();

      public void incrementar() {
          lock.lock();
          c++;
          lock.unlock();
      }

      public int valor() {
          int v;
          lock.lock();
          v = c;
          lock.unlock();
          return v;
      }
  }
  ```

  #fuente("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/concurrent/locks/Lock.html")
]

#slide[
  = Interbloqueos o Deadlocks

  #set text(size: 14pt)
  #emphbox[ Un *deadlock* ocurre cuando dos o más hilos
  están bloqueados permanentemente, esperando por un recurso que nunca será
  liberado. ]

  #grid(columns: (auto, 1fr), gutter: 1em)[
    #set text(size: 11pt)
    ```java
    final Object lock1 = new Object();
    final Object lock2 = new Object();

    Thread hiloA = new Thread(() -> {
        synchronized (lock1) {
            System.out.println("Hilo A: Adquirió lock 1");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            System.out.println("Hilo A: Esperando por lock 2");
            synchronized (lock2) { System.out.println("Hilo A: Adquirió lock 2"); }
        }
    });

    Thread hiloB = new Thread(() -> {
        synchronized (lock2) {
            System.out.println("Hilo B: Adquirió lock 2");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            System.out.println("Hilo B: Esperando por lock 1");
            synchronized (lock1) { System.out.println("Hilo B: Adquirió lock 1"); }
        }
    });

    hiloA.start(); hiloB.start();
    ```
  ][
    #image("deadlock.jpg", width: 10cm)

    Esta situación es el caso más simple de un interbloqueo, donde
    múltiples hilos esperan indefinidamente debido a una dependencia cíclica.
  ]
]

#slide[
  = Interbloqueos o Deadlocks (cont.)

  #set text(size: 14pt)
  Una posible solución: asegurar un orden global para adquirir
  múltiples candados.

  #set text(size: 11pt)
  ```java
  final Object lock1 = new Object();
  final Object lock2 = new Object();

  Thread hiloA = new Thread(() -> {
      synchronized (lock1) {
          System.out.println("Hilo A: Adquirió lock 1");
          try { Thread.sleep(100); } catch (InterruptedException e) {}
          System.out.println("Hilo A: Esperando por lock 2");
          synchronized (lock2) { System.out.println("Hilo A: Adquirió lock 2"); }
      }
  });

  Thread hiloB = new Thread(() -> {
      synchronized (lock1) { // Cambiado lock2 por lock1
          System.out.println("Hilo B: Adquirió lock 1");
          try { Thread.sleep(100); } catch (InterruptedException e) {}
          System.out.println("Hilo B: Esperando por lock 2");
          synchronized (lock2) { System.out.println("Hilo B: Adquirió lock 2"); }
      }
  });

  hiloA.start(); hiloB.start();
  ```
]

#slide[
  = Variables de condición

  #grid(columns: (1fr, auto), gutter: 1em)[
    #emphbox[ Una *variable de condición* permite a un hilo suspender su
    ejecución hasta que se cumpla una condición específica. ]

    #set text(size: 11pt)

    El método `wait` de la clase `Object`:
    1. Libera el candado intrínseco del objeto (se asume que está adquirido).
    2. Bloquea el hilo hasta que sea _notificado_ o _interrumpido_ desde otro hilo.
    3. Cuando el hilo se despierta, vuelve a adquirir el candado intrínseco.

    El método `notify` despierta a uno de los hilos que están esperando en el
    objeto (si hay alguno).

    El método `notifyAll` despierta a todos los hilos que están esperando en el
    objeto (si hay alguno).
  ][
    #set text(size: 12pt)
    ```java
    public class CasillaDeCorreo {
        private Object paquete;
        private boolean vacio;

        public synchronized void depositar(Object p) throws InterruptedException {
            while (!vacio) {
                wait(); // Bloquea el hilo hasta que la casilla esté vacía
            }
            paquete = p;
            vacio = false;
            notify(); // Despierta a uno de los hilos que esperan
        }

        public synchronized Object retirar() throws InterruptedException {
            while (vacio) {
                wait(); // Bloquea el hilo hasta que haya un paquete
            }
            Object p = paquete;
            paquete = null;
            vacio = true;
            notify(); // Despierta a uno de los hilos que esperan
            return p;
        }
    }
    ```
  ]

  #fuente("https://docs.oracle.com/javase/tutorial/essential/concurrency/guardmeth.html")
]

#slide[
  = Colecciones concurrentes

  La biblioteca estándar de Java provee varias colecciones diseñadas
  para ser usadas en entornos concurrentes, evitando la necesidad de
  sincronización manual.

  Algunos ejemplos:

  - `CopyOnWriteArrayList`: Una lista que crea una copia del arreglo
    subyacente en cada operación de escritura. Ideal para escenarios con
    muchas lecturas y pocas escrituras.
    #linklet("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/concurrent/CopyOnWriteArrayList.html")

  - `ConcurrentHashMap`: Un mapa hash que permite acceso concurrente
    eficiente. Divide el mapa en segmentos para minimizar la contención
    entre hilos.
    #linklet("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/concurrent/ConcurrentHashMap.html")

  - `BlockingQueue`: Una cola que soporta operaciones que esperan
    hasta que la cola no esté vacía al retirar elementos, o hasta que
    haya espacio disponible al insertar elementos.
    #linklet("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/concurrent/BlockingQueue.html")

  #align(center)[#image("blockingqueue.png", height: 1fr)]

  #fuente("https://docs.oracle.com/javase/tutorial/essential/concurrency/collections.html")
]

#slide[
  = Variables atómicas

  // An atomic transaction is an indivisible and irreducible series of database operations such that either all occur, or none occur.

  #emphbox[Una *transacción atómica* es una serie *indivisible* e *irreducible*
  de operaciones, de modo que *o todas ocurren, o ninguna ocurre*.]

  La JVM garantiza que algunas operaciones son atómicas (por ejemplo, la
  lectura y escritura de referencias y algunos tipos primitivos).
  #linklet("https://docs.oracle.com/javase/tutorial/essential/concurrency/atomic.html")

  Sin embargo, operaciones más complejas (como `x++`) no son atómicas,
  ya que involucran múltiples pasos.

  La biblioteca estándar de Java provee clases en el paquete
  `java.util.concurrent.atomic` que permiten operaciones atómicas
  sobre variables, evitando la necesidad de sincronización explícita.

  ```java
  AtomicInteger c = new AtomicInteger(0);
  c.incrementAndGet(); // Operación atómica
  ```

  #fuente("https://docs.oracle.com/javase/tutorial/essential/concurrency/atomicvars.html")
]

#slide[
  = Computaciones asíncronas

  #emphbox[Una función *sincrónica* bloquea el hilo que la invoca hasta que
  la operación finaliza, mientras que una función *asíncrona* retorna
  inmediatamente, permitiendo que el hilo invocante continúe su ejecución.]

  La clase `Future` representa el resultado de una computación
  asíncrona. #linklet("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/concurrent/Future.html")

  #set text(size: 12pt)
  #grid(columns: 2, gutter: 1em)[
    ```java
    long sumar(long[] array) {
        long r = 0;
        for (long v : array) {
            r += v;
        }
        return r;
    }

    Future<Long> sumarAsincronico(long[] array) {
        Future<Long> r = new Future<>();
        Thread t = new Thread(() -> {
            long suma = sumar(array);
            r.complete(suma);
        });
        t.start();
        return r;
    }
    ```
  ][
    ```java
    Future<Long> f = sumarAsincronico(array);
    // Hacer otras cosas...
    long resultado = f.get(); // Bloquea hasta que el resultado esté listo
    ```
  ]
]

#slide[
  = Ejecutores

  La interfaz `ExecutorService` define un mecanismo genérico para gestionar
  un grupo de hilos para ejecutar computaciones asíncronas.
  #linklet("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/concurrent/ExecutorService.html")

  #set text(size: 12pt)
  #grid(columns: 2, gutter: 1em)[
    ```java
    long sumar(long[] array) {
        long r = 0;
        for (long v : array) {
            r += v;
        }
        return r;
    }

    // En cualquier momento, como máximo 4 hilos estarán activos procesando
    // tareas. Si se envían tareas adicionales cuando todos los hilos están
    // activos, esperarán en la cola hasta que un hilo esté disponible.
    ExecutorService executor = Executors.newFixedThreadPool(4);

    Future<Long> sumarAsincronico(long[] array) {
        return executor.submit(() -> sumar(array));
    }
    ```
  ][
    ```java
    Future<Long> f = sumarAsincronico(array);
    // Hacer otras cosas...
    long resultado = f.get();
    ```
  ]

  #fuente("https://docs.oracle.com/javase/tutorial/essential/concurrency/executors.html")
]

#slide[
  = Patrón Fork/Join

  Es una estrategia inspirada en _divide & conquer_ para paralelizar tareas.

  #grid(columns: 2, gutter: 1em)[
    La clase `ForkJoinPool` es una implementación de la interfaz `ExecutorService`
    que automáticamente aplica esta estrategia. #linklet("https://docs.oracle.com/en/java/javase/24/docs/api/java.base/java/util/concurrent/ForkJoinPool.html")

    Ejemplo: #linklet("https://github.com/algoritmos3ce/algoritmos3ce.github.io/tree/main/presentaciones/clase09/ejemplos/ForkJoinSort")

    ```java
    class SortTask extends RecursiveAction {...}

    var executor = new ForkJoinPool();
    executor.execute(new SortTask(array));
    ```
  ][
    #image("forkjoin.png", height: 1fr)
  ]

  #fuente("https://docs.oracle.com/javase/tutorial/essential/concurrency/forkjoin.html")
]

#fin()
