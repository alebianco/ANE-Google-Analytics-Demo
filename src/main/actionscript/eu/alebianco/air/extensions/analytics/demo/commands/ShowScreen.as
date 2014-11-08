/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:29
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
