/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 20/06/2013 15:09
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.api.Hit;
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.demo.events.TrackDataEvent;
import eu.alebianco.air.extensions.analytics.demo.views.api.ITrackViews;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TrackViewScreenMediator extends Mediator {

    private const SCREEN_NAME_VALIDATOR:RegExp = new RegExp('^.+$', 'i');

    [Inject]
    public var view:ITrackViews;

    [Inject]
    public var tracker:ITracker;

    override public function initialize():void {
        super.initialize();
        view.change.add(onChange);
        view.track.add(onTrack);
    }

    private function onChange():void {
        const isValid:Boolean = SCREEN_NAME_VALIDATOR.test(view.screenName);
        view.enabled = isValid;
    }

    private function onTrack():void {
        const hit:Hit = tracker.buildView(view.screenName).create();
        dispatch(new TrackDataEvent(hit))
    }

    override public function destroy():void {
        super.destroy();
        view.change.removeAll();
        view.track.removeAll();
    }
}
}
