/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 14:51
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;

import feathers.controls.ScreenNavigator;

import robotlegs.bender.bundles.mvcs.Command;

public class ShowScreen extends Command {

    [Inject]
    public var event:NavigateEvent;

    [Inject]
    public var navigator:ScreenNavigator;

    override public function execute():void {
	    navigator.showScreen(event.screen.name);
    }
}
}
