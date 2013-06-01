/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:08
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {

import eu.alebianco.air.extensions.analytics.api.IAnalytics;
import eu.alebianco.air.extensions.analytics.demo.views.UnsupportedScreen;

import robotlegs.bender.bundles.mvcs.Mediator;

public class UnsupportedMediator extends Mediator {

    [Inject]
    public var view:UnsupportedScreen;

    [Inject]
    public var analytics:IAnalytics;

    override public function initialize():void {
        super.initialize();
	    view.version = analytics.version;
    }
}
}
