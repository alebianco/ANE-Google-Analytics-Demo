/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 16:57
 */
package eu.alebianco.air.extensions.analytics.demo.commands.tests {
import eu.alebianco.air.extensions.analytics.demo.events.TestReportUpdateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;
import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

import flash.events.IEventDispatcher;

import robotlegs.bender.framework.api.IInjector;

public class AbstractTest extends AsyncCommand {

    [Inject]
    public var injector:IInjector;

    [Inject]
    public var dispatcher:IEventDispatcher;

    [Inject]
    public var suite:TestSuite;

    [Inject]
    public var test:Test;

    [Inject]
    public var session:SessionStorage;

    private var reportData:TestReportVO;
    private var reportList:Vector.<TestReportVO>;

    override public function execute():void {
        reportData = new TestReportVO(test);
        injector.injectInto(reportData);

        reportList = session.getItem("reports") as Vector.<TestReportVO>
        reportList.push(reportData);

        dispatcher.dispatchEvent(new TestReportUpdateEvent(reportData));
    }

    public function report(success:Boolean, message:String = "", ...data):void {
        reportData.complete(success, message, data);
        dispatcher.dispatchEvent(new TestReportUpdateEvent(reportData));
        dispatchComplete(true);
    }

    public function verify(...data):void {
        report(false, "error.test.verifier.missing", test.name);
    }


}
}
