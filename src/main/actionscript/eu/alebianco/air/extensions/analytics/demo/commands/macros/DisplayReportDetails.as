/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 09/11/2014 18:41
 */
package eu.alebianco.air.extensions.analytics.demo.commands.macros {
import eu.alebianco.air.extensions.analytics.demo.commands.ShowScreen;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.robotlegs.utils.impl.SequenceMacro;

public class DisplayReportDetails extends SequenceMacro {

    override public function prepare():void {

        add(ShowScreen).withPayloads(new NavigateEvent(DemoScreen.REPORT_DETAILS));
        // TODO send report to screen
    }
}
}
