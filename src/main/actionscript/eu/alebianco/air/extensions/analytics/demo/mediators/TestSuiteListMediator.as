/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.views.api.IListTestSuites;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TestSuiteListMediator extends Mediator {

    [Inject]
    public var view:IListTestSuites;

    override public function initialize():void {
        super.initialize();
    }

    override public function destroy():void {
        super.destroy();
        view.selected.removeAll();
    }

}
}
