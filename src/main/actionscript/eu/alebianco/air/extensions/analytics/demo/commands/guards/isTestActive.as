/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 15:56
 */
package eu.alebianco.air.extensions.analytics.demo.commands.guards {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;

import robotlegs.bender.framework.api.IGuard;

public class isTestActive implements IGuard {

    [Inject]
    public var test:Test;

    public function approve():Boolean {
        return test.active;
    }
}
}
