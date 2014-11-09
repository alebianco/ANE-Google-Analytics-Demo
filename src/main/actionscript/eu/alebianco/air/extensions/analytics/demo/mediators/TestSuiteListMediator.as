/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.ExecuteTestSuiteEvent;
import eu.alebianco.air.extensions.analytics.demo.model.TestsBundle;
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.air.extensions.analytics.demo.views.api.IListTestSuites;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TestSuiteListMediator extends Mediator {

    [Inject]
    public var bundle:TestsBundle;

    [Inject]
    public var view:IListTestSuites;

    override public function initialize():void {
        super.initialize();

        view.selected.addOnce(displaySuiteScreen);
        bundle.getListOfSuites().forEach(addSuiteToView);
    }

    override public function destroy():void {
        super.destroy();
        view.selected.removeAll();
    }

    private function displaySuiteScreen(suite:TestSuite):void {
        dispatch(new ExecuteTestSuiteEvent(suite));
    }

    private function addSuiteToView(item:TestSuite, index:int, list:Vector.<TestSuite>):void {
        view.addSuite(item);
    }

}
}
