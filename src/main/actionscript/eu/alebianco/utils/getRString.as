/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 30/11/2014 09:24
 */
package eu.alebianco.utils {
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

public function getRString(id:String, ...arguments):String {
        const DEFAULT_BUNDLE_NAME:String = "resources";
        const resources:IResourceManager = ResourceManager.getInstance();
        return resources.getString(DEFAULT_BUNDLE_NAME, id, arguments);
    }
}
