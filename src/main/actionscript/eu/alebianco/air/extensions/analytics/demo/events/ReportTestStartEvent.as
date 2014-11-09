/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 17:15
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;

import flash.events.Event;

public class ReportTestStartEvent extends Event {

    public static const START:String = "ReportTestStartEvent::START";

    private var _test:Test;

    public function get test():Test {
        return _test;
    }

    public function ReportTestStartEvent(test:Test) {
        super(START);
        _test = test;
    }

    override public function clone():Event {
        return new ReportTestStartEvent(test);
    }

    override public function toString():String {
        return formatToString("ReportTestStartEvent", "type", "bubbles", "cancelable", "test")
    }
}
}
