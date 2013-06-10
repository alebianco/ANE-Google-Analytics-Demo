/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 01/06/13 12.37
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands.macro {
import eu.alebianco.air.extensions.analytics.demo.commands.*;

import eu.alebianco.air.extensions.analytics.Analytics;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.robotlegs.utils.impl.SequenceMacro;

import flash.events.IEventDispatcher;

public class StartupMacro extends SequenceMacro {

	[Inject]
	public var dispatcher:IEventDispatcher;

	override public function prepare():void {

		addSubCommand(SetupFeathers);
		addSubCommand(CreateScreens);

		addCompletionListener(onReady);
	}

	private function onReady(success:Boolean):void {
		dispatcher.dispatchEvent(new NavigateEvent(Analytics.isSupported() ? DemoScreen.HOME : DemoScreen.UNSUPPORTED));
	}
}
}
