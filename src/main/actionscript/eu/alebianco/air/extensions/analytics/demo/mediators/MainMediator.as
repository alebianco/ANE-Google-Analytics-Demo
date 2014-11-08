/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:12
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.AnalyticsDemo;

import feathers.controls.ScreenNavigator;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MainMediator extends Mediator {

    [Inject]
    public var view:AnalyticsDemo;

    [Inject]
    public var navigator:ScreenNavigator;

    override public function initialize():void {
        super.initialize();
        view.addChild(navigator);
    }
}
}
