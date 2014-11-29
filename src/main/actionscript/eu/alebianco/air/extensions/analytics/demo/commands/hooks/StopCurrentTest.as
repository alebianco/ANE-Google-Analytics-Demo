/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 29/11/2014 20:50
 */
package eu.alebianco.air.extensions.analytics.demo.commands.hooks {
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;

import org.flexunit.runner.FlexUnitCore;

import robotlegs.bender.framework.api.IHook;

public class StopCurrentTest implements IHook {

    [Inject]
    public var event:NavigateEvent;

    [Inject]
    public var runner:FlexUnitCore;

    public function hook():void {
        // only if going back home. should also check from which screen it's coming
        if (event.screen == DemoScreen.SUITES_LIST) {
            runner.pleaseStop();
        }
    }
}
}
