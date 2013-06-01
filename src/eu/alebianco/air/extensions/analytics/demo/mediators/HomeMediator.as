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
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;
import eu.alebianco.air.extensions.analytics.demo.views.HomeScreen;

import feathers.controls.Toast;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class HomeMediator extends Mediator {

	private const DEFAULT_ACCOUNT:String = "UA-29711569-2";

	[Inject]
	public var injector:Injector;

	[Inject]
	public var view:HomeScreen;

	[Inject]
	public var analytics:IAnalytics;

	[Inject]
	public var resources:ResourceBundle;

	override public function initialize():void {
		super.initialize();

		view.version = analytics.version;
		view.account = DEFAULT_ACCOUNT;

		view.navigationRequested.add(onNavigate);
		view.accountChanged.add(onAccountChanged);
		view.connectTriggered.add(onConnect);
	}

	private function onNavigate(screen:DemoScreen):void {
		dispatch(new NavigateEvent(screen))
	}

	private function onAccountChanged():void {
		if (view.account.length > 18) {
			view.account = view.account.substr(0, 18);
		}
	}

	private function onConnect():void {
		try {
			injector.map(ITracker).toValue(analytics.getTracker(view.account));
			dispatch(new NavigateEvent(DemoScreen.TRACKER));
		} catch (error:ArgumentError) {
			new Toast(resources.common.errors.trackercreationfail).show();
		}
	}

	override public function destroy():void {
		super.destroy();

		view.navigationRequested.removeAll();
		view.connectTriggered.removeAll();
		view.accountChanged.removeAll();
	}
}
}
