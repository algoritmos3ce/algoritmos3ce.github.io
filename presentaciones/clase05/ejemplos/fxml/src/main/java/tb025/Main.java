package tb025;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Main extends Application {
    @Override
    public void start(Stage stage) throws Exception {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/Ejemplo.fxml"));
        Parent root = loader.load();

        var scene = new Scene(root, 640, 480);
        stage.setScene(scene);
        stage.show();
    }
}