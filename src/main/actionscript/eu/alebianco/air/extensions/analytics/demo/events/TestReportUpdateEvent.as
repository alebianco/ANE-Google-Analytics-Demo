/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 17:15
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;

import flash.events.Event;

public class TestReportUpdateEvent extends Event {

    public static const UPDATE:String = "TestReportUpdateEvent::UPDATE";

    private var _report:TestReportVO;

    public function get report():TestReportVO {
        return _report;
    }

    public function TestReportUpdateEvent(report:TestReportVO) {
        super(UPDATE);
        _report = report;
    }

    override public function clone():Event {
        return new TestReportUpdateEvent(report);
    }

    override public function toString():String {
        return formatToString("TestReportUpdateEvent", "type", "bubbles", "cancelable", "report")
    }
}
}
