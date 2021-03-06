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

import robotlegs.bender.framework.api.IGuard;
import robotlegs.bender.framework.api.IInjector;

public class OtherTrackerRegistered implements IGuard {

	[Inject]
	public var injector:IInjector;

	[Inject(name='account')]
	public var account:String;

	public function approve():Boolean {
		var tracker:ITracker;
		try {
			tracker = injector.getInstance(ITracker);
		} catch (error:Error) {
			tracker = null;
		}

		return (tracker != null && tracker.trackingID != account);
	}
}
}
