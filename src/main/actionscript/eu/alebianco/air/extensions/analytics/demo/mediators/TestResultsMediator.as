/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.ReportTestResultEvent;
import eu.alebianco.air.extensions.analytics.demo.events.ReportTestStartEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestResultVO;
import eu.alebianco.air.extensions.analytics.demo.views.api.IReportTestResults;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TestResultsMediator extends Mediator {

    [Inject]
    public var view:IReportTestResults;

    [Inject]
    public var session:SessionStorage;

    override public function initialize():void {
        super.initialize();
        addContextListener(ReportTestResultEvent.REPORT, onReportReceived, ReportTestResultEvent);
        addContextListener(ReportTestStartEvent.START, onTestStarted, ReportTestStartEvent);

        view.selected.add(displayTestDetails);

        const list:Vector.<TestResultVO> = session.getItem("reports") as Vector.<TestResultVO>;
        list.forEach(function(item:TestResultVO, index:int, list:Vector.<TestResultVO>):void {
            view.updateResult(item);
        });
    }

    override public function destroy():void {
        super.destroy();

        view.selected.removeAll();
    }

    private function displayTestDetails(report:TestResultVO):void {
        trace("show report screen for", report.test.name);
    }

    private function onTestStarted(event:ReportTestStartEvent):void {
        view.updateResult(event.result);
    }

    private function onReportReceived(event:ReportTestResultEvent):void {
        view.updateResult(event.result);
    }
}
}
