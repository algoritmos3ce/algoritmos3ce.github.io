package tb025;

import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;

public class Ejemplo {
    @FXML
    public TextField nombre;
    @FXML
    public Button btnSaludar;

    public void initialize() {
        btnSaludar.setOnAction(_ -> {
            new Alert(
                    AlertType.INFORMATION,
                    "Hola " + nombre.getText()
            ).show();
        });
    }
}
