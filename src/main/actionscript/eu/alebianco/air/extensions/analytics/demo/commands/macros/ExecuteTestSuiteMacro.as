/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:15
 */
package eu.alebianco.air.extensions.analytics.demo.commands.macros {
import eu.alebianco.air.extensions.analytics.demo.commands.Delay;
import eu.alebianco.air.extensions.analytics.demo.commands.ShowScreen;
import eu.alebianco.air.extensions.analytics.demo.commands.guards.isTestActive;
import eu.alebianco.air.extensions.analytics.demo.events.ExecuteTestSuiteEvent;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;
import eu.alebianco.robotlegs.utils.impl.SequenceMacro;
import eu.alebianco.robotlegs.utils.impl.SubCommandPayload;

public class ExecuteTestSuiteMacro extends SequenceMacro {

    [Inject]
    public var event:ExecuteTestSuiteEvent;

    override public function prepare():void {

        add(ShowScreen).withPayloads(new NavigateEvent(DemoScreen.TEST_RUNNER));
        add(Delay).withPayloads(new SubCommandPayload(3000, Number).withName("delay"));
        event.suite.tests.forEach(queueCommand);
        // TODO notify tests complete, show report
    }

    private function queueCommand(item:Test, index:int, list:Vector.<Test>):void {
        add(item.command).withGuards(isTestActive).withPayloads(new SubCommandPayload(item, Test));
    }
}
}
