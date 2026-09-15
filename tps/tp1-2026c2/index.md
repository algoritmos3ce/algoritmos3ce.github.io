---
title: "TP1"
layout: default
nav_order: 1
nav_exclude: true
---

<img src="./portada.png" style="width: 50%">

# TP1: PARADIGWENT
{: .no_toc }

**Paradigmas de Programación - FIUBA**  
**Enunciado de Trabajo Práctico 1**

1. Índice
{:toc}

---

## Objetivo

Implementar una versión propia del estilo del juego de cartas **Gwent** (marca registrada), aplicando conceptos de **Programación Orientada a Objetos (POO)** y principios de buen diseño de software. Nuestro juego se llamará Paradigwent.

---

## Referencias

- 📖 [Reglas de Gwent en Wikipedia](https://witcher.fandom.com/wiki/Gwent)

---

## Aplicación de temas y conceptos

- Programación Orientada a Objetos  
- Principios de diseño (bajo acoplamiento, alta cohesión, DRY, KISS, SOLID, etc.)  
- Interfaces gráficas con **JavaFX**  
- Gestión de dependencias con **Maven**

---

## Contexto del Proyecto

El juego debe estar dividido en al menos dos capas de abstracción:

- **Modelo**: enemigos, torretas, lógica de juego, niveles.  
- **Vista/Presentación**: renderizado gráfico, sonidos, interacción con el usuario.  

Las clases del modelo **no deben depender** de JavaFX ni de clases de la vista.

---

## Reglas del Juego

### Escenario

- Resolución fija de referencia: **800x600 píxeles**.  
- El escenario incluye:
  - Un tablero de base
  - Zona de Cartas de Clima (afectan a ambos jugadores)
  - Una sección para cada Jugador, que contendrá:
    - Pila de cartas (Mazo)
    - Pila de descarte
    - Cartas en Mano
    - Zonas de Cartas en Juego, con sus 3 secciones:
      - Ataque Cuerpo a Cuerpo
      - Ataque a Distancia
      - Asedio
    - Zona de Puntaje de Ronda (se actualizará según estado del tablero)
    - Indicador de Vidas (3 inicialmente para cada jugador)


### Mazo de Cartas
- Las cartas deberán tener un mínimo de 3 faccinoes distintas diferenciables.
- Las facciones se diferenciarán por color de cartas. 
- Estética y lógicamente, las facciones podrán tener otras diferencias, a criterio del equipo, en términos de atributos, fortalezas y debilidades, etc.
- Cada facción tendrá un mínimo de 30 cartas diferentes.
- No se crearán cartas de "Rey"
- Cada facción deberá tener al menos **3 cartas de clima**, **2 cartas de efectos** y **2 cartas de criatura con habilidades especiales**.
- Los detalles de efecto de cartas de clima, efectos y habilidades precedentes quedan a definirse por el equipo. Se recomienda tomar inspiración en elementos del juego original.
- Las cartas de clima afectan a todo el tablero, mientras que las de efectos a un grupo de cartas objetivo (por ejemplo, toda una fila de cartas, propia o enemiga).
- Las cartas de habilidades pueden afectar a otras cartas de habilidades.
- Los efectos de las cartas de habilidades y de clima son de aplicación inmediata. Pueden modificar el estado del tablero, así como el efecto de las cartas ya jugadas (en cuyo caso el impacto deberá reflejarse en el tablero de estado de juego).
- Las demás cartas serán "criaturas de combate". 
- Podrán no se modelarse "héroes", pero si el equipo lo desea queda abierta la posibilidad para extender la experiencia de juego.

### Enemigos

- El adversario será siempre la computadora. 
- El adversario elegirá alguna de las cartas de su mano para continuar jugando o podrá decidir terminar la mano actual también si tiene esa posibilidad.
- La IA es de libre interpretación por parte del equipo. La partida debe resultar razonablemente jubable

### Dinámica de juego

- Ambos jugadores inician con 10 cartas en la "Mano".
- El resto de las cartas quedan en el "Mazo"
- Las cartas que por dinámica y efecto de otras cartas son eliminadas, pasarán al "Descarte".
- El juego consiste en Rondas, divididas en Turnos.
- Cada Ronda se limpian todas la cartas del tablero de la Ronda anterior y van al "Descarte". 
- No hay reposición de Cartas de "Mano": la Mano dura toda la partida (hay que administrar las cartas que se juegan en cada Ronda).
- Se sortea qué jugador tiene primero su Turno. Por cada Turno se puede jugar una sola carta.
- Los jugadores juegan turnos de forma alternada durante una Ronda. A cada Turno se actualiza el Estado del tablero (factores de Fuerza).
- En cualquier momento un jugador puede decidir "Pasar" (no jugando ninguna carta).
- Un jugador que ya "pasó" en una Ronda no vuelve a tener turnos. Mientras tanto, el otro puede jugar tantos turnos como desee, sea para dar vuelta el resultado si estaba perdiendo jugando cartas o rindiéndose si ya no quiere invertir más.
- Cuando ambos jugadores "Pasan", se evalúa la Fuerza de cada jugador en el tablero. Gana la Ronda el que más "Fuerza" haya podido agrupar. A este efecto, se computa la fuerza de todas las cartas, considerando los modificadores de cartas de Clima y cartas de Efecto que se encuentren activas en el tablero.
- Gana el primer jugador que pueda ganar dos Rondas (el juego es al mejor de tres).

---

## Carga de Niveles

El juego tiene un único nivel. No obstante, el Juego deberá tener un menú de inicio con una imagen de portada. Se puede utilizar la provista u otra propia. Una vez iniciado un Juego, existirá en todo momento la posibilidad de "Rendirse". Además, cuando se termina un juego o el jugador se rinde, deberá salir una notificación con el resultado del Juego y luego se pasará al menú de inicio nuevamente.

---

## Interfaz

- Menú de inicio con:
  - Imagen de bienvenida
  - **Iniciar juego** 
  - **Salir**.
- Pantalla de Juego con Escenario: ver sección [Escenario](#escenario)
- Flujos:
  - Menú de Inicio -> Partida -> Victoria → cartel de victoria → Menú de Inicio.  
  - Menú de Inicio -> Partida -> Derrota → cartel de derrota → Menú de Inicio.
- Interactividad:
  - Se podrá seleccionar la carta mediante desplazamiento con teclas de flecha y confirmando con ENTER. Para este caso, deberá ser accesible una opción de "Pasar" y además "Rendirse", a fin de dar acceso a todas las acciones posibles al jugador a partir del teclado. El grupo podrá definir el uso de teclas a este fin.
  - Alternativamente se podrá utilizar el Mouse. Para esto se jugarán cartas haciendo click en las mismas y habrá botones de acción en el tablero para las distintas acciones posibles.
  - Los grupos pueden implementar una o ambas formas de interacción.

---

##  Gráficos y Sonidos

- Cada grupo debe obtener o generar sus propios **sprites y sonidos**.  
- Se recomienda mantener coherencia visual y sonora.  
- No infringir derechos de autor de material de uso restringido. Mencionar licencias de uso en archivo README del TP y acreditar autores de material ajeno citando las fuentes cuando corresponda, según licencia de uso (si se requiere acreditación).
- Se puede generar contenido digital con IA.
- Los sonidos deben ser música de fondo en bucle y efectos para los siguientes eventos clave del juego:
  - juego de carta (fin de turno)
  - pase de jugador (deja de jugar la Ronda)
  - fin de Ronda
  - sonidos de Efecto
  - sonidos de Clima
  - victoria
  - derrota

  Otros sonidos quedan a criterio de diseño del equipo, eventualmente a acordar con el tutor/corrector.

### Sitios recomendados

- **[OpenGameArt.org](https://opengameart.org/)**  
  Repositorio comunitario de sprites, tilesets, íconos y efectos visuales para videojuegos. Todo el material está bajo licencias libres (Creative Commons, GPL, etc.), ideal para proyectos académicos.

- **[Freesound.org](https://freesound.org/)**  
  Biblioteca colaborativa de efectos de sonido y música, con licencias abiertas. Permite descargar y reutilizar sonidos siempre que se respeten las condiciones de atribución.

- **[Pixabay](https://pixabay.com/sound-effects/)**  
  Además de imágenes, ofrece música y efectos de sonido libres de derechos, aptos para uso no comercial y académico.

### Assets provistos por la catedra (Opcionales)

Para este trabajo la cátedra no provee assets de referencia, salvo la portada. Se puede utilizar la portada para el menú de inicio, si se desea.

### Observación

Se debe verificar siempre la **licencia específica** de cada recurso descargado, ya que algunos requieren atribución explícita al autor. El uso de material con licencias abiertas es obligatorio para evitar problemas legales o de derechos de autor.
Si algún recurso requiere atribución, se debe mencionarlo en el archivo **README.md** del proyecto.

---

## Requerimientos Funcionales

- Implementación completa de las reglas descritas.
- Implementación de la visualización de estado del tablero y del estado del juego.
- Se debe poder completar partidas de punta a punta.
- La IA debe presentar un comportamiento "razonable" para mantener una jugabilidad mínima.

Extras opcionales para mejor nota:
- Animaciones en sprites, desplazamiento de cartas, efectos visuales, efectos de sonido adicionales, etc.  

---

## Requerimientos No Funcionales

- Lenguaje: **Java**
- Interfaz: **JavaFX**.
- Dependencias: **Maven**.
- Repositorio: **GitHub**.
- Separación clara entre modelo y vista.  

---

## Documentación Escrita

Debe incluir:

- Diagrama de Clases UML del modelo.  
- Archivo `readme.md` con:
  - Universidad, Facultad, Materia.  
  - Docentes y corrector.  
  - Integrantes del grupo.  
  - Nombre del proyecto.  
  - Descripcion breve del proyecto.
  - Instrucciones de ejecución.
  - Instrucciones de juego (reglas y controles).
  - Formato `.xml` utilizado para la carga de niveles

  
### Observación

 **El archivo readme.md debe ser creado y completado al inicio del desarrollo del trabajo práctico para que se pueda asignar el docente corrector al grupo. Sin este archivo, la cátedra no podrá identificar al grupo y podrían perder la regularidad de no cumplir este requerimiento a tiempo. Se debe completar el readme al crear el repositorio al menos con los datos básicos del proyecto y alumnos, para completar luego más adelante las instrucciones detalladas para la ejecución del programa y las reglas del juego. Se REQUIEREN INMEDIATAMENTE los datos de los alumnos al comienzo del TP.**



---

## Pruebas y Optimización

- No se requiere optimización avanzada de física o renderizado
- Pruebas automáticas: **opcionales**, solo para clases del modelo
  - Se recomienda:
    - Al menos **1 test de integración** (integración entre clases)
    - Tests unitarios de **3 clases distintas**
	- No es obligatorio usar mockito

---

## Documentación Audiovisual

Cada integrante debe presentar un video individual que cumpla con:

- Duración: **5 a 10 minutos**
- Debe verse la **cara del expositor**
- Mostrar el juego funcionando (máximo 1 minuto)
- Explicar:
  - Diseño de clases
  - Uso de polimorfismo
  - Principios de diseño respetados y no respetados y criterior aplicado

---

## Entrega y Gestión de Repositorio

La entrega se realiza mediante **GitHub**, en equipos de **2 integrantes**.

### Pasos para vinculación:

1. Crear un repositorio en GitHub con archivo .gitignore estándar para maven/IntelliJ/Java.
2. Configurar proyecto maven y subir un proyecto maven/javafx compilable y ejecutable ("Hola Mundo").
3. Crear archivo README.md con los datos de los integrantes del grupo y la información general.
4. Enviar el enlace una sola vez por el grupo del repo por mensaje privado a Santiago Maraggi, indicando integrantes por apellido y padrón.
5. Dar permiso de acceso a los Docentes Diego Essaya (dessaya) y Santiago Maraggi (smaraggi-fiuba).
6. Se dará acceso al Tutor/Corrector adicionalmente una vez asignado.

### Repositorio

- GitHub permite dar acceso por usuarios
- Entrega oficial: mediante **Pull Request**
  - Indicar rama de entrega
  - Estado del proyecto
  - Condiciones de ejecución
- Se recomienda clonar el repositorio en limpio para verificar funcionamiento
- Al aprobarse, los cambios deben quedar todos integrados a la **rama principal** (main)

>  *El archivo `readme.md` debe ser el primer archivo incluido en el repositorio, INMEDIATAMENTE AL INICIARSE EL TP CON LOS DATOS DE LOS INTEGRANTES DEL GRUPO.*

### Observaciones

- Cada equipo debe tener **un único repositorio compartido**
- La entrega será válida **solo si ambos integrantes están correctamente vinculados**
- No crear el repositorio manualmente; se genera al aceptar la invitación
- Los repositorios son PRIVADOS para los integrantes del grupo. Queda prohibido compartir su contenido y dar accesos a otros alumnos.
- Ante dudas o problemas técnicos, contactar al equipo docente con anticipación

---

## Trabajo de Referencia

Se incluye un ejemplo para ilustrar la **separación en capas** y el uso de **Canvas en JavaFX** para renderizar en tiempo real.

- Juego: implementación de **Pong** para dos jugadores
- Controles por teclado
- Descargable y ejecutable

 [Repositorio de referencia - Pong](https://github.com/algoritmos3ce/pong)

## Criterios de Corrección

### Principios de Programación evaluados

El código será analizado en función de los siguientes principios:

- **Tell, Don’t Ask**
- **Principle of Least Astonishment**
- **Principle of Least Knowledge**
- **Don't Repeat Yourself (DRY)**
- **YAGNI (You Ain't Gonna Need It)**
- **Keep It Simple, Stupid (KISS)**
- **Explicit Dependencies Principle**
- **Knuth's Optimization Principle**
- **Separation of Concerns**
- **Principios SOLID**

> Se busca lograr **bajo acoplamiento** y **alta cohesión** en el diseño de clases.

---

### Aspectos específicos a evaluar

- Jugabilidad completa según reglas de juego descritas
- Se puede ganar el juego jugándolo completo.
- Reinicio del juego sin salir de la aplicación a través del menú principal
- Corrección del diagrama de clases
- Video individual por integrante, con exposición clara de decisiones de diseño
- Elegancia y legibilidad del código
- Uso correcto del paradigma de **Programación Orientada a Objetos**
- Aplicación de **polimorfismo** en los enemigos y torretas.
- Diseño de clases según principios vistos
- Separación adecuada entre **vista** y **lógica**
- Ausencia de dependencias del modelo hacia la vista o clases de JavaFX
- Manejo correcto de archivos de nivel.
- Inexistencia de errores en tiempo de ejecución y correcta gestión de errores de archivo.
- Las contribuciones de todos los integrantes del grupo al proyecto deben ser significativas

---

## Prácticas prohibidas

- Variables globales o `static` (excepto constantes).  
- Métodos o clases excesivamente largas (código spaghetti).  
- Uso de `instanceof` para distinguir tipos que violen OCP y TDA.

---

## Entrega y Nota

- La entrega debe realizarse dentro del plazo indicado como **"fecha límite de entrega"** en el calendario de la materia.
- Si no se cumple con esta fecha, el trabajo será considerado **desaprobado** y no se aceptarán entregas posteriores.

### Evaluación

- Una vez recibido el trabajo, el corrector decidirá si está **aprobado o no**.
- Si se aprueba, se asignará una **nota entre 4 y 10**.
- Se contempla **una única instancia de reentrega**, dentro del plazo de la **"fecha límite de aprobación"**, tanto si el trabajo fue aprobado como si no.

> *Es responsabilidad del grupo cumplir con los plazos y condiciones establecidos por la cátedra.*


---
