package tb025;

import javafx.event.Event;
import javafx.event.EventType;

class MyEvent extends Event {
    public static final EventType<MyEvent> EVENT_TYPE = new EventType<>("MyEvent");

    public MyEvent() {
        super(EVENT_TYPE);
    }
}
