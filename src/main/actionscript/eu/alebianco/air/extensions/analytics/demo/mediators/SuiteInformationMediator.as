/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.ReportSuiteStartEvent;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SuiteInformationMediator extends Mediator {

    [Inject]
    public var view:IDisplaySuiteInformation;

    override public function initialize():void {
        super.initialize();
        addContextListener(ReportSuiteStartEvent.START, onSuiteStart, ReportSuiteStartEvent);
    }

    private function onSuiteStart(event:ReportSuiteStartEvent):void {
        view.showDetails(event.suite);
    }
}
}
