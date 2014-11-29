/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/11/2014 21:44
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;

import robotlegs.bender.framework.api.IHook;

public class ClearSession implements IHook {

    [Inject]
    public var session:SessionStorage;

    public function hook():void {
        session.clear();
    }
}
}
