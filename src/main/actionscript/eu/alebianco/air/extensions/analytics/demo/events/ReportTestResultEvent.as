/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 17:15
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestResultVO;

import flash.events.Event;

public class ReportTestResultEvent extends Event {

    public static const REPORT:String = "ReportTestResultEvent::REPORT";

    private var _result:TestResultVO;

    public function get result():TestResultVO {
        return _result;
    }

    public function ReportTestResultEvent(result:TestResultVO) {
        super(REPORT);
        _result = result;
    }

    override public function clone():Event {
        return new ReportTestResultEvent(result);
    }

    override public function toString():String {
        return formatToString("ReportTestResultEvent", "type", "bubbles", "cancelable", "result")
    }
}
}
