/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:21
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;

import flash.events.Event;

public class NavigateEvent extends Event {

    public static const TO:String = "NavigateEvent::TO";

    private var _screen:DemoScreen;

    public function get screen():DemoScreen {
        return _screen;
    }

    public function NavigateEvent(screen:DemoScreen, bubbles:Boolean = false, cancelable:Boolean = true) {
        super(TO, bubbles, cancelable);

        this._screen = screen;
    }

    override public function clone():Event {
        return new NavigateEvent(_screen, this.bubbles, this.cancelable);
    }

    override public function toString():String {
        return formatToString("NavigateEvent", "type", "bubbles", "cancelable", "screen")
    }
}
}
