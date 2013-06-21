/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 17/06/2013 12:37
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands.guards {
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;

import robotlegs.bender.framework.api.IGuard;

public class IsGoingBackHome implements IGuard {

    [Inject]
    public var event:NavigateEvent;

    public function approve():Boolean {
        return event.screen == DemoScreen.HOME;
    }
}
}
