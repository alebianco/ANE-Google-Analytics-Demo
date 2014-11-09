/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:15
 */
package eu.alebianco.air.extensions.analytics.demo.commands.macros {
import eu.alebianco.air.extensions.analytics.demo.commands.Delay;
import eu.alebianco.air.extensions.analytics.demo.commands.NotifySuiteComplete;
import eu.alebianco.air.extensions.analytics.demo.commands.NotifySuiteStart;
import eu.alebianco.air.extensions.analytics.demo.commands.ShowScreen;
import eu.alebianco.air.extensions.analytics.demo.commands.guards.isTestActive;
import eu.alebianco.air.extensions.analytics.demo.events.ExecuteSuiteEvent;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.robotlegs.utils.impl.SequenceMacro;
import eu.alebianco.robotlegs.utils.impl.SubCommandPayload;

public class ExecuteTestSuiteMacro extends SequenceMacro {

    [Inject]
    public var event:ExecuteSuiteEvent;

    override public function prepare():void {

        const suitePayload:SubCommandPayload = new SubCommandPayload(event.suite, TestSuite);

        add(ShowScreen).withPayloads(new NavigateEvent(DemoScreen.SUITE_RUNNER));
        add(NotifySuiteStart).withPayloads(suitePayload);
        add(Delay).withPayloads(new SubCommandPayload(500, Number).withName("delay"));

        event.suite.tests.forEach(queueTestsOf(suitePayload));

        add(NotifySuiteComplete).withPayloads(new SubCommandPayload(event.suite, TestSuite));
    }

    private function queueTestsOf(suitePayload:SubCommandPayload):Function {
        return function(item:Test, index:int, list:Vector.<Test>):void {
            const testPayload:SubCommandPayload = new SubCommandPayload(item, Test);
            add(item.command).withGuards(isTestActive).withPayloads(testPayload, suitePayload);
        }
    }
}
}
