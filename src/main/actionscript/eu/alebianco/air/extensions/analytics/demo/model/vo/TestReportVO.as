/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 09/11/2014 10:03
 */
package eu.alebianco.air.extensions.analytics.demo.model.vo {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;

import mx.resources.IResourceManager;

import mx.utils.StringUtil;

public class TestReportVO {

    [Inject]
    public var resource:IResourceManager;

    private var _test:Test;
    private var _finished:Boolean;
    private var _success:Boolean;
    private var _feedback:String;
    private var _finishedAt:Date;
    private var _startedAt:Date;

    public function get test():Test {
        return _test;
    }

    public function get finished():Boolean {
        return _finished;
    }

    public function get success():Boolean {
        return _success;
    }

    public function get feedback():String {
        return _feedback;
    }

    public function get startedAt():Date {
        return _startedAt;
    }

    public function get duration():int {
        return int((_finishedAt.getTime()-_startedAt.getTime()) / 1000);
    }

    public function TestReportVO(test:Test) {
        this._test = test;
        this._startedAt = new Date();
    }

    public function complete(success:Boolean, message:String = "", data:Array = null):void {
        if (!finished) {
            this._finished = true;
            this._success = success;
            this._finishedAt = new Date();
            this._feedback = localiseFeedback(test, success, message, data);
        }
    }

    private function localiseFeedback(test:Test, success:Boolean, message:String = "", data:Array = null):String {
        var feedback:String = StringUtil.trim(message);
        if (feedback == "") {
            feedback = test.name.replace(".name", success ? ".success" : ".failure");
        }
        return resource.getString("resources", feedback, data);
    }
}
}
