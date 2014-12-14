/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 29/11/2014 22:17
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.events.TestCaseDataChangedEvent;
import eu.alebianco.air.extensions.analytics.demo.events.TestsCompleteEvent;
import eu.alebianco.air.extensions.analytics.demo.events.TestsStartedEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.TestCaseData;
import eu.alebianco.air.extensions.analytics.demo.model.TestStats;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayExecutionProgress;
import eu.alebianco.utils.functional.fold;

import robotlegs.starling.bundles.mvcs.Mediator;

public class SuiteProgressMediator extends Mediator {

    [Inject]
    public var view:IDisplayExecutionProgress;

    [Inject]
    public var session:SessionStorage;

    override public function initialize():void {
        super.initialize();

        updateStatus();
        updateProgress();
        updateFitness();

        addContextListener(TestsStartedEvent.STARTED, onTestsStarted, TestsStartedEvent);
        addContextListener(TestCaseDataChangedEvent.CHANGE, onDataChange, TestCaseDataChangedEvent);
        addContextListener(TestsCompleteEvent.COMPLETE, onTestsComplete, TestsCompleteEvent);
    }

    private function updateStatus():void {
        const running:Boolean = session.getItem("running");
        const successful:Boolean = session.getItem("successful");
        view.updateStatus(running, successful);
    }

    private function updateProgress():void {
        const stats:TestStats = session.getItem("stats") as TestStats;
        if (stats) {
            view.updateProgress(stats.completed);
            view.updateStats(stats.passed, stats.failed, stats.ignored);
        }
    }

    private function updateFitness():void {
        const endedAt:uint = session.getItem("end-time");
        const startedAt:uint = session.getItem("start-time");
        const list:Vector.<TestCaseData> = session.getItem("list");
        if (list) {
            const getAssertions:Function = function(data:TestCaseData):uint {return data.totalAssertions;};
            const average:Number = Number(fold(1, list, getAssertions)) / list.length;
            view.updateFitness(endedAt-startedAt, average);
        }
    }

    private function onTestsStarted(event:TestsStartedEvent):void {
        updateStatus();
    }

    private function onDataChange(event:TestCaseDataChangedEvent):void {
        updateProgress();
    }

    private function onTestsComplete(event:TestsCompleteEvent):void {
        updateStatus();
        updateFitness();
    }
}
}
