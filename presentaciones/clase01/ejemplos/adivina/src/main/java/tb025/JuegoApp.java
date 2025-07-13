package tb025;

import java.util.Scanner;

public class JuegoApp {
    public static final int MAX_NUMERO = 100;
    public static final int MAX_INTENTOS = 5;

    private final Scanner scanner;
    private final Juego juego;

    public JuegoApp(Scanner scanner) {
        this.scanner = scanner;
        this.juego = new Juego(MAX_NUMERO, MAX_INTENTOS);
    }

    public void jugar() {
        System.out.printf(
            "Adivina el número secreto entre 1 and %d." +
            "Tienes %d intentos.%n\n",
            MAX_NUMERO,
            MAX_INTENTOS
        );
        while (juego.getIntentos() > 0) {
            System.out.printf("Quedan %d intentos.\n", juego.getIntentos());
            System.out.print("Adivina el numero: ");
            int n = scanner.nextInt();

            Resultado r = juego.intentar(n);
            System.out.println(r.mensaje);
            if (r.esCorrecto) {
                break;
            }
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        JuegoApp app = new JuegoApp(scanner);
        app.jugar();
    }
}
