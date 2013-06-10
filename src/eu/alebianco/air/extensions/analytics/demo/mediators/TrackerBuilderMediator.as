/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:08
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {

import eu.alebianco.air.extensions.analytics.demo.events.CreateTrackerEvent;
import eu.alebianco.air.extensions.analytics.demo.views.api.IBuildTrackers;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TrackerBuilderMediator extends Mediator {

	private const DEFAULT_ACCOUNT:String = "UA-29711569-2";

	[Inject]
	public var injector:Injector;

	[Inject]
	public var view:IBuildTrackers;

	override public function initialize():void {
		super.initialize();

		view.account = DEFAULT_ACCOUNT;

		view.accountChanged.add(onAccountChanged);
		view.connectTriggered.add(onConnect);
	}

	private function onAccountChanged():void {
		if (view.account.length > 18) {
			view.account = view.account.substr(0, 18);
		}
	}

	private function onConnect():void {
		dispatch(new CreateTrackerEvent(view.account));
	}

	override public function destroy():void {
		super.destroy();

		view.connectTriggered.removeAll();
		view.accountChanged.removeAll();
	}
}
}
