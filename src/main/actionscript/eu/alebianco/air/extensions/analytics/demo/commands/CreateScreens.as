/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:22
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
