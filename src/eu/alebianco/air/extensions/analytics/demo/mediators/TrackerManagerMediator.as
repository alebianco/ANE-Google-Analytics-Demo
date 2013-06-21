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

        view.appID = tracker.appID;
        view.appName = tracker.appName;
        view.appVersion = tracker.appVersion;
        view.trackerID = tracker.trackingID;

        /*
         // Track a page view
         tracker.buildView("Home").track();

         // Track an event
         tracker.buildEvent("click", "button").withLabel("play").withValue(10).track();
         tracker.buildEvent("click", "button").withLabel("stop").track();
         tracker.buildEvent("swipe", "screen").withValue(1).track();
         tracker.buildEvent("app", "quit").track();

         // Track an exception
         tracker.buildException(false).withDescription("ok, an error occurred, but it wasn't that bad").track();
         tracker.buildException(true).withDescription("panic! this shit is hitting the fan!").track();
         tracker.buildException(false).track();

         // Track a timer
         tracker.buildTiming("loading", 5000).withName("resources").withLabel("audio.mp3").track();
         tracker.buildTiming("waiting", 1000).track();

         // Track a social interaction
         tracker.buildSocial("GooglePlus", "+1").forContent("http://alessandrobianco.eu").track();
         tracker.buildSocial("Facebook", "like").track();

         // Track an ecommerce transaction
         tracker.buildTransaction(new Date().getTime().toString(), 10.5)
         .withAffiliation("In-App Purchase")
         .withTaxCost(0.5)
         .createProduct("cr-300", "300 credits pack", 7, 1).inCategory("credits").add()
         .createProduct("it-156", "extra life item", 1.5, 2).add()
         .track();

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
