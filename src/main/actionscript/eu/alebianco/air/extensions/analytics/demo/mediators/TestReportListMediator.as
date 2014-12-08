/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.SelectedReportEvent;
import eu.alebianco.air.extensions.analytics.demo.events.TestCaseDataChangedEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.TestCaseData;
import eu.alebianco.air.extensions.analytics.demo.views.api.IListTestReports;

import feathers.data.ListCollection;

import robotlegs.starling.bundles.mvcs.Mediator;

public class TestReportListMediator extends Mediator {

    [Inject]
    public var view:IListTestReports;

    [Inject]
    public var session:SessionStorage;

    private var collection:ListCollection;

    override public function initialize():void {
        super.initialize();

        collection = view.getReportsCollection();

        view.selected.addOnce(reportSelected);

        addContextListener(TestCaseDataChangedEvent.CHANGE, onDataChange, TestCaseDataChangedEvent);
    }

    private function reportSelected(report:TestCaseData):void {
        dispatch(new SelectedReportEvent(report));
    }

    private function onDataChange(event:TestCaseDataChangedEvent):void {
        const list:Vector.<TestCaseData> = session.getItem("list") as Vector.<TestCaseData>;

        list.forEach(function(report:TestCaseData, index:int, list:Vector.<TestCaseData>):void {
            if (collection.contains(report)) {
                const i:uint = collection.getItemIndex(report);
                collection.setItemAt(report, i);
                collection.updateItemAt(i);
            } else {
                collection.addItem(report);
            }
        });
    }

    override public function destroy():void {
        super.destroy();

        collection.removeAll();
        collection = null;
        view.selected.removeAll();
    }
}
}