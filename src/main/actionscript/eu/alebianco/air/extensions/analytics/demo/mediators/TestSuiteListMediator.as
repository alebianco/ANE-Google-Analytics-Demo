/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.SelectedSuiteEvent;
import eu.alebianco.air.extensions.analytics.demo.model.TestBundle;
import eu.alebianco.air.extensions.analytics.demo.views.api.IListTestSuites;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TestSuiteListMediator extends Mediator {

    [Inject]
    public var view:IListTestSuites;

    override public function initialize():void {
        super.initialize();

        view.selected.addOnce(suiteSelected);
        TestBundle.getConstants().forEach(createSuiteLauncher);
    }

    private function suiteSelected(bundle:TestBundle):void {
        dispatch(new SelectedSuiteEvent(bundle.suite));
    }

    private function createSuiteLauncher(item:TestBundle, index:int, list:Vector.<TestBundle>):void {
        view.addSuite(item);
    }

    override public function destroy():void {
        super.destroy();
        view.selected.removeAll();
    }

}
}
