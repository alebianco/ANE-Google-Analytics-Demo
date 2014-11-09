/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 10:25
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.Analytics;
import eu.alebianco.air.extensions.analytics.demo.events.UpdateVersionEvent;

import flash.events.IEventDispatcher;

import robotlegs.bender.bundles.mvcs.Command;

public class GetVersion extends Command {

    [Inject]
    public var dispatcher:IEventDispatcher;

    override public function execute():void {
        const version:String = Analytics.getInstance().version;
        dispatcher.dispatchEvent(new UpdateVersionEvent(version));
    }
}
}
