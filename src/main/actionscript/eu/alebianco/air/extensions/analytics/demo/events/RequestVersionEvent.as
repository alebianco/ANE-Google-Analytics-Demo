/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 10:23
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import flash.events.Event;

public class RequestVersionEvent extends Event {

    public static var GET:String = "GetVersionEvent::GET";

    public function RequestVersionEvent() {
        super(GET);
    }

    override public function clone():Event {
        return new RequestVersionEvent();
    }

    override public function toString():String {
        return formatToString("RequestVersionEvent", "type", "bubbles", "cancelable")
    }
}
}
