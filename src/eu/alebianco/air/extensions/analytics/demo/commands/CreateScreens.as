/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 01/06/13 12.38
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands {

import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;

import robotlegs.bender.bundles.mvcs.Command;

public class CreateScreens extends Command {

	[Inject]
	public var navigator:ScreenNavigator;

	override public function execute():void {
		DemoScreen.getConstants().forEach(function (screen:DemoScreen, index:int, list:Vector.<DemoScreen>):void {
			navigator.addScreen(screen.name, new ScreenNavigatorItem(screen.view))
		});
	}
}
}