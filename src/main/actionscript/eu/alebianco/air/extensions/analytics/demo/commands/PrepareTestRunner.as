/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 15:37
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import org.flexunit.runner.FlexUnitCore;
import org.flexunit.runner.notification.RunListener;

import robotlegs.bender.bundles.mvcs.Command;

public class PrepareTestRunner extends Command {

    [Inject]
    public var runner:FlexUnitCore;

    [Inject]
    public var listener:RunListener;

    override public function execute():void {
        runner.addListener(listener);
    }
}
}
