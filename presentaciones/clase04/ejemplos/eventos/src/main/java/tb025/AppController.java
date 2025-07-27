package tb025;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;

import java.net.URL;
import java.util.ResourceBundle;

public class AppController implements Initializable {
    @FXML private VBox rootPane;
    @FXML private VBox container;
    @FXML private Button button;
    @FXML private TextArea output;

    @Override public void initialize(URL url, ResourceBundle resourceBundle) {
        rootPane.addEventFilter(MouseEvent.MOUSE_CLICKED, this::handleClick);
        container.addEventFilter(MouseEvent.MOUSE_CLICKED, this::handleClick);
        button.addEventHandler(MouseEvent.MOUSE_CLICKED, this::handleClick);
    }

    private void handleClick(MouseEvent event) {
        Object source = event.getSource();
        String sourceName = source.getClass().getSimpleName();
        output.appendText(String.format("You clicked on a %s element\n", sourceName));
    }
}