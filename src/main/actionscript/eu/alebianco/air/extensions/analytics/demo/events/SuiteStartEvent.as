/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 17:15
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;

import flash.events.Event;

public class SuiteStartEvent extends Event {

    public static const START:String = "SuiteStartEvent::START";

    private var _suite:TestSuite;

    public function get suite():TestSuite {
        return _suite;
    }

    public function SuiteStartEvent(suite:TestSuite) {
        super(START);
        _suite = suite;
    }

    override public function clone():Event {
        return new SuiteStartEvent(suite);
    }

    override public function toString():String {
        return formatToString("SuiteStartEvent", "type", "bubbles", "cancelable", "suite")
    }
}
}
