/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 10:25
 */
package eu.alebianco.air.extensions.analytics.demo.commands {

import org.flexunit.runner.FlexUnitCore;

import robotlegs.bender.bundles.mvcs.Command;

public class RunSuite extends Command {

    [Inject]
    public var suite:Class;

    [Inject]
    public var runner:FlexUnitCore;

    override public function execute():void {
        runner.run(suite);
    }
}
}
