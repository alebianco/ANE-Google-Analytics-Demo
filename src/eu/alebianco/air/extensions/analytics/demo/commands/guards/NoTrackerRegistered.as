/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 06/06/2013 11:47
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands.guards {
import eu.alebianco.air.extensions.analytics.api.ITracker;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IGuard;

public class NoTrackerRegistered implements IGuard {

    [Inject]
    public var injector:Injector;

    public function approve():Boolean {
        return !injector.hasMapping(ITracker);
    }
}
}
