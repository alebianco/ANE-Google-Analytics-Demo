/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 29/11/2014 18:42
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import flash.events.Event;

public class TestsCompleteEvent extends Event {

    public static const COMPLETE:String = "TestsCompleteEvent::COMPLETE";

    public function TestsCompleteEvent() {
        super(COMPLETE);
    }

    override public function clone():Event {
        return new TestsCompleteEvent();
    }

    override public function toString():String {
        return formatToString("TestsCompleteEvent", "type", "bubbles", "cancelable");
    }
}
}
