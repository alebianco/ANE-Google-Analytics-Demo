/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:20
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {

import eu.alebianco.air.extensions.analytics.demo.views.SettingsScreen;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SettingsMediator extends Mediator {

    [Inject]
    public var view:SettingsScreen;

    override public function initialize():void {
        super.initialize();
    }

    override public function destroy():void {
        super.destroy();
    }
}
}
