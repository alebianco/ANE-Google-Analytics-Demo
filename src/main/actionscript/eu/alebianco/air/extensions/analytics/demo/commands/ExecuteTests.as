/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 15:37
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;

import robotlegs.bender.bundles.mvcs.Command;

public class ExecuteTests extends Command {

    [Inject]
    public var suite:TestSuite;

    override public function execute():void {
        trace("executing", suite.tests.length, "tests from suite", suite.name);
    }
}
}
