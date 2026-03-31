#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.0"

#import "../defs.typ": *

#show: default-style

#caratula[
  = Programación orientada a eventos
]

#slide[
  = Programación orientada a eventos

  #grid(columns: (1fr, auto), gutter: 1cm)[
    #emphbox[
      Es un paradigma de programación en el que el *flujo del programa* es
      determinado por la ocurrencia de *eventos*, que son previstos pero no planeados
      (es decir, no se sabe cuándo ocurrirán).
    ]

    Un ejemplo común es el desarrollo de
    *interfaces gráficas de usuario (GUI)*. En este caso, se deben manejar eventos como
    clics de ratón, pulsaciones de teclado, etc. Pero no es el único contexto en el que
    encuentra aplicación este paradigma.
  ][
    // @startuml
    // hide footbox
    // queue Mouse
    // queue Teclado
    // queue Red
    // participant "Aplicación" as App
    // Mouse o-> App : Mueve a (25, 67)
    // Red o-> App : Recibe datos "Hola"
    // Mouse o-> App : Click botón izquierdo
    // Teclado o-> App : Presiona tecla A
    // Teclado o-> App : Suelta tecla A
    // @enduml
    #align(center)[#image("eventos.png", width: 10cm)]
  ]

  La nomenclatura varía según el framework, lenguaje, etc.:

  / Objeto que produce eventos: Event source, Event emitter, Event dispatcher, Publisher
  / Objeto que quiere ser notificado: Listener, Subscriber, Consumer

  #fuente("https://en.wikipedia.org/wiki/Event-driven_programming")
]

#slide[
  = Estrategia de _polling_

  #set text(size: 14pt)

  #grid(columns: (1fr, auto), gutter: 1em)[
    La estrategia más primitiva para procesar eventos es la de *polling*
    (encuestar).

    #[

      ```java
      long ultimo = System.currentTimeMillis();
      int segundos = 0;
      while (true) {
          // pasó 1 segundo desde la última vez?
          long ahora = System.currentTimeMillis();
          if (ahora - ultimo > 1000) {
              segundos += 1;
              System.out.printf("Pasaron %ds.\n", segundos);
              ultimo = ahora;
          }
      }
      ```
    ]
  ][
    // @startuml
    // hide footbox
    // skinparam sequenceMessageAlign reverseDirection
    // participant System
    // participant Aplicación
    // activate Aplicación
    // Aplicación -> System : currentTimeMillis()
    // activate System
    // System --> Aplicación : 987
    // deactivate System
    // Aplicación -> System : currentTimeMillis()
    // activate System
    // System --> Aplicación : 992
    // deactivate System
    // Aplicación -> System : currentTimeMillis()
    // activate System
    // System --> Aplicación : 1003
    // deactivate System
    // Aplicación -> Aplicación : segundos += 1
    // Aplicación -> System : currentTimeMillis()
    // activate System
    // System --> Aplicación : 1015
    // @enduml
    #image("polling.png", width: 7cm)
  ]

  Esta estrategia es *sincrónica*: las operaciones ocurren en
  un orden determinado.

  Esta estrategia se conoce también como *busy waiting* o *busy loop*:
  el encuestador usa recursos del sistema (CPU, energía) mientras espera
  a que ocurra el evento de interés.

  También se dice que es una estrategia de tipo *pull*: el encuestador debe
  "tirar" para enterarse de los eventos.

  #fuente("https://en.wikipedia.org/wiki/Polling_(computer_science)")
]

#slide[
  #toolbox.side-by-side(columns: (1fr, auto), gutter: 0.5cm)[
    = Callbacks

    #set text(size: 14pt)

    #emphbox(inset: 0em, outset: 0.5em)[
      Un *callback* es una función que se pasa como parámetro a otra función
      (típicamente *no bloqueante*). El callback será invocado en algún momento posterior
      (es decir, en forma *asincrónica*), por ejemplo cuando ocurre un evento.
    ]

    Esta estrategia es de tipo *push*: el emisor "empuja" los eventos a los
    consumidores.

    En lenguajes orientados a objetos como Java, el pasaje de callbacks se realiza
    mediante interfaces o clases abstractas.

    #toolbox.side-by-side(columns: (1fr, auto, 1fr, auto, 1fr))[][
      // @startuml
      // hide footbox
      // participant Main
      // participant Callback
      // participant Timer
      // activate Main
      // Main -> Timer : scheduleAtFixedRate()
      // activate Timer
      // Timer -> Callback : run()
      // activate Callback
      // deactivate Callback
      // Timer -> Callback : run()
      // activate Callback
      // deactivate Callback
      // @enduml
      #align(center)[ #image("timer1.png", width: 5cm) ]
    ][][
      // @startuml
      // hide circle
      // set separator none
      // class Main
      // class Callback
      // package "java.util" {
      // class Timer {
      //   scheduleAtFixedRate()
      // }
      // abstract class TimerTask {
      //   run()
      // }
      // }
      // Main *-r- Callback
      // Callback -d-|> TimerTask
      // Timer o-r- TimerTask
      // Main *-d- Timer
      // @enduml
      #align(center)[ #image("timer2.png", width: 6cm) ]
    ][]
  ][
    #set text(size: 12pt)
    ```java
    import java.util.Timer;
    import java.util.TimerTask;

    public class Main {
        public static void main(String[] args) {
            Timer timer = new Timer();
            Callback callback = new Callback();
            // callback.run() será invocado cada 1 segundo
            timer.scheduleAtFixedRate(callback, 0, 1000);
            // El mensaje anterior fue no bloqueante
            System.out.println("Timer configurado.");
        }
    }

    class Callback extends TimerTask {
        int segundos = 0;

        @Override public void run() {
            System.out.printf("Pasaron %ds.\n", segundos++);
        }
    }
    ```
  ]

  Los callbacks suelen ser llamados *handlers* cuando son utilizados para
  manejar eventos.

  #fuente("https://en.wikipedia.org/wiki/Callback_(computer_programming)")
]

#slide[
  = Azúcar sintáctica: clases anónimas

  #set text(size: 12pt)
  #grid(columns: (1fr, auto, 1fr, auto, 1fr), rows: 2)[][
    #image("pooh1.jpg", width: 4cm)
  ][][
    #image("pooh2.jpg", width: 4cm)
  ][][][
    ```java
    public class Main {
        public static void main(String[] args) {
            Timer timer = new Timer();
            TimerTask callback = new Callback();
            // callback.run() será invocado cada 1 segundo
            timer.scheduleAtFixedRate(callback, 0, 1000);
            // El mensaje anterior fue no bloqueante
            System.out.println("Timer configurado.");
        }
    }

    class Callback extends TimerTask {
        int segundos = 0;

        @Override public void run() {
            System.out.printf("Pasaron %ds.\n", segundos++);
        }
    }
    ```
  ][][
    ```java
    public class Main {
        public static void main(String[] args) {
            Timer timer = new Timer();
            TimerTask callback = new TimerTask() {
                int segundos = 0;

                @Override public void run() {
                    System.out.printf("Pasaron %ds.\n", segundos++);
                }
            };
            // callback.run() será invocado cada 1 segundo
            timer.scheduleAtFixedRate(callback, 0, 1000);
            // El mensaje anterior fue no bloqueante
            System.out.println("Timer configurado.");
        }
    }
    ```
  ][]

  #fuente("https://docs.oracle.com/javase/tutorial/java/javaOO/anonymousclasses.html")
]

#slide[
  = Ejemplo: HttpClient

  ```java
  Consumer<HttpResponse<String>> callback = new Consumer<>() {
      @Override
      public void accept(HttpResponse<String> response) {
          System.out.println(response.body());
      }
  };

  HttpRequest request = HttpRequest.newBuilder()
          .uri(URI.create("https://pokeapi.co/api/v2/pokemon/ditto"))
          .build();
  try (HttpClient client = HttpClient.newHttpClient()) {
      client.sendAsync(request, HttpResponse.BodyHandlers.ofString())
              .thenAccept(callback);
      System.out.println("Request sent");
  }
  ```
]

#slide[
  = Azúcar sintáctica: Expresión Lambda

  #set text(size: 11pt)
  #let h = 13cm
  #let rh = h / 5
  #grid(columns: (auto, auto), rows: (rh,rh,rh,rh,rh), column-gutter: 0.5cm, align: (left, left+horizon),
    grid.cell(rowspan: 5)[
      #image("brainmeme.jpg", height: h)
    ],[
      ```java
      Consumer<HttpResponse<String>> callback = new Consumer<>() {
          @Override public void accept(HttpResponse<String> response) {
              System.out.println(response.body());
          }
      };
      ```
    ],[
      ```java
      Consumer<HttpResponse<String>> callback = (HttpResponse<String> response) -> {
          System.out.println(response.body());
      };
      ```
    ],[
      ```java
      Consumer<HttpResponse<String>> callback = (response) -> {
          System.out.println(response.body());
      };
      ```
    ],[
      ```java
      Consumer<HttpResponse<String>> callback = response -> {
          System.out.println(response.body());
      };
      ```
    ],[
      ```java
      Consumer<HttpResponse<String>> callback = response -> System.out.println(response.body());
      ```
    ]
  )

  #fuente("https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html")
]

#slide[
  = Entrada/Salida bloqueante

  #set text(size: 14pt)

  Las APIs de I/O son tradicionalmente *sincrónicas* y *bloqueantes*.

  Por ejemplo, el siguiente pseudocódigo muestra la implementación más intuitiva de un
  _socket server_:

  #align(center)[
    ```python
    servidor = crearSocketServidor()
    while True:
        # bloquea hasta que un cliente se conecta
        cliente = servidor.accept()

        while True:
            # bloquea hasta que el cliente envía datos o se desconecta
            s = cliente.read()
            if not s:
                # cliente desconectado
                s.close()
                break
            else:
                # envía la respuesta al cliente
                cliente.write(s);
    ```
  ]

  La limitación principal de esta implementación es que las funciones `accept` y
  `read` son *bloqueantes*, y por lo tanto el servidor solo puede atender a
  un cliente por vez.

  #fuente("https://github.com/algoritmos3ce/algoritmos3ce.github.io/tree/main/presentaciones/clase04/ejemplos/nio")
]

#slide[
  = Entrada/Salida multiplexada

  #set text(size: 14pt)

  La estrategia de *entrada/salida multiplexada* permite bloquear
  hasta que ocurra algún evento de interés.

  #align(center)[
    #set text(size: 12pt)
    ```python
    server = crearServerSocket()
    sockets = [server]
    while True:
        # bloquea hasta que ocurra algún evento de interés
        subconjunto = select(sockets)
        for socket in subconjunto:
            if type(socket) is ServerSocket:
                # aceptamos la conexion de un cliente
                cliente = server.accept()
                sockets += cliente
            else:
                # recibimos datos de un cliente
                s = socket.read()
                if not s:
                    # cliente desconectado
                    socket.close()
                    sockets.remove(socket)
                else:
                    # envía la respuesta al cliente
                    socket.write(s);
    ```
  ]

  #fuente("https://github.com/algoritmos3ce/algoritmos3ce.github.io/tree/main/presentaciones/clase04/ejemplos/nio")
]

#slide[
  = Patrón Observer

  Es un patrón de diseño de POO que permite registrar múltiples *callbacks*
  para ser invocados cuando ocurra un evento. De esta manera se logra una
  comunicación *uno a muchos* (un emisor, múltiples observadores).

  #align(center)[ #image("observer.png", width: 15cm) ]

  Nota: en esta implementación, la publicación del evento es *sincrónica* con
  la ejecución de los handlers.

  #fuente("https://refactoring.guru/design-patterns/observer")
]

#slide[
  = Patrón Observer: Ejemplo

  #set text(size: 12pt)
  #grid(columns: (1fr, auto, 1fr, auto, 1fr))[][
    ```java
    public interface Observador {
        public void nivelGanado();
    }

    public class Juego {
        private List<Observador> observadores = new ArrayList<>();

        public void suscribir(Observador obs) {
            observadores.add(obs);
        }

        public void notificarNivelGanado() {
            for (Observador obs : observadores) {
                obs.nivelGanado();
            }
        }
    }
    ```
  ][][
    ```java
    public class Logros implements Observador {
        @Override public void nivelGanado() {
            System.out.println("¡Nuevo logro: Nivel ganado!");
        }
    }
    ```

    ```java
    public class UI implements Observador {
        @Override public void nivelGanado() {
            System.out.println("UI: Nivel ganado.");
        }
    }
    ```

    ```java
    Juego juego = new Juego();
    Logros logros = new Logros();
    UI ui = new UI();

    juego.suscribir(logros);
    juego.suscribir(ui);

    // Simular que se gana un nivel
    juego.notificarNivelGanado();
    ```
  ][]
]

#slide[
  = Event loop

  Es una estrategia que permite desacoplar aun más los emisores de los
  consumidores. La publicación de los eventos es *asincrónica* con la invocación
  de los handlers.

  // draw.io: https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=evetloop&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22Page-1%22%20id%3D%22p774UbMqfreBMpaSZLkb%22%3E7ZlLc5swEMc%2FDZOTMwYZbB%2FjR5JLZjqTzHTam4xkUAOICOFHP31XRphnatr4lU4vsVikBX7%2FRbtLDDQNNw8Cx%2F4TJzQwrD7ZGGhmWJbZRwh%2BlGWrLWa%2Fn1k8wYi2FYZn9pPmS7U1ZYQmlYmS80CyuGp0eRRRV1ZsWAi%2Brk5b8qB61Rh7%2Bor9wvDs4oA2pn1lRPqZdWSXZj9S5vmy%2FnwhzidrQ%2BJjwtclE5obaCo4l9ko3ExpoOjlXLJ19%2B%2Bc3d%2BYoJHssuDb2%2FeXu2g%2Be7tfjb1k%2B2MVP5CelXlZ4SDVD6xvVm5zAoKnEaHKSd9Ak7XPJH2OsavOrkF0sPkyDODIhKF2R4Wkm3fv09w%2FPcQN5SGVYgtT9AKUE9Qh4%2BjDdYEf5Uz9EvqhtmGtuLf3XECBgebyB4xQg9GUB1gFNYU%2FdAXPxZMGNgAgq2xwwLwIxi4soAIMChODULvTJ0JGiFo%2BETRhP%2FFi50pBjzmL5O6x7Ilhz5SvFK6ZvSzKdSIFf6VwWxz8ziIeKS9LFgQ10wnkQU15TLNFHnQqeQYNeZ54mihp3IC5r%2FC7gFdsiowJinaiCer6%2FGNhXkZrWGi5XFqu29ABzhBn4djOccgPrCr5YZP8uAW8fSrwdgP8C3V3L0asAphHmKiDm7ubTwjbvjLYzuGNGhJMrIbLgG7uVOoDEjQiejgDaZKEuVW2VSEyl5TkKbE7tRIW%2BzdYBA2wZKuq%2BzZW%2Bgpf1MZXiGINqqJYNdoJT4VL9aJyKqz7GVf9jAe3dtWTxMKjsuEJWOJtaZremDvf8NiuBULmsAiLPdK%2Fj5Th%2F0iBogEdUrhrrDj1WOkWKcdSc3RYzXMXaFaNbc9uKQHaKjTnVJvj%2BAoh1fJHr6WMPS%2BkvCgrUZqHLOGQqy9Py6zRakm3Z6ZlNmmpSh9MAefxx4jVC3%2FJ4%2BNwHB7uncxRC0bzZHWL2aHDLJHZN8mKIsGJv0favXvKs1u48dRHidvsM4B1m76kIsrT3e6DhLlry5TlkWJ1oQFSpzZAeGbZzdKT2HREBm2l58haIOdIpeewtnWMmyI6bRr2T6ZhswP%2BRBoKLqGS4Mp9TwX%2FhVQd1V7NvVyXk7XZwF08EQwHV5cIOnReZ6dUr8BGF6fU7DqmPEpSeKGvosCo76m9lk31zMQ6VPb%2Ffp82rHVX9Tqka5e29%2FPhtgwOi2%2Fy2fTiXxto%2Fgs%3D%3C%2Fdiagram%3E%3C%2Fmxfile%3E

  #grid(columns: 2, gutter: 0.5cm, align: bottom)[
    #image("eventloop.png", width: 17cm)
  ][
    #set text(size: 14pt)
    ```
    function main
        initialize()
        while message != quit
            message := get_next_message()
            process_message(message)
        end while
    end function
    ```
  ]

  La mayoría de las aplicaciones interactivas modernas se basan en
  alguna variante de event loop.

  #fuente("https://en.wikipedia.org/wiki/Event_loop")
]

#slide[
  = Ejemplo: Node.js

  #set text(size: 13pt)
  #quote[
    Node.js operates on a single-thread *event loop*, using *non-blocking* I/O
    calls, allowing it to support tens of thousands of concurrent connections
    without incurring the cost of thread context switching. The design of
    sharing a single thread among all the requests that use the
    *observer pattern* is intended for building highly concurrent applications,
    where any function performing I/O must use a *callback*.
  ]

  #align(center)[
    ```js
    const net = require('node:net');

    const server = net.createServer((client) => {
      console.log('client connected');
      client.on('end', () => {
        console.log('client disconnected');
      });
      client.on('data', (data) => {
        client.write(data);
      });
    });

    server.listen(5000, () => {
      console.log('server listening');
    });
    ```
  ]

  #fuente("https://nodejs.org/api/events.html")
]

#slide[
  #toolbox.side-by-side(columns: (1fr, auto), gutter: 1cm)[
    = Ejemplo: Eventos DOM

    *DOM* (_Document Object Model_) es el modelo de datos y la API que se
    utiliza principalmente para representar documentos HTML.

    // https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22Page-1%22%20id%3D%22p774UbMqfreBMpaSZLkb%22%3E7VlNc5swEP01PqaDEPjj2NpOO9Pm5Jk4OSpIBTXAMrIwkF9fYYSBaOJxZloLtznZ%2B7SS0Nt9WiEmeJmUXwXJojugLJ64Di0neDVxXeTihfqpkapFPKdBQsGpxjpgw1%2BYBlu3nFO2GzhKgFjybAgGkKYskAOMCAHF0O0nxMNZMxLqGZ0O2AQkZobbllMZNejc73l%2FYzyM2pmRo1sS0jprYBcRCkUPwusJXgoA2fxLyiWLa%2FZaXpp%2Bt2%2B0Hh9MsFSe0%2BH7ywPs53f3z0%2FbBO%2Bes2nB7m9m%2Btlk1S6YUbV%2BbYKQEYSQknjdoV8E5Cll9aiOsjqfHwCZApECfzEpKx1MkktQUCSTWLeyksuHuvsnX1uPvZZVqUc%2BGFVrpFJUvU61%2Bdhv67odrK4f%2FVyngTJTSFmD3PI41u3N%2ButFv0mrhnaQi4Cd4LJNTyJCJk%2F4ucfgK9kwSJh6XtVPsJhIvh8%2BB9HpGx79ugirPzrI7wi4HndP4lzPtOVpnZev82AY5SLikm0yciCgUFofRlQPyoRk5WkezXXrDrgVjt4pbtBCA0VPdxqKepLDzl%2Biav6hjT%2BmDfdMbWCb2nANbawgyJN6seNTB7KsDmRZHrN%2FSh%2F4TH14VmvHwm7I3f8y5MjqeQEbe%2BIhNKPbD7Hl7dB1r0gbF8tx78wc962Wffxx0Lt4xKdWI%2B5d0dlldKFDVtXqGQXpCWhlvSB5%2FrAg%2BZbrkW%2FWbWSdJIyHJCHXMktTM5lyKSG1ztTrdLLO1PEW8xrON6Ovkujc%2BxBk90LE3DI%2B6uQ7gmf3bd28zooYoda3NjSySonMV1w1MLHO02JkFQCZJy%2FJpWLHNlHHb4WjYco8fO0CwTP718j%2B7GJUKbP7tnlo630ixuvf%3C%2Fdiagram%3E%3C%2Fmxfile%3E
    #align(center)[ #image("dom.png", width: 100%) ]
  ][
    #align(center)[
      #set text(size: 12pt)
      ```html
      <!doctype html>
      <html lang="en">
        <head>
            <meta charset="utf-8">
            <title>Ejemplo DOM</title>
        </head>
        <body>
            <h1>Ejemplo DOM</h1>
            <button>Cambiar color</button>

            <script>
              const btn = document.querySelector("button");

              function random(number) {
                return Math.floor(Math.random() * (number + 1));
              }

              function handler() {
                const rndCol = `rgb(${random(255)} ${random(255)} ${random(255)})`;
                document.body.style.backgroundColor = rndCol;
              };

              btn.addEventListener("click", handler);
            </script>
        </body>
      </html>
      ```
    ]
  ]

  #fuente("https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting/Events")
]

#slide[
  #grid(columns: (1fr, auto), gutter: 1cm)[
    = DOM: Propagación de eventos

    #set text(size: 15pt)
    En el DOM, los eventos se propagan en 2 etapas:

      / Captura: Desde la raíz hacia un nodo *target*.
      / Burbujeo: Desde el nodo *target* hacia la raíz.

    Este detalle es relevante cuando se registran múltiples *listeners* en el DOM:
    el mecanismo de propagación determina el orden en que se ejecutan los
    *callbacks*.
  ][
    // https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22Page-1%22%20id%3D%22p774UbMqfreBMpaSZLkb%22%3E7Vpdc5s6EP01fvQdJIGNHxsnvZ1pO9OZdJr2UQbFqMGIESK28%2BuvZMSHrIRLG8cibZ5srVYL2t2zZxFM0HKz%2B5fjPPnMYpJOoBfvJuhyAiGAaCF%2FlGRfS3yvkqw5jbWsFVzTB6KFtVpJY1IYioKxVNDcFEYsy0gkDBnmnG1NtVuWmlfN8Vpf0WsF1xFOiaV2Q2ORVNIw6Gh%2FIHSd1FcGnp7Z4FpZC4oEx2zbEaGrCVpyxkT1b7NbklR5r%2FZLte79E7PNjXGSiSELPj58Z%2Ffh5293q5sNKu7y2ZZ8m871vYl9vWESy%2F3rIeMiYWuW4fSqlV5wVmYxUVY9OWp1PjGWSyGQwp9EiL0OJi4Fk6JEbFI9S3ZUfFfL%2Fwn06Edn5nKnLR8G%2B3qQCb7vLFLDH925dtlh1K6L36k0kMOMZaSSvKdpquer%2FatNP%2BlWLSpYySPS48s6PTFfE9GjB5vgS9gQtiHyfuU6TlIs6L15H1in77rRayMs%2F%2Bgg%2F0LAtd17nJb6Sjc0U3l5nAdmlLcJFeQ6xwcHbCXWzYhqo4QLsuv3o71vvQDVwNGVYgoWWrDt4E6Lkg7kkPdCrgrfsHEybMCB2EAusQEtbFyyqNyozY4PHcAxOoBjeMz%2FKHyggfjwnXLHwm3I4V8ZcuC0X0BWTTyEZnT1EDkuhxC%2BImycLcf9gTkeOKV99NbonT3iM6cR919R7zK60AGnaPUtQlqxeO%2BckPzAJKTANR%2B9neycDhnBQGRAp8gILGTE9N45MBAygQGgY2TMRumm4%2Frh3E3NsfVraGhHX0HA0AMw4PYEDLgN%2Bjgbo%2BHBc3s8Y59fJgTHzksbGFlrBOwzDWkYO%2FfTYmQMAOxWW1AhvePaUc3L4dF4ym69iojT3P17g2A%2BMldB21WrUgiWOXeV1ai6fv8IQ8tVNju3LBiluChoZPrFdGIhOLtrvmNAUnIrCXPJUsYP5hABcUDmjWZnZjGbIzz7BV61%2FdzxY%2FCIH2vZYLLUV%2FjCqHpB1xSHozLavkeubVR8r5e1MbIsIWhaaspObajqByxDMiB431HLlUIx%2FI59r%2Fe2fP9Z6mG%2F%2BvGmTXX5p9pdm9VNgJ%2FxjsGzEn2Jc1Fym5NV3n3CK5KaaY5Tus4UBmQOEpmxF6oS0Ain7%2FTEhsZx1aySgj7g1cGegoQOjjQeXEyCSwUJlolO4odLzwuXWl43wqAeVy0tmPWVIP1pkr7opPOlUQuZngLwZMGayn4ZzdFJUDM9ypJpEJom2O1tQcRRLpwm%2BvYnKV%2BrRvs4%2BNKx4uXirp5LCh1PqwLqR4xuuaxFPWkRnIqZArMQPULi83MyE7KfNPqYSXvq92lJklIY%2B4%2FRUghXaDY7zGAubCo8iPVTIfjtZ0RXXIZOxmX%2Bmbjs%2BI5BP9sE%2FrPUF%2F9DfbBP%2FYW4zH64vCj5qvxJ2AjITFEZ8JyQWVUzzkJmL8Flcth%2Bqlupt188o6v%2FAA%3D%3D%3C%2Fdiagram%3E%3C%2Fmxfile%3E

    #image("dom-eventos.png", width: 10cm)
  ]

  #set text(size: 12pt)
  #grid(columns: (1fr, auto, 1fr, auto, 1fr))[][
    ```html
    <body>
      <div id="container">
        <button>Click me!</button>
      </div>
      <pre id="output"></pre>
    </body>
    ```

    #[
      #set text(size: 10pt)
      JSFiddle: #linklet("https://jsfiddle.net/q4r69wc2/")
    ]
  ][][
    ```js
    const output = document.querySelector("#output");
    function handleClick(e) {
      output.textContent += `You clicked on a ${e.currentTarget.tagName} element\n`;
    }

    const container = document.querySelector("#container");
    const button = document.querySelector("button");

    document.body.addEventListener("click", handleClick, { capture: true });
    container.addEventListener("click", handleClick, { capture: true });
    button.addEventListener("click", handleClick);
    ```
  ][]

  #fuente("https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting/Event_bubbling#event_capture")
]

#slide[
  = JavaFX #strike[DOM] Scene graph

  #{
    set text(size: 11pt)
    let src = read("ejemplos/eventos/src/main/resources/App.fxml").split("\n").slice(7).join("\n")
    raw(src, lang: "java", block: true)
  }

  #place(bottom+left)[
    #image("eventos-javafx.png", width: 10cm)
  ]
  #place(bottom+right)[
    #{
      set text(size: 11pt)
      let src = read("ejemplos/eventos/src/main/java/tb025/AppController.java").split("\n").slice(12).join("\n")
      raw(src, lang: "java", block: true)
    }
  ]
  #place(bottom+left)[
    #image("eventos-javafx.png", width: 10cm)
  ]
  #place(top+right)[
    // https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22Page-1%22%20id%3D%22p774UbMqfreBMpaSZLkb%22%3E7VhRb5swEP41eeyEcbImj02adtLWp0xp%2B%2BiFG7AaDjlHIP31M%2BEIMNQonVRB1T7BfXdnm%2B%2F8nWxGchHlt0YlwR16oEeu4%2BUjeT1yXeHKmX0UyL5Cxk6J%2BCb0GKuBVfgMDFZhaejBthVIiJrCpA1uMI5hQy1MGYNZO%2Bw36vasifJ5RqcGVhuloRN2H3oUlOh00oj%2BBqEfVDMLhz2RqoIZ2AbKw6wByeVILgwilW9RvgBdsFfxUubdvOA9LsxATOckfH9%2BwN30bv306z6S26fkawbri0teG%2B2rDwbPfj%2BbaChAH2OllzU6N5jGHhSjOtaqY34gJhYUFvwDRHsupkoJLRRQpNkLeUgPRfqXCVuPDc91ziMfjH1lxGT2jaTCfGz66rSDVed5V8U2sGaMMZTITag1%2B7ssMrFbTM0GTlBX7UZlfKATcW4ZV%2FDamIBrdAsYgV2vDTCgFYW79r5TvH39Y1xdYfvCRX5FwXncndIpz7SiQgL%2FboN2kbMgJFgl6kBIZqXeLuiLJO7AEOQnP5u9stINN4oLMWMga8iOoaChOOm8EVPTT2n8rzTcM6UhByUNtyuNDcRDlIboWRqiZ21cvmdxyDPFMR6UOMSs35K7H6HkYlhnBdlpiOs55sPrh7Lndjju8PQTcroyoPrnatrmatIzVcfL0Oep6vUXjnOPVWJY56pq3UPrI8eb%2BUC0Ibr9dp4SYTw4poT7ZlRZs%2F4lcvA1%2FizJ5V8%3D%3C%2Fdiagram%3E%3C%2Fmxfile%3E
    #image("scenegraph.png", width: 5cm)
  ]

  #fuente("https://github.com/algoritmos3ce/algoritmos3ce.github.io/tree/main/presentaciones/clase04/ejemplos/eventos")
]

#slide[
  = JavaFX: Eventos

  #place(bottom+left)[
    #{
      set text(size: 11pt)
      let src = read("ejemplos/eventos2/src/main/java/tb025/AppController.java").split("\n").slice(16).join("\n")
      raw(src, lang: "java", block: true)
    }
  ]

  #place(top+right)[#shadowed[
    #{
      set text(size: 11pt)
      let src = read("ejemplos/eventos2/src/main/java/tb025/MyEvent.java").split("\n").slice(5).join("\n")
      raw(src, lang: "java", block: true)
    }
  ]]

  #fuente("https://github.com/algoritmos3ce/algoritmos3ce.github.io/tree/main/presentaciones/clase04/ejemplos/eventos2")
]

#fin()
