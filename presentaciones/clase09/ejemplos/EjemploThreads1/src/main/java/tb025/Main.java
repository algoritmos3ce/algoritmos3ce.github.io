package tb025;

public class Main {
    static void mostrar(String mensaje) {
        System.out.format("%s: %s%n",
                Thread.currentThread().getName(),
                mensaje);
    }

    static void martinFierro() {
        String[] mensajes = {
                "Aquí me pongo a cantar",
                "Al compás de la vigüela",
                "Que al hombre que lo desvela",
                "Una pena estrordinaria,",
                "Como la ave solitaria",
                "Con el cantar se consuela."
        };
        try {
            for (String mensaje : mensajes) {
                Thread.sleep(4000);
                mostrar(mensaje);
            }
        } catch (InterruptedException e) {
            mostrar("No terminé!");
        }
    }

    public static void main(String[] args) throws InterruptedException {
        long paciencia = 10_000; // milisegundos

        mostrar("Lanzando el hilo");
        long inicio = System.currentTimeMillis();
        Thread t = new Thread(Main::martinFierro);
        t.start();

        mostrar("Esperando a que el hilo termine");
        while (t.isAlive()) {
            mostrar("Sigo esperando...");
            if ((System.currentTimeMillis() - inicio) > paciencia) {
                mostrar("Me cansé de esperar!");
                t.interrupt();
            }
            t.join(1000);
        }
        mostrar("Al fin!");
    }
}