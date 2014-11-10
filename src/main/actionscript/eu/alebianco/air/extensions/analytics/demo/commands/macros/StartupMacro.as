/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:15
 */
package eu.alebianco.air.extensions.analytics.demo.commands.macros {
import eu.alebianco.air.extensions.analytics.demo.commands.PrepareAssets;
import eu.alebianco.air.extensions.analytics.demo.commands.PrepareResources;
import eu.alebianco.air.extensions.analytics.demo.commands.PrepareScreenNavigator;
import eu.alebianco.air.extensions.analytics.demo.commands.SetupFeathers;
import eu.alebianco.air.extensions.analytics.demo.commands.ShowSuitesList;
import eu.alebianco.air.extensions.analytics.demo.commands.ShowUnsupportedWarning;
import eu.alebianco.air.extensions.analytics.demo.commands.guards.IsNotSupported;
import eu.alebianco.air.extensions.analytics.demo.commands.guards.IsSupported;
import eu.alebianco.robotlegs.utils.impl.SequenceMacro;

public class StartupMacro extends SequenceMacro {

    override public function prepare():void {

        add(SetupFeathers);
        add(PrepareResources);
        add(PrepareAssets);
        add(PrepareScreenNavigator);
        add(ShowSuitesList).withGuards(IsSupported);
        add(ShowUnsupportedWarning).withGuards(IsNotSupported);
    }
}
}
