/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.views.api.IBack;

import robotlegs.bender.bundles.mvcs.Mediator;

public class BackMediator extends Mediator {

    [Inject]
    public var view:IBack;

    override public function initialize():void {
        super.initialize();
        view.back.addOnce(goBackHome);
    }

    override public function destroy():void {
        super.destroy();
        view.back.removeAll();
    }

    private function goBackHome():void {
        dispatch(new NavigateEvent(DemoScreen.SUITES_LIST));
    }

}
}
