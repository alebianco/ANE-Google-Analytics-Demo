/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 09/11/2014 10:03
 */
package eu.alebianco.air.extensions.analytics.demo.model.vo {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;

public class TestReportVO {

    private var _test:Test;

    public function get test():Test {
        return _test;
    }

    private var _finished:Boolean;

    public function get finished():Boolean {
        return _finished;
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

    public function TestReportVO(test:Test) {
        this._test = test;
    }

    public function complete(success:Boolean, message:String = "", data:Array = null):void {
        this._finished = true;
        this._success = success;
        this._message = message;
        this._data = data;
    }
}
}
