/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 29/11/2014 20:30
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import flash.events.Event;

public class TestsStartedEvent extends Event {

    public static const STARTED:String = "TestsStartedEvent::STARTED";

    public function TestsStartedEvent() {
        super(STARTED);
    }

    override public function clone():Event {
        return new TestsStartedEvent();
    }

    override public function toString():String {
        return formatToString("TestsStartedEvent", "type", "bubbles", "cancelable");
    }
}
}
