/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 04/12/2014 15:52
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.TestCaseData;

import flash.events.Event;

public class SelectedReportEvent extends Event {

    public static var CHANGE:String = "SelectedReportEvent::CHANGE";

    private var _report:TestCaseData;

    public function get report():TestCaseData {
        return _report;
    }

    public function SelectedReportEvent(report:TestCaseData) {
        super(CHANGE);
        _report = report;
    }

    override public function clone():Event {
        return new SelectedReportEvent(_report);
    }

    override public function toString():String {
        return formatToString("SelectedReportEvent", "type", "bubbles", "cancelable", "report")
    }
}
}
