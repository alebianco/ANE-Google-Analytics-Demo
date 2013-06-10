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
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;
import eu.alebianco.air.extensions.analytics.demo.views.api.INavigateScreens;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NavigateMediator extends Mediator {

	[Inject]
	public var injector:Injector;

	[Inject]
	public var view:INavigateScreens;

	[Inject]
	public var analytics:IAnalytics;

	[Inject]
	public var resources:ResourceBundle;

	override public function initialize():void {
		super.initialize();
		view.navigationRequested.add(onNavigate);
	}

	private function onNavigate(screen:DemoScreen):void {
		dispatch(new NavigateEvent(screen))
	}

	override public function destroy():void {
		super.destroy();
		view.navigationRequested.removeAll();
	}
}
}
