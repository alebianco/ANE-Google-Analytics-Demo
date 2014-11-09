/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 15:37
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

import flash.utils.setTimeout;

public class Delay extends AsyncCommand {

    [Inject(optional="true", name="delay")]
    public var delay:Number;

    override public function execute():void {
        setTimeout(dispatchComplete, delay || 1000, true);
    }
}
}
