/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 09/11/2014 15:12
 */
package eu.alebianco.air.extensions.analytics.demo.commands.hooks {
import eu.alebianco.air.extensions.analytics.demo.events.ExecuteTestSuiteEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestResultVO;

import robotlegs.bender.framework.api.IHook;

public class CreateReportSession implements IHook{

    [Inject]
    public var session:SessionStorage;

    [Inject]
    public var event:ExecuteTestSuiteEvent;

    public function hook():void {

        session.clear();

        session.setItem("current", event.suite);
        session.setItem("reports", new <TestResultVO>[]);
    }
}
}
