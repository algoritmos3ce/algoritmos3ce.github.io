package tb025;

import java.util.Random;

public class Juego {
    private final int numeroSecreto;
    private int intentos;

    public Juego(int maxNumero, int maxIntentos) {
        this.intentos = maxIntentos;
        Random rand = new Random();
        this.numeroSecreto = rand.nextInt(maxNumero) + 1;
    }

    public int getIntentos() {
        return intentos;
    }

    public Resultado intentar(int n) {
        assert this.intentos > 0;
        this.intentos--;

        if (n < this.numeroSecreto) {
            return new Resultado(false, "Muy chico!");
        } else if (n > this.numeroSecreto) {
            return new Resultado(false, "Muy grande!");
        } else {
            return new Resultado(true, "Acertaste!");
        }
    }
}
