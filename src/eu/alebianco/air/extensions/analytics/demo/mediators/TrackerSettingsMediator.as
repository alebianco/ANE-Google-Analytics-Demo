/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/06/2013 10:51
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.demo.views.api.IManageTrackerSettings;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TrackerSettingsMediator extends Mediator {

    [Inject]
    public var view:IManageTrackerSettings;

    [Inject]
    public var tracker:ITracker;

    override public function initialize():void {
        super.initialize();
//        view.anonymous = tracker.anonymous;
//        view.sampleRate = tracker.sampleRate;
//        view.secure = tracker.secure;
//        view.sessionTimeout = tracker.sessionTimeout;
//
//        view.changed.add(onChanged);
    }

    private function onChanged():void {
//        tracker.anonymous = view.anonymous;
//        tracker.sampleRate = view.sampleRate;
//        tracker.secure = view.secure;
//        tracker.sessionTimeout = view.sessionTimeout;
    }

    override public function destroy():void {
        super.destroy();
        view.changed.remove(onChanged);
    }
}
}
