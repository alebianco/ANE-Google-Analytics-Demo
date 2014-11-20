/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 11/11/2014 14:45
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayReportDetails;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ReportDetailsMediator extends Mediator {

    [Inject]
    public var view:IDisplayReportDetails;

    override public function initialize():void {
        super.initialize();
    }
}
}
