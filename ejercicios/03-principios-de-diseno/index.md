---
title: "3. Principios de diseño"
layout: default
parent: Ejercicios
nav_order: 3
---

# Principios de diseño
{: .no_toc }

## Índice
{: .no_toc .text-delta }

1. Índice
{:toc}

{: .ejercicio }
## Auto

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
public class Auto {
    private boolean moviendo;

    public void mover() {
        moviendo = !moviendo;
    }

    public boolean enMovimiento() {
        return moviendo;
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/Auto/Solucion.md)

{: .ejercicio }
## Carrito de compras

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
public class CarritoDeCompras {
    private List<Item> items;

    public List<Item> getItems() {
        return items;
    }
}

public class ServicioWeb {
    public agregarAlCarrito(CarritoDeCompras carrito, Item item) {
        carrito.getItems().add(item);
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/Carrito/Solucion.md)

{: .ejercicio }
## Cubo

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
public class Rectangulo {
    private int ancho;
    private int alto;

    public Rectangulo(int ancho, int alto) {
        this.ancho = ancho;
        this.alto = alto;
    }

    public int getArea() {
        return ancho * alto;
    }
}

public class Cuboide extends Rectangulo {
    private int profundidad;

    public Cuboid(int ancho, int alto, int profundidad) {
        super(ancho, alto);
        this.profundidad = profundidad;
    }

    public int getVolumen() {
        return ancho * alto * profundidad;
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/Cubo/Solucion.md)

{: .ejercicio }
## Cuenta bancaria

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
public class CuentaBancaria {
    private int saldo;

    public void depositar(int cantidad) {
        saldo += cantidad;
    }

    public void retirar(int cantidad) {
        saldo -= cantidad;
    }

    public int obtenerSaldo() {
        return saldo;
    }
}

public class CajeroAutomatico {
    private CuentaBancaria cuenta;

    public void retirarDinero(int cantidad) {
        if (cuenta.obtenerSaldo() >= cantidad) {
            cuenta.retirar(cantidad);
            System.out.println(cantidad + " retirados exitosamente.");
        } else {
            System.out.println("Fondos insuficientes.");
        }
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/CuentaBancaria/Solucion.md)

{: .ejercicio }
## Empleado

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
public class Empleado {
    private String nombre;
    private String apellido;
    private int edad;

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public int getEdad() {
        return edad;
    }

    public String getNombreCompleto() {
        return nombre + " " + apellido;
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/Empleado/Solucion.md)

{: .ejercicio }
## Producto

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
public class Producto {
    private String nombre;
    private double price;
    private String tipo;

    public Producto(String nombre, double precio, String tipo) {
        this.nombre = nombre;
        this.precio = precio;
        this.tipo = tipo;
    }

    public double calcularPrecio() {
        if (tipo.equals("electrónica")) {
            return precio * 1.1;  // agregar impuesto de 10%
        } else if (tipo.equals("ropa")) {
            return precio * 1.2;  // agregar impuesto de 20%
        } else {
            return precio;
        }
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/Producto/Solucion.md)

{: .ejercicio }
## Rectangulo y cuadrado

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
public class Rectangulo {
    private int ancho;
    private int alto;

    public Rectangulo(int ancho, int alto) {
        this.ancho = ancho;
        this.alto = alto;
    }

    public int getAncho() {
        return ancho;
    }

    public int getAlto() {
        return alto;
    }

    public void setAncho(int ancho) {
        this.ancho = ancho;
    }

    public void setAlto(int alto) {
        this.alto = alto;
    }

    public int calcularArea() {
        return ancho * alto;
    }
}

public class Cuadrado extends Rectangulo {
    public Cuadrado(int lado) {
        super(lado, lado);
    }

    @Override
    public void setAncho(int ancho) {
        super.setAncho(ancho);
        super.setAlto(ancho);
    }

    @Override
    public void setAlto(int alto) {
        super.setAncho(alto);
        super.setAlto(alto);
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/RectanguloYCuadrado/Solucion.md)

{: .ejercicio }
## Suma

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
public class SumaDeNumeros {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Ingrese una lista de números separados por espacios: ");
        String input = scanner.nextLine();

        List<Integer> nums = new ArrayList<>();
        for (String s : input.split(" ")) {
            nums.add(Integer.parseInt(s));
        }

        System.out.println("La suma es: " + sumar(nums));
    }

    private static int sumar(List<Integer> nums) {
        // convertimos los Integer a `int` para hacer la suma más rápido.
        int[] arr = new int[nums.size()];
        // usamos el for clásico en lugar de `for (Integer n : nums)` porque es
        // más eficiente
        for(int i = 0; i < arr.length; i++) {
            arr[i] = nums.get(i).intValue();
        }

        // hacemos esta operación en un ciclo separado para favorecer la
        // localidad del cache del procesador:
        int suma = 0;
        for (int i = 0; i < arr.length; i++) {
            suma += nums.get(i);
        }
        return suma;
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/Suma/Solucion.md)

{: .ejercicio }
## Usuario

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

``` java
class Usuario {
    private String nombre;
    private String email;
    private String password;

    public Usuario(String nombre, String email, String password) {
        this.nombre = nombre;
        this.email = email;
        this.password = password;
    }

    public void guardar() {
        // código para guardar el usuario en la base de datos
    }

    public void enviarEmailBianvenida() {
        // código para enviar un email de bienvenida al usuario
    }

    public void cambiarPassword(String nuevoPassword) {
        // código para cambiar la contraseña
    }

    public void delete() {
        // código para eliminar el usuario de la base de datos
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/Usuario/Solucion.md)

{: .ejercicio }
## Usuario 2

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
class Usuario {
    private String nombre;
    private String email;
    private BaseDeDatos db;

    public Usuario(String nombre, String email) {
        this.nombre = nombre;
        this.email = email;
        this.db = new BaseDeDatos();
    }

    public void guardar() {
        this.db.guardar(this);
    }
}

class BaseDeDatos {
    public static void guadar(Usuario user) {
        // código para guardar el usuario en la base de datos
    }
}
```

[Solución](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/Usuario2/Solucion.md)

{: .ejercicio }
## Vehiculo

Dado el siguiente código, identificar qué principios se violan y proponer un diseño alternativo.

```java
interface Vehiculo {
    void arrancarMotor();
    void pararMotor();
    void acelerar();
    void frenar();
    void cambiarMarcha();
    void encenderFaros();
    void apagarFaros();
    void encenderRadio();
    void apagarRadio();
}

class Coche implements Vehiculo {
    public void arrancarMotor() {
        // código para arrancar el motor
    }

    public void pararMotor() {
        // código para parar el motor
    }

    public void acelerar() {
        // código para acelerar el coche
    }

    public void frenar() {
        // código para aplicar los frenos
    }

    public void cambiarMarcha() {
        // código para cambiar las marchas
    }

    public void encenderFaros() {
        // código para encender los faros
    }

    public void apagarFaros() {
        // código para apagar los faros
    }

    public void encenderRadio() {
        // código para encender la radio
    }

    public void apagarRadio() {
        // código para apagar la radio
    }
}

class Bicicleta implements Vehiculo {
    public void arrancarMotor() {
        // lanzar una excepción, ya que las bicicletas no tienen motor
    }

    public void pararMotor() {
        // lanzar una excepción, ya que las bicicletas no tienen motor
    }

    public void acelerar() {
        // código para acelerar la bicicleta
    }

    public void frenar() {
        // código para aplicar los frenos
    }

    public void cambiarMarcha() {
        // código para cambiar las marchas
    }

    public void encenderFaros() {
        // código para encender los faros
    }

    public void apagarFaros() {
        // código para apagar los faros
    }

    public void encenderRadio() {
        // lanzar una excepción, ya que las bicicletas no tienen radio
    }

    public void apagarRadio() {
        // lanzar una excepción, ya que las bicicletas no tienen radio
    }
}
```

[Solucion](https://github.com/algoritmos3ce/Ejercicios/blob/main/src/main/java/PrincipiosDeDise%C3%B1o/Vehiculo/Solucion.md)
