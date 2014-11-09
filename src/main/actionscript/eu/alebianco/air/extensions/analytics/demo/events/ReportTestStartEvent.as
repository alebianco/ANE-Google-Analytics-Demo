/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 17:15
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestResultVO;

import flash.events.Event;

public class ReportTestStartEvent extends Event {

    public static const START:String = "ReportTestStartEvent::START";

    private var _result:TestResultVO;

    public function get result():TestResultVO {
        return _result;
    }

    public function ReportTestStartEvent(result:TestResultVO) {
        super(START);
        _result = result;
    }

    override public function clone():Event {
        return new ReportTestStartEvent(result);
    }

    override public function toString():String {
        return formatToString("ReportTestStartEvent", "type", "bubbles", "cancelable", "result")
    }
}
}
