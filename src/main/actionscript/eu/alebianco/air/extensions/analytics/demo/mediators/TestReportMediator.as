/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.TestReportUpdateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayTestReports;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TestReportMediator extends Mediator {

    [Inject]
    public var view:IDisplayTestReports;

    [Inject]
    public var session:SessionStorage;

    override public function initialize():void {
        super.initialize();
        addContextListener(TestReportUpdateEvent.UPDATE, onReportUpdated, TestReportUpdateEvent);

        view.selected.add(displayTestDetails);

        const list:Vector.<TestReportVO> = session.getItem("reports") as Vector.<TestReportVO>;
        list.forEach(function(item:TestReportVO, index:int, list:Vector.<TestReportVO>):void {
            view.updateReport(item);
        });
    }

    override public function destroy():void {
        super.destroy();

        view.selected.removeAll();
    }

    private function displayTestDetails(report:TestReportVO):void {
        trace("show report screen for", report.test.name);
    }

    private function onReportUpdated(event:TestReportUpdateEvent):void {
        view.updateReport(event.report);
    }
}
}
