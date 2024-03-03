---
title: "Uso de Maven"
---

Para el desarrollo de los TPs se permite usar cualquier IDE o editor de texto.
Pero en cualquier caso, es **obligatorio** el uso de **Maven**, ya que esto
facilita que un proyecto pueda ser compilado y ejecutado en diferentes
entornos.

## ¿Qué es Maven?

[Maven](https://maven.apache.org/) es una herramienta para la gestión y
construcción de proyectos Java.

Maven utiliza un Project Object Model (POM) para describir el proyecto a
construir, sus dependencias de otros módulos y componentes externos, y el orden
de construcción de los elementos. La configuración de Maven se almacena en un
archivo llamado `pom.xml`,

## Instalación

Maven puede ser utilizado desde IntelliJ IDEA o Eclipse y **no es necesario
instalarlo**.

También es posible utilizar Maven desde la consola mediante el comando `mvn`,
pero para ello debe ser previamente
[instalado](https://maven.apache.org/install.html) en el sistema operativo.

## Maven en IntelliJ IDEA

Luego de [crear un proyecto con
Maven](/entorno/tutorial-hola-mundo),
ya tenemos un archivo `pom.xml`, y tenemos disponible la pestaña Maven (**View
→ Tool windows → Maven**).

Algunas acciones comunes que se pueden realizar con Maven:

- [Agregar una dependencia](https://www.jetbrains.com/help/idea/work-with-maven-dependencies.html#generate_maven_dependency) (por ejemplo Junit4 o JavaFX).
- [Ejecutar un objetivo](https://www.jetbrains.com/help/idea/work-with-maven-goals.html#run_goal) (por ejemplo `mvn package` para generar un archivo ejecutable)
- [Configurar la versión del compilador de Java](https://www.jetbrains.com/help/idea/troubleshooting-common-maven-issues.html#maven_compiler_problem)

