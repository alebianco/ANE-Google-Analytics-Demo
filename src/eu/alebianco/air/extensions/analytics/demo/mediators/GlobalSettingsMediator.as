/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:20
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {

import eu.alebianco.air.extensions.analytics.api.IAnalytics;
import eu.alebianco.air.extensions.analytics.demo.views.api.IManageGlobalSettings;

import robotlegs.bender.bundles.mvcs.Mediator;

public class GlobalSettingsMediator extends Mediator {

    [Inject]
    public var view:IManageGlobalSettings;

    [Inject]
    public var analytics:IAnalytics;

    override public function initialize():void {
        super.initialize();

        view.debug = analytics.debug;
        view.dispatchManually = analytics.dispatchManually;
        view.dispatchInterval = analytics.dispatchInterval;
        view.optOut = analytics.optOut;

        view.changed.add(onChanged);
    }

    private function onChanged():void {
        analytics.debug = view.debug;
        analytics.dispatchManually = view.dispatchManually;
        analytics.dispatchInterval = view.dispatchInterval;
        analytics.optOut = view.optOut;
    }

    override public function destroy():void {
        super.destroy();
        view.changed.remove(onChanged);
    }
}
}
