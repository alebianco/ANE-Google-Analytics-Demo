/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:16
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import feathers.controls.ScreenNavigator;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
import feathers.themes.CustomTheme;

import flash.filesystem.File;

import mx.resources.IResourceManager;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.starling.extensions.contextView.ContextView;

[ResourceBundle("resources")]
public class SetupFeathers extends Command {

    [Inject]
    public var contextView:ContextView;

    [Inject(name="assets")]
    public var assets:File;

    [Inject]
    public var navigator:ScreenNavigator;

    [Inject]
    public var resources:IResourceManager;

    override public function execute():void {
        new CustomTheme();
        new ScreenSlidingStackTransitionManager(navigator).duration = 0.4;
    }
}
}