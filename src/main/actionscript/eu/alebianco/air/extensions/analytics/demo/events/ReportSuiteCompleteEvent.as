/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 17:15
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;

import flash.events.Event;

public class ReportSuiteCompleteEvent extends Event {

    public static const COMPLETE:String = "ReportSuiteCompleteEvent::COMPLETE";

    private var _suite:TestSuite;

    public function get suite():TestSuite {
        return _suite;
    }

    public function ReportSuiteCompleteEvent(suite:TestSuite) {
        super(COMPLETE);
        _suite = suite;
    }

    override public function clone():Event {
        return new ReportSuiteCompleteEvent(suite);
    }

    override public function toString():String {
        return formatToString("ReportSuiteCompleteEvent", "type", "bubbles", "cancelable", "suite")
    }
}
}
