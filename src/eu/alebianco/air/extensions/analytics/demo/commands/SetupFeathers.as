/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 14:51
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands {

import feathers.controls.ScreenNavigator;
import feathers.core.DisplayListWatcher;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
import feathers.themes.MetalWorksMobileTheme;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.starling.extensions.contextView.ContextView;

public class SetupFeathers extends Command {

	[Inject]
	public var contextView:ContextView;

	[Inject]
	public var navigator:ScreenNavigator;

	[Inject]
	public var injector:Injector;

	override public function execute():void {
		injector.map(DisplayListWatcher).toValue(new MetalWorksMobileTheme(contextView.view.stage));
		new ScreenSlidingStackTransitionManager(navigator).duration = 0.4;
	}
}
}
