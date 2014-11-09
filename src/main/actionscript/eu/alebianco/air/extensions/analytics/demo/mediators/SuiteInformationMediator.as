/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.ReportSuiteCompleteEvent;
import eu.alebianco.air.extensions.analytics.demo.events.ReportSuiteStartEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SuiteInformationMediator extends Mediator {

    [Inject]
    public var view:IDisplaySuiteInformation;

    [Inject]
    public var session:SessionStorage;

    override public function initialize():void {
        super.initialize();
        addContextListener(ReportSuiteStartEvent.START, onSuiteStart, ReportSuiteStartEvent);
        addContextListener(ReportSuiteCompleteEvent.COMPLETE, onSuiteComplete, ReportSuiteCompleteEvent);

        const suite:TestSuite = session.getItem("current") as TestSuite;
        view.showDetails(suite);
    }

    private function onSuiteStart(event:ReportSuiteStartEvent):void {
        view.showDetails(event.suite);
    }

    private function onSuiteComplete(event:ReportSuiteCompleteEvent):void {
        view.enableTestInspection();
    }
}
}
