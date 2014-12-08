/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:52
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.events.SelectedReportEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;

import flash.events.IEventDispatcher;

import robotlegs.bender.bundles.mvcs.Command;

public class DisplayReport extends Command {

    [Inject]
    public var dispatcher:IEventDispatcher;

    [Inject]
    public var session:SessionStorage;

    [Inject]
    public var event:SelectedReportEvent;

    override public function execute():void {
        session.setItem("report", event.report);
        dispatcher.dispatchEvent(new NavigateEvent(DemoScreen.REPORT_DETAILS));
    }
}
}
