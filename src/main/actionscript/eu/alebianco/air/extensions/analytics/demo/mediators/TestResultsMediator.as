/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.ReportTestResultEvent;
import eu.alebianco.air.extensions.analytics.demo.events.ReportTestStartEvent;
import eu.alebianco.air.extensions.analytics.demo.views.api.IReportTestResults;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TestResultsMediator extends Mediator {

    [Inject]
    public var view:IReportTestResults;

    override public function initialize():void {
        super.initialize();
        addContextListener(ReportTestResultEvent.REPORT, onReportReceived, ReportTestResultEvent);
        addContextListener(ReportTestStartEvent.START, onTestStarted, ReportTestStartEvent);
    }

    private function onTestStarted(event:ReportTestStartEvent):void {
        view.addTest(event.test);
    }

    private function onReportReceived(event:ReportTestResultEvent):void {
        view.updateResult(event.test, event.success, event.message, event.data);
    }
}
}
