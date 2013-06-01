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
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.views.SettingsScreen;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SettingsMediator extends Mediator {

	[Inject]
	public var view:SettingsScreen;

	[Inject]
	public var analytics:IAnalytics;

	override public function initialize():void {
		super.initialize();

		view.debug = analytics.debug;
		view.dispatchManually = analytics.dispatchManually;
		view.dispatchInterval = analytics.dispatchInterval;
		view.optOut = analytics.optOut;

		view.changed.add(onChanged);
		view.completed.add(onCompleted);
	}

	private function onChanged():void {
		analytics.debug = view.debug;
		analytics.dispatchManually = view.dispatchManually;
		analytics.dispatchInterval = view.dispatchInterval;
		analytics.optOut = view.optOut;
	}

	private function onCompleted():void {
		dispatch(new NavigateEvent(DemoScreen.HOME));
	}

	override public function destroy():void {
		super.destroy();
		view.changed.removeAll();
		view.completed.removeAll();
	}
}
}
