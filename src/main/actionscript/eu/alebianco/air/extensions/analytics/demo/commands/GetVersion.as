/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 10:25
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.Analytics;
import eu.alebianco.air.extensions.analytics.api.IAnalytics;
import eu.alebianco.air.extensions.analytics.demo.events.UpdateVersionEvent;

import flash.events.IEventDispatcher;

import robotlegs.bender.bundles.mvcs.Command;

public class GetVersion extends Command {

    [Inject]
    public var dispatcher:IEventDispatcher;

    [Inject(optional="true")]
    public var analytics:IAnalytics;

    override public function execute():void {
        if (!analytics) {
            analytics = Analytics.getInstance();
        }
        dispatcher.dispatchEvent(new UpdateVersionEvent(analytics.version));
    }
}
}
