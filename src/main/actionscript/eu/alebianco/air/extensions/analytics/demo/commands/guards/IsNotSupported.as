/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:53
 */
package eu.alebianco.air.extensions.analytics.demo.commands.guards {

public class IsNotSupported extends IsSupported {

    override public function approve():Boolean {
        return !super.approve();
    }
}
}
