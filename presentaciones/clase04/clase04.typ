#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.0"

#import "../defs.typ": *

#show: default-style

#caratula[
  = Programación orientada a eventos
]

#slide[
  = Programación orientada a eventos

  Es un paradigma de programación en el que el *flujo del programa* es
  determinado por la ocurrencia de *eventos*, que son previstos pero no planeados
  (es decir, no se sabe cuándo ocurrirán).

  Un ejemplo común es el desarrollo de
  *interfaces gráficas de usuario (GUI)*. En este caso, se deben manejar eventos como
  clics de ratón, pulsaciones de teclado, etc. Pero no es el único contexto en el que
  encuentra aplicación este paradigma.

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

  #fuente("https://en.wikipedia.org/wiki/Event-driven_programming")
]

#slide[
  = Mensajes sincrónicos

  Tradicionalmente los objetos se comunican mediante el envío *mensajes*,
  que en la mayoría de los lenguajes de programación se traduce directamente
  en la invocación de un *método*.
  De esta manera:

  - La comunicación es *uno a uno* (un remitente, un destinatario).

  - El receptor puede responder el mensaje en forma *sincrónica* (el remitente
    queda bloqueado hasta que el destinatario responde).

  - El emisor depende del destinatario (ya que conoce su interfaz).

  #toolbox.side-by-side(columns: (1fr, auto, 1fr, auto, 1fr))[][
    // @startuml
    // hide footbox
    // participant Aplicación
    // participant Persona
    // activate Aplicación
    // Aplicación -> Persona : getNombreCompleto()
    // hnote over Aplicación : bloqueado
    // activate Persona
    // Aplicación <-- Persona : "Juan Perez"
    // deactivate Persona
    // deactivate Aplicación
    // @enduml
    #align(center)[ #image("mensaje.png", width: 7cm) ]
  ][][
    // @startuml
    // hide circle
    // class Aplicación
    // class Persona {
    //   getNombreCompleto()
    // }
    // Aplicación ..> Persona : depende de
    // @enduml
    #align(center)[ #image("mensaje2.png", width: 4cm) ]
  ][]
]

#slide[
  = Eventos y _polling_

  Una estrategia posible para procesar eventos es la de *polling* (encuestar),
  que suele ser ineficiente.

  // @startuml
  // hide footbox
  // participant Teclado
  // participant Aplicación
  // activate Aplicación
  // Aplicación -> Teclado : getTeclaPresionada()
  // activate Teclado
  // Teclado --> Aplicación : null
  // deactivate Teclado
  // Aplicación -> Teclado : getTeclaPresionada()
  // activate Teclado
  // Teclado --> Aplicación : null
  // deactivate Teclado
  // Aplicación -> Teclado : getTeclaPresionada()
  // activate Teclado
  // Teclado --> Aplicación : "A"
  // deactivate Teclado
  // @enduml
  #align(center)[ #image("polling.png", width: 7cm) ]
]


#slide[
  = Publish/Subscribe

  Una estrategia más eficiente es la de *publicación* y *suscripción* a
  eventos. De esta manera:

  - La comunicación puede ser *uno a muchos* (un publicador, múltiples
    suscriptores).

  - El suscriptor no responde al evento, sino que lo *maneja* de manera
    *asíncrona* (el publicador no queda bloqueado, sino que continúa
    ejecutando su código).

  - La dependencia se invierte: el publicador no conoce a los suscriptores.

    #toolbox.side-by-side(columns: (1fr, auto, 1fr, auto, 1fr))[][
      // @startuml
      // hide footbox
      // participant Teclado
      // activate Teclado
      // participant Aplicación
      // Aplicación -> Teclado : suscribir(TeclaPresionada)
      // note right : se suscribe al evento
      // activate Teclado
      // deactivate Teclado
      // Teclado --> Aplicación : <<evento>> TeclaPresionada "A"
      // note left : publica el evento
      // activate Aplicación
      // note right : maneja el evento
      // deactivate Aplicación
      // @enduml
      #align(center)[ #image("pubsub1.png", width: 15cm) ]
    ][][
      // @startuml
      // hide circle
      // class Teclado {
      //   suscribir()
      // }
      // class Aplicación
      // Aplicación .up.> Teclado : depende de
      // @enduml
      #align(center)[ #image("pubsub2.png", width: 3.5cm) ]
    ][]

  #fuente("https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern")
]

#slide[
  = Patrón Observer

  Es un patrón de diseño de POO que implementa la
  estrategia de *Publish/Subscribe*.

  #align(center)[ #image("observer.png", width: 15cm) ]

  #fuente("https://refactoring.guru/design-patterns/observer")
]
