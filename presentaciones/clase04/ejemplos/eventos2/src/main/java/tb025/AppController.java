package tb025;

import javafx.animation.Animation;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TextArea;
import javafx.scene.layout.VBox;
import javafx.util.Duration;

import java.net.URL;
import java.util.ResourceBundle;

public class AppController implements Initializable {
    @FXML private VBox rootPane;
    @FXML private TextArea output;

    @Override public void initialize(URL url, ResourceBundle resourceBundle) {
        Timeline tl = new Timeline(
                new KeyFrame(
                        Duration.seconds(1),
                        new EventHandler<ActionEvent>() {
                            @Override
                            public void handle(ActionEvent actionEvent) {
                                rootPane.fireEvent(new MyEvent());
                            }
                        }
                )
        );
        tl.setCycleCount(Animation.INDEFINITE);
        tl.play();

        rootPane.addEventHandler(MyEvent.EVENT_TYPE, new EventHandler<MyEvent>() {
            @Override
            public void handle(MyEvent event) {
                output.appendText("Got MyEvent!\n");
            }
        });
    }
}