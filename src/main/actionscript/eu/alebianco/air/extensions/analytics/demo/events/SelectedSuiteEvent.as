/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 15:32
 */
package eu.alebianco.air.extensions.analytics.demo.events {

import flash.events.Event;

public class SelectedSuiteEvent extends Event {

    public static var CHANGE:String = "SelectedSuiteEvent::CHANGE";

    private var _suite:Class;

    public function get suite():Class {
        return _suite;
    }

    public function SelectedSuiteEvent(suite:Class) {
        super(CHANGE);
        _suite = suite;
    }

    override public function clone():Event {
        return new SelectedSuiteEvent(_suite);
    }

    override public function toString():String {
        return formatToString("SelectedSuiteEvent", "type", "bubbles", "cancelable", "suite")
    }
}
}
