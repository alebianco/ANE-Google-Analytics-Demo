/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 16:57
 */
package eu.alebianco.air.extensions.analytics.demo.commands.tests {
import eu.alebianco.air.extensions.analytics.demo.events.ReportTestResultEvent;
import eu.alebianco.air.extensions.analytics.demo.events.ReportTestStartEvent;
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;
import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

import flash.events.IEventDispatcher;

public class AbstractTest extends AsyncCommand {

    [Inject]
    public var dispatcher:IEventDispatcher;

    [Inject]
    public var test:Test;

    override public function execute():void {
        dispatcher.dispatchEvent(new ReportTestStartEvent(test));
    }

    public function report(success:Boolean, message:String = "", ...data):void {
        dispatcher.dispatchEvent(new ReportTestResultEvent(test, success, message, data));
        dispatchComplete(true);
    }

    public function verify(...data):void {
        report(false, "error.test.verifier.not.implemented", test.name);
    }


}
}
