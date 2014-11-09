/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 09/11/2014 18:38
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;

import flash.events.Event;

public class DisplayReportDetailsEvent extends Event {

    public static var SHOW:String = "DisplayReportDetailsEvent::SHOW";

    private var _report:TestReportVO;

    public function get report():TestReportVO {
        return _report;
    }

    public function DisplayReportDetailsEvent(report:TestReportVO) {
        super(SHOW);
        _report = report;
    }

    override public function clone():Event {
        return new DisplayReportDetailsEvent(report);
    }

    override public function toString():String {
        return formatToString("DisplayReportDetailsEvent", "type", "cancelable", "bubble", "report");
    }
}
}
