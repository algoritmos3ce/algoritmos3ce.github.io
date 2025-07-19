#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.0"
#import "@preview/prequery:0.1.0"

#import "../defs.typ": *

#show: default-style

#let nosi(body1, body2) = [
  #grid(columns: (1fr, auto, 1fr, auto, 1fr))[][
    #malo[ No ]
    #body1
  ][][
    #bueno[ Sí ]
    #body2
  ][]
]

#caratula[
  = Principios de diseño
]

#slide[
  #layout(size => [
    #toolbox.side-by-side(columns: (1fr, auto))[
      = Algunas definiciones

      / Code smell: Un indicio de que algo no está bien en el código.
        #link("https://en.wikipedia.org/wiki/Code_smell")[\#]

      / Deuda técnica: Es el costo implícito del trabajo adicional futuro resultante de elegir
        una solución fácil sobre una más robusta. #link("https://en.wikipedia.org/wiki/Technical_debt")[\#]

      / Refactoring: Proceso de reestructuración del código para mejorar su
        legibilidad, mantenibilidad y extensibilidad, sin cambiar su comportamiento
        externo. #link("https://en.wikipedia.org/wiki/Code_refactoring")[\#]

      #quote(attribution: [Martin Fowler])[
        Any fool can write code that a computer can understand. Good
        programmers write code that humans can understand.
      ]
    ][
      #image("refactoring.jpg", height: size.height)
    ]
  ])
]

#slide[
  #layout(size => [
    = No solo es acerca del código

    #toolbox.side-by-side(columns: (1fr, auto))[
      #quote(attribution: [Linus Torvalds])[
        ...git actually has a simple design, with stable and reasonably
        well-documented data structures. In fact, I'm a huge proponent of
        designing your code around the data, rather than the other way around,
        and I think it's one of the reasons git has been fairly successful [...]
        I will, in fact, claim that the difference between a bad programmer
        and a good one is whether he considers his code or his data structures
        more important. *Bad programmers worry about the code. Good programmers
        worry about data structures and their relationships.*
      ]
    ][
      #image("linus.jpg", height: size.height * 0.8)
    ]
  ])
]

#slide[
  #layout(size => [
    = Principios de diseño

    #toolbox.side-by-side(columns: (1fr, auto))[
      - YAGNI (You Ain’t Gonna Need It) // done
      - KISS (Keep It Simple, Stupid!) // done
      - DRY (Don’t Repeat Yourself) // done
      - PoLA (Principle of Least Astonishment) // done
      - KOP (Knuth's Optimization Principle) // done
      - SoC (Separation of Concerns Principle) // done
      - Alta cohesión, bajo acoplamiento // done

      OOP:

      - TDA (Tell, Don’t Ask!) // done
      - PoLK (Principle of Least Knowledge) // done
      - EDP (Explicit Dependencies Principle)
      - SOLID (SRP, OCP, LSP, ISP, DIP)
      - Composition over inheritance
    ][
      #image("wtfs.png", height: size.height * 0.8)
    ]
  ])

  #fuente("https://en.wikipedia.org/wiki/Category:Programming_principles")
]

#slide[
  = YAGNI: You Ain’t Gonna Need It

  *¡No lo vas a necesitar!:* Solo agregar una funcionalidad si es requerida.

  #v(1fr)
  #align(center)[ #image("yagni.png", width: 15cm) ]
  #v(1fr)

  #fuente("https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it")
]

#slide[
  #toolbox.side-by-side(columns: (1fr, auto))[
    = KISS: Keep It Simple, Stupid!

    *¡Mantenlo simple, estúpido!*
  ][
    #image("kiss.jpg", width: 7cm)
  ]

  #set text(size: 14pt)
  #nosi[
    ```java
    public int esPar(int n) {
        if (n < 0) {
            n = -n;
        }
        if (n == 0) {
            return true;
        }
        if (n == 1) {
            return false;
        }
        return esPar(n - 2);
    }
    ```
  ][
    ```java
    public int esPar(int n) {
        return n % 2 == 0;
    }
    ```
  ]

  #fuente("https://en.wikipedia.org/wiki/KISS_principle")
]

#slide[
  = KISS: Keep It Simple, Stupid! (cont.)

  #set text(size: 14pt)
  #nosi[
    ```java
    public class Punto {
        private final int x;
        private final int y;

        public Punto(int x, int y) {
            this.x = x;
            this.y = y;
        }

        public int getX() {
            return x;
        }

        public int getY() {
            return y;
        }
    }
    ```
  ][
    ```java
    public class Punto {
        public final int x;
        public final int y;

        public Punto(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }
    ```
  ]
]

#slide[
  = DRY: Don’t Repeat Yourself

  *¡No te repitas!*

  #set text(size: 14pt)
  #nosi[
    ```java
    public static void main(String[] args) {
        System.out.println("¡No voy a repetir código!");
        System.out.println("¡No voy a repetir código!");
        System.out.println("¡No voy a repetir código!");
        System.out.println("¡No voy a repetir código!");
        System.out.println("¡No voy a repetir código!");
    }
    ```
  ][
    ```java
    public static void main(String[] args) {
        for (int i = 0; i < 5; i++) {
            System.out.println("¡No voy a repetir código!");
        }
    }
    ```
  ]
]

#slide[
  = DRY: Don’t Repeat Yourself (cont.)

  #set text(size: 14pt)
  #nosi[
    ```java
    public void depositar(int monto) {
        if (monto < 0) {
            throw new IllegalArgumentException("...");
        }
        saldo += monto;
    }

    public void retirar(int monto) {
        if (monto < 0) {
            throw new IllegalArgumentException("...");
        }
        saldo -= monto;
    }
    ```
  ][
    ```java
    void chequearMonto(int monto) {
        if (monto < 0) {
            throw new IllegalArgumentException("...");
        }
    }

    public void depositar(int monto) {
        chequearMonto(monto);
        saldo += monto;
    }

    public void retirar(int monto) {
        chequearMonto(monto);
        saldo -= monto;
    }
    ```
  ]
]

#slide[
  = DRY: Don’t Repeat Yourself (cont.)

  #set text(size: 14pt)
  #nosi[
    ```java
    public class CursoParadigmas {
      public void inicio() {
        System.out.println("Bienvenido a TB025!");
      }

      public void fin() {
        System.out.println("Gracias por cursar TB025!");
      }
    }
    ```
  ][
    ```java
    public class CursoParadigmas {
      public static final String CODIGO = "TB025";

      public void mostrarMensaje(String mensaje) {
        System.out.println(mensaje);
      }

      public void inicio() {
        mostrarMensaje("Bienvenido a " + CODIGO + "!");
      }

      public void fin() {
        mostrarMensaje("Gracias por cursar " + CODIGO + "!");
      }
    }
    ```
  ]
]

#slide[
  #toolbox.side-by-side(columns: (1fr, auto))[
    = POLA: Principle of Least Astonishment

    *Principio del menor asombro:* Un componente de un sistema debe comportarse como la mayoría de sus usuarios
    esperan que se comporte, y no sorprender con comportamientos inesperados.
  ][
    #image("pola.png", width: 7cm)
  ]

  #set text(size: 14pt)
  #nosi[
    ```java
    public class CuentaBancaria {
        private int saldo;

        public void depositar(int monto) {
            if (monto < 0) {
                return;
            }
            saldo += monto;
        }

        public int getSaldo() {
            return saldo;
        }
    }
    ```
  ][
    ```java
    public class CuentaBancaria {
        private int saldo;

        public void depositar(int monto) {
            if (monto < 0) {
                throw new IllegalArgumentException("...");
            }
            saldo += monto;
        }

        public int getSaldo() {
            return saldo;
        }
    }
    ```
  ]

  #fuente("https://en.wikipedia.org/wiki/Principle_of_least_astonishment")
]

#slide[
  #toolbox.side-by-side(columns: (1fr, auto))[
    = KOP: Knuth's Optimization Principle

    *Principio de optimización de Knuth:* No optimizar el código prematuramente.

    #quote(attribution: [Donald Knuth])[
      The real problem is that programmers have spent far too
      much time worrying about efficiency in the wrong places
      and at the wrong times; *premature optimization is
      the root of all evil* (or at least most of it) in programming.
    ]

    En caso de decidir optimizar, *medir el rendimiento* (_profiling_) del
    código antes y después, para asegurarse de que la optimización
    realmente mejora el rendimiento.
  ][
    #image("knuth.jpg", width: 7cm)
  ]

  #fuente("https://en.wikipedia.org/wiki/Program_optimization#When_to_optimize")
]

#slide[
  = SoC: Separation of Concerns

  *Separación de incumbencias:* Dividir un sistema en partes independientes
  que abordan diferentes aspectos o dominios relacionados con el problema a
  resolver.

  #align(center)[
    #v(1fr)
    #cetz.canvas({
      import cetz: coordinate
      import cetz.draw: *

      let layer(pos, label, fill) = {
        rect(pos, (rel: (20, 2), to: pos), fill: fill, stroke: none)
        content((rel: (0.5, 1), to: pos), anchor: "west", label)

        for h in (5, 10, 15) {
          rect((rel: (h, 0.2), to: pos), (rel: (4, 1.6)), fill: white)
          content((rel: (h+2, 1), to: pos), [ Módulo ])
        }
      }

      layer((0, 0), "Presentación", azul.desaturate(50%))
      layer((0, -2), "Lógica", azul.desaturate(70%))
      layer((0, -4), "Persistencia", azul.desaturate(90%))
    })
    #v(1fr)
  ]

  #fuente("https://en.wikipedia.org/wiki/Separation_of_concerns")
]

#slide[
  #toolbox.side-by-side(columns: (1fr, auto))[
    = Alta cohesión

    *Cohesión:* es la medida en que dos elementos de un módulo están relacionados
    entre sí.

    Es preferible que los módulos tengan *alta cohesión*; es decir, que sus
    elementos (variables, funciones, clases, métodos) estén estrechamente
    relacionados y trabajen juntos para cumplir un propósito específico.

    = Bajo acoplamiento

    *Acoplamiento:* es la medida en que un módulo depende de otros módulos.

    Es preferible que los módulos tengan *bajo acoplamiento*; es decir, que
    dependan lo menos posible de otros módulos, lo que facilita su reutilización,
    mantenimiento y prueba.
  ][
    #image("CouplingVsCohesion.svg", width: 10cm)
  ]

  #fuente("https://en.wikipedia.org/wiki/Cohesion_(computer_science)")
]


#slide[
  #layout(size => [
    #toolbox.side-by-side(columns: (1fr, auto))[
      = TDA: Tell, don’t ask!

      *¡Di qué hacer, no preguntes!*

      #malo[ No: ]
      Solicitarle a un objeto que indique su estado y luego realizar una acción
      en base a su respuesta.

      #bueno[ Sí: ]
      Solicitarle al objeto que lleve a cabo la acción él mismo.
    ][
      #image("tda.png", height: size.height)
    ]
  ])
  #fuente("https://martinfowler.com/bliki/TellDontAsk.html")
]



#slide[
  = TDA: Tell, don’t ask! (cont.)

  #set text(size: 12pt)
  #nosi[
    ```java
    class Logger {
        public boolean habilitado;

        public void log(String message) {
            System.out.println(message);
        }
    }

    public class CuentaBancaria {
        private Logger logger;
        private int saldo;

        public CuentaBancaria(Logger logger) {
            this.logger = logger;
        }

        public void depositar(int monto) {
            saldo += monto;
            if (logger.habilitado) {
                logger.log("Depositando " + monto);
            }
        }
    }
    ```
  ][
    ```java
    class Logger {
        public boolean habilitado;

        public void log(String message) {
            if (habilitado) {
                System.out.println(message);
            }
        }
    }

    public class CuentaBancaria {
        private Logger logger;
        private int saldo;

        public CuentaBancaria(Logger logger) {
            this.logger = logger;
        }

        public void depositar(int monto) {
            logger.log("Depositando " + monto);
            saldo += monto;
        }
    }
    ```
  ]
]

#slide[
  = PoLK: Principle of Least Knowledge

  *Principio del menor conocimiento* o *Ley de Demeter*: Para promover el bajo
  acoplamiento, cada módulo debería conocer lo menos posible sobre otros módulos.

  Aplicado a objetos, un método `f` de una clase
  `C` solo debería invocar métodos de:

  - la propia clase `C`;
  - los objetos que son atributos de `C`;
  - los objetos recibidos por `f` como argumentos;
  - los objetos instanciados en `f`.

  #fuente("https://en.wikipedia.org/wiki/Law_of_Demeter")
]

#slide[
  = PoLK: Principle of Least Knowledge (cont.)

  #set text(size: 12pt)
  #nosi[
    ```java
    class Universidad {
      private List<Carrera> carreras;

      public List<Estudiante> getInscriptos(String codCarrera,
                                            String codCurso) {
        Carrera car = buscarCarrera(codCarrera);
        Curso cur = car.buscarCurso(codCurso);
        return cur.getInscriptos();
      }
    }

    class Carrera {
      private List<Curso> cursos;

      public Curso buscarCurso(String codCurso) {
        // ...
      }
    }
    ```
  ][
    ```java
    class Universidad {
      private List<Carrera> carreras;

      public List<Estudiante> getInscriptos(String codCarrera,
                                            String codCurso) {
        Carrera car = buscarCarrera(codCarrera);
        return car.getInscriptos(codCurso);
      }
    }

    class Carrera {
      private List<Curso> cursos;

      public List<Estudiante> getInscriptos(String codCurso) {
        // ...
      }

      public Curso buscarCurso(String codCurso) {
        // ...
      }
    }
    ```
  ]
]

#slide[
  = EDP: Explicit Dependencies Principle

  // Methods and classes should explicitly require any collaborating objects they need in order to function correctly.

  Las clases y métodos deben requerir explícitamente los objetos
  necesarios para funcionar correctamente, en lugar de asumir que
  están disponibles en el contexto.

  #set text(size: 14pt)
  #nosi[
    ```java
    public class Logger {
        public void log(String s) {
            System.out.println(s);
        }
    }
    ```
  ][
    ```java
    public class Logger {
        private final PrintStream out;

        public Logger(PrintStream out) {
            this.out = out;
        }

        public void log(String s) {
            out.println(s);
        }
    }
    ```
  ]

  #fuente("https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/architectural-principles#explicit-dependencies")
]

#slide[
  = Principio SOLID

  #v(1fr)
  #align(center)[
    #image("solid.png", width: 100%)
  ]
  #v(1fr)

  #fuente("https://en.wikipedia.org/wiki/SOLID")
]

#slide[
  = SRP: Single Responsibility Principle

  *Principio de responsabilidad única:* Cada clase debe tener una única
  responsabilidad o propósito.

  #set text(size: 12pt)
  #nosi[
    ```java
    public class Producto {
        public String nombre;
        public double valor;

        public String toString() {
            return "Producto: " + nombre + ", Valor: " + valor;
        }

        public void guardar() {
            FileWriter writer = new FileWriter("productos.txt");
            writer.write(toString() + "\n");
            writer.close();
        }

        public void mostrar() {
            System.out.println(toString());
        }
    }
    ```
  ][
    ```java
    public class Producto {
        public String nombre;
        public double valor;

        public String toString() {
            return "Producto: " + nombre + ", Valor: " + valor;
        }
    }

    public class BaseDeDatos {
        public void guardarProducto(Producto producto) {
            FileWriter writer = new FileWriter("productos.txt");
            writer.write(producto.toString() + "\n");
            writer.close();
        }
    }

    public class Consola {
        public void mostrarProducto(Producto producto) {
            System.out.println(producto.toString());
        }
    }
    ```
  ]
]

#fin()
