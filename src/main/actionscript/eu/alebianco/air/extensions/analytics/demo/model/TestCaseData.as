/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 29/11/2014 18:47
 */
package eu.alebianco.air.extensions.analytics.demo.model {
import org.flexunit.runner.IDescription;
import org.flexunit.runner.notification.Failure;
import org.osflash.signals.Signal;

public class TestCaseData {

    private var _description:IDescription;
    private var _complete:Boolean;
    private var _failure:Failure;
    private var _ignored:Boolean;
    private var _totalAssertions:uint;

    private var _completed:Signal;

    public function get completed():Signal {
        return _completed ||= new Signal();
    }

    public function TestCaseData(description:IDescription) {
        _complete = false;
        _description = description;
    }

    public function complete(failure:Failure, ignored:Boolean, totalAssertions:uint):void {
        _complete = true;
        _failure = failure;
        _ignored = ignored;
        _totalAssertions = totalAssertions;
        _completed.dispatch();
    }

    public function isComplete():Boolean {
        return _complete;
    }

    public function wasSuccessful():Boolean {
        return _failure == null;
    }

    public function wasIgnored():Boolean {
        return _ignored;
    }

    public function get description():IDescription {
        return _description;
    }

    public function get failure():Failure {
        return _failure;
    }

    public function get totalAssertions():uint {
        return _totalAssertions;
    }
}
}
