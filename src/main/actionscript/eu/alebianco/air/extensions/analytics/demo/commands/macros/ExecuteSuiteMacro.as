/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:15
 */
package eu.alebianco.air.extensions.analytics.demo.commands.macros {
import eu.alebianco.air.extensions.analytics.demo.commands.RunSuite;
import eu.alebianco.air.extensions.analytics.demo.commands.ShowScreen;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.events.SelectedSuiteEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.robotlegs.utils.impl.SequenceMacro;
import eu.alebianco.robotlegs.utils.impl.SubCommandPayload;

public class ExecuteSuiteMacro extends SequenceMacro {

    [Inject]
    public var event:SelectedSuiteEvent;

    override public function prepare():void {
        add(ShowScreen).withPayloads(new NavigateEvent(DemoScreen.SUITE_RUNNER));
        add(RunSuite).withPayloads(new SubCommandPayload(event.suite, Class));
    }
}
}
