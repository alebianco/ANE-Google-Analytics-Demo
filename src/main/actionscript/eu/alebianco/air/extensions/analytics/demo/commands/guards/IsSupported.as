/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:53
 */
package eu.alebianco.air.extensions.analytics.demo.commands.guards {
import eu.alebianco.air.extensions.analytics.Analytics;

import robotlegs.bender.framework.api.IGuard;

public class IsSupported implements IGuard {

    public function approve():Boolean {
        return Analytics.isSupported();
    }
}
}
