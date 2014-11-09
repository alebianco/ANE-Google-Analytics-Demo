/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 15:37
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

import flash.filesystem.File;

import starling.utils.AssetManager;

public class PrepareAssets extends AsyncCommand {

    [Inject]
    public var assets:AssetManager;

    override public function execute():void {

        const appDir:File = File.applicationDirectory;
        assets.enqueue(appDir.resolvePath("textures"));

        assets.loadQueue(function(ratio:Number):void  {
            if (ratio == 1.0)
                dispatchComplete(true);
        });
    }
}
}
