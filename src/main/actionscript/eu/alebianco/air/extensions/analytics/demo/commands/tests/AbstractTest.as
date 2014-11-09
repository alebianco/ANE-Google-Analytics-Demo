/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 16:57
 */
package eu.alebianco.air.extensions.analytics.demo.commands.tests {
import eu.alebianco.air.extensions.analytics.demo.events.ReportTestResultEvent;
import eu.alebianco.air.extensions.analytics.demo.events.ReportTestStartEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestResultVO;
import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

import flash.events.IEventDispatcher;

public class AbstractTest extends AsyncCommand {

    [Inject]
    public var dispatcher:IEventDispatcher;

    [Inject]
    public var suite:TestSuite;

    [Inject]
    public var test:Test;

    [Inject]
    public var session:SessionStorage;

    private var result:TestResultVO;
    private var provider:Vector.<TestResultVO>;

    override public function execute():void {
        result = new TestResultVO(test);
        provider = session.getItem("reports") as Vector.<TestResultVO>
        provider.push(result);

        dispatcher.dispatchEvent(new ReportTestStartEvent(result));
    }

    public function report(success:Boolean, message:String = "", ...data):void {
        result.complete(success, message, data);
        dispatcher.dispatchEvent(new ReportTestResultEvent(result));
        dispatchComplete(true);
    }

    public function verify(...data):void {
        report(false, "error.test.verifier.not.implemented", test.name);
    }


}
}
