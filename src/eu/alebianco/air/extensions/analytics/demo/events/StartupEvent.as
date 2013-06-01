/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:44
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import flash.events.Event;

public class StartupEvent extends Event {
    public static const STARTUP:String = "StartupEvent::STARTUP"

    public function StartupEvent(bubbles:Boolean = false, cancelable:Boolean = false) {
        super(STARTUP, bubbles, cancelable);
    }

    override public function clone():Event {
        return new StartupEvent(this.bubbles, this.cancelable);
    }

    override public function toString():String {
        return formatToString("StartupEvent", "type", "bubbles", "cancelable");
    }
}
}
