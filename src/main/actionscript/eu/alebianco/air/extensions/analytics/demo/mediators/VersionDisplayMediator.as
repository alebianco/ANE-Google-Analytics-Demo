/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.RequestVersionEvent;
import eu.alebianco.air.extensions.analytics.demo.events.UpdateVersionEvent;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayVersion;

import robotlegs.bender.bundles.mvcs.Mediator;

public class VersionDisplayMediator extends Mediator {

    [Inject]
    public var view:IDisplayVersion;

    override public function initialize():void {
        super.initialize();

        addContextListener(UpdateVersionEvent.UPDATE, onVersionUpdated, UpdateVersionEvent);
        dispatch(new RequestVersionEvent());
    }

    private function onVersionUpdated(event:UpdateVersionEvent):void {
        view.updateVersion(event.version);
    }
}
}
