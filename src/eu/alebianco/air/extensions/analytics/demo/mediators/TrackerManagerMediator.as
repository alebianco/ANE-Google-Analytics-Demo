/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 17/06/2013 12:00
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.views.api.IManageTracker;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TrackerManagerMediator extends Mediator {

    [Inject]
    public var view:IManageTracker;

    [Inject]
    public var tracker:ITracker;

    override public function initialize():void {
        super.initialize();
        /*
         tracker.buildView()
         tracker.buildEvent()
         tracker.buildTiming()
         tracker.buildSocial()
         tracker.buildException()
         tracker.buildTransaction()

         tracker.setCustomDimension()
         tracker.setCustomMetric()
         tracker.clearCustomDimension()
         tracker.clearCustomMetric()

         tracker.startNewSession()
         */
        view.disconnectTriggered.add(onDisconnect);
    }

    private function onDisconnect():void {
        dispatch(new NavigateEvent(DemoScreen.HOME));
    }

    override public function destroy():void {
        super.destroy();
        view.disconnectTriggered.remove(onDisconnect);
    }
}
}
