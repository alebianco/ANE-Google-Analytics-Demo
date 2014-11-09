/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 17:15
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;

import flash.events.Event;

public class ReportTestResultEvent extends Event {

    public static const REPORT:String = "ReportTestResultEvent::REPORT";

    private var _test:Test;

    public function get test():Test {
        return _test;
    }

    private var _success:Boolean;

    public function get success():Boolean {
        return _success;
    }

    private var _message:String;

    public function get message():String {
        return _message;
    }

    private var _data:Array;

    public function get data():Array {
        return _data;
    }

    public function ReportTestResultEvent(test:Test, success:Boolean, message:String, data:Array) {
        super(REPORT);
        _test = test;
        _success = success;
        _message = message;
        _data = data;
    }

    override public function clone():Event {
        return new ReportTestResultEvent(test, success, message, data);
    }

    override public function toString():String {
        return formatToString("ReportTestResultEvent", "type", "bubbles", "cancelable", "test", "success")
    }
}
}
