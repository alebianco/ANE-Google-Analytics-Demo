/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 11/11/2014 14:52
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;

import flash.events.Event;

public class ShowReportDataEvent extends Event {

    public static var SHOW:String = "ShowReportDataEvent::SHOW";

    private var _report:TestReportVO;

    public function get report():TestReportVO {
        return _report;
    }

    public function ShowReportDataEvent(report:TestReportVO) {
        super(SHOW);
        _report = report;
    }

    override public function clone():Event {
        return new ShowReportDataEvent(_report);
    }

    override public function toString():String {
        return formatToString("ShowReportDataEvent", "type", "bubbles", "cancelable", "report")
    }
}
}
