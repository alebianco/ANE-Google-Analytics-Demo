/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 15:32
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;

import flash.events.Event;

public class ExecuteTestSuiteEvent extends Event {

    public static var RUN:String = "ExecuteTestSuiteEvent::RUN";

    private var _suite:TestSuite;

    public function get suite():TestSuite {
        return _suite;
    }

    public function ExecuteTestSuiteEvent(suite:TestSuite) {
        super(RUN)
        _suite = suite;
    }

    override public function clone():Event {
        return new ExecuteTestSuiteEvent(_suite);
    }

    override public function toString():String {
        return formatToString("ExecuteTestSuiteEvent", "type", "bubbles", "cancelable", "_suite")
    }
}
}
