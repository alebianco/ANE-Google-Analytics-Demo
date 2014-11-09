/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.commands.ReportSuiteComplete;
import eu.alebianco.air.extensions.analytics.demo.events.ReportSuiteCompleteEvent;
import eu.alebianco.air.extensions.analytics.demo.events.ReportSuiteStartEvent;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SuiteInformationMediator extends Mediator {

    [Inject]
    public var view:IDisplaySuiteInformation;

    override public function initialize():void {
        super.initialize();
        addContextListener(ReportSuiteStartEvent.START, onSuiteStart, ReportSuiteStartEvent);
        addContextListener(ReportSuiteCompleteEvent.COMPLETE, onSuiteComplete, ReportSuiteCompleteEvent);
    }

    private function onSuiteStart(event:ReportSuiteStartEvent):void {
        view.showDetails(event.suite);
    }

    private function onSuiteComplete(event:ReportSuiteCompleteEvent):void {
        view.enableTestInspection();
    }
}
}
