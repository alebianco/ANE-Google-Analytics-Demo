/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 17:15
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;

import flash.events.Event;

public class ReportSuiteStartEvent extends Event {

    public static const START:String = "ReportSuiteStartEvent::START";

    private var _suite:TestSuite;

    public function get suite():TestSuite {
        return _suite;
    }

    public function ReportSuiteStartEvent(suite:TestSuite) {
        super(START);
        _suite = suite;
    }

    override public function clone():Event {
        return new ReportSuiteStartEvent(suite);
    }

    override public function toString():String {
        return formatToString("ReportSuiteStartEvent", "type", "bubbles", "cancelable", "suite")
    }
}
}
