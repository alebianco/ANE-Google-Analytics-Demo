/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:52
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.demo.events.SuiteCompleteEvent;
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;

import flash.events.IEventDispatcher;

import robotlegs.bender.bundles.mvcs.Command;

public class NotifySuiteComplete extends Command {

    [Inject]
    public var suite:TestSuite;

    [Inject]
    public var dispatcher:IEventDispatcher;

    override public function execute():void {
        dispatcher.dispatchEvent(new SuiteCompleteEvent(suite));
    }
}
}
