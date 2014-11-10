/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 15:37
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import flash.system.ApplicationDomain;

import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

import robotlegs.bender.bundles.mvcs.Command;

[ResourceBundle("resources")]
public class PrepareResources extends Command {

    [Inject]
    public var resources:IResourceManager;

    override public function execute():void {

        const currentDomain:ApplicationDomain = ApplicationDomain.currentDomain;

        const ResourceBundleInfo:Class = currentDomain.getDefinition("_CompiledResourceBundleInfo") as Class;
        const locales:Array = ResourceBundleInfo["compiledLocales"];
        const bundles:Array = ResourceBundleInfo["compiledResourceBundleNames"];

        ResourceManager.getInstance().installCompiledResourceBundles(currentDomain, locales, bundles, false);
        ResourceManager.getInstance().initializeLocaleChain(locales);
    }
}
}
