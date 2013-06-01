/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 13:00
 *
 * Copyright © 2013 Alessandro Bianco
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
