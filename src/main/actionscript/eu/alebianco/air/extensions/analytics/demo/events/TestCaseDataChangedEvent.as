/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 29/11/2014 18:42
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import flash.events.Event;

public class TestCaseDataChangedEvent extends Event {

    public static const CHANGE:String = "TestCaseDataChangedEvent::CHANGE";

    public function TestCaseDataChangedEvent() {
        super(CHANGE);
    }

    override public function clone():Event {
        return new TestCaseDataChangedEvent();
    }

    override public function toString():String {
        return formatToString("TestCaseDataChangedEvent", "type", "bubbles", "cancelable");
    }
}
}
