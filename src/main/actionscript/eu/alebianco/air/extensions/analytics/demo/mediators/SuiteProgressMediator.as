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
import eu.alebianco.air.extensions.analytics.demo.model.TestStats;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayExecutionProgress;

import robotlegs.starling.bundles.mvcs.Mediator;

public class SuiteProgressMediator extends Mediator {

    [Inject]
    public var view:IDisplayExecutionProgress;

    [Inject]
    public var session:SessionStorage;

    override public function initialize():void {
        super.initialize();

        addContextListener(TestsStartedEvent.STARTED, onTestsStarted, TestsStartedEvent);
        addContextListener(TestCaseDataChangedEvent.CHANGE, onDataChange, TestCaseDataChangedEvent);
        addContextListener(TestsCompleteEvent.COMPLETE, onTestsComplete, TestsCompleteEvent);
    }

    private function updateStatus():void {
        const running:Boolean = session.getItem("running");
        const successful:Boolean = session.getItem("successful");
        view.updateStatus(running, successful);
    }

    private function onTestsStarted(event:TestsStartedEvent):void {
        updateStatus();
    }

    private function onDataChange(event:TestCaseDataChangedEvent):void {
        const stats:TestStats = session.getItem("stats") as TestStats;
        view.updateProgress(stats.completed);
        view.updateStats(stats.passed, stats.failed, stats.ignored);
    }

    private function onTestsComplete(event:TestsCompleteEvent):void {
        updateStatus();
    }
}
}
