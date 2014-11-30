/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/11/2014 20:45
 */
package eu.alebianco.air.extensions.analytics.demo.tests.runner {
import eu.alebianco.air.extensions.analytics.demo.events.TestCaseDataChangedEvent;
import eu.alebianco.air.extensions.analytics.demo.events.TestsCompleteEvent;
import eu.alebianco.air.extensions.analytics.demo.events.TestsStartedEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.TestCaseData;
import eu.alebianco.utils.functional.first;

import flash.events.IEventDispatcher;

import flexunit.framework.Assert;

import org.flexunit.Assert;
import org.flexunit.runner.IDescription;
import org.flexunit.runner.Result;
import org.flexunit.runner.notification.Failure;
import org.flexunit.runner.notification.IRunListener;
import org.flexunit.runner.notification.RunListener;

public class SessionListener extends RunListener implements IRunListener {

    [Inject]
    public var session:SessionStorage;

    [Inject]
    public var dispatcher:IEventDispatcher;

    private var lastFailedTest:IDescription;

    public function SessionListener() {
        super();
    }

    override public function testRunStarted(description:IDescription):void {
        session.setItem("running", true);
        session.setItem("start-time", new Date().getTime());
        session.setItem("test-count", description.testCount);
        session.setItem("suite", description.children[0]);
        session.setItem("list", new <TestCaseData>[]);
        dispatcher.dispatchEvent(new TestsStartedEvent());
    }

    override public function testRunFinished(result:Result):void {
        session.setItem("running", false);
        session.setItem("successful", result.successful);
        session.setItem("end-time", new Date().getTime());
        dispatcher.dispatchEvent(new TestsCompleteEvent());
    }

    override public function testStarted(description:IDescription):void {
        addRunning(description);
        dispatcher.dispatchEvent(new TestCaseDataChangedEvent());
    }

    override public function testFinished(description:IDescription):void {
        var count:int = session.getItem("tests-run") || 0;
        session.setItem("tests-run", count+1);

        if(!lastFailedTest || !description.equals(lastFailedTest)) {
            addSuccess(description);
        }
        dispatcher.dispatchEvent(new TestCaseDataChangedEvent());
    }

    override public function testFailure(failure:Failure):void {
        lastFailedTest = failure.description;
        addFailure(failure);
        dispatcher.dispatchEvent(new TestCaseDataChangedEvent());
    }

    override public function testIgnored(description:IDescription):void {
        addIgnored(description);
        dispatcher.dispatchEvent(new TestCaseDataChangedEvent());
    }

    override public function testAssumptionFailure(failure:Failure):void {
        lastFailedTest = failure.description;
        addFailure(failure);
        dispatcher.dispatchEvent(new TestCaseDataChangedEvent());
    }

    private function get totalAssertions():uint {
        return flexunit.framework.Assert.assetionsMade + org.flexunit.Assert.assertionsMade;
    }

    private function addRunning(description:IDescription):void {
        addTestToList(description);
    }

    private function addSuccess(description:IDescription):void {
        var count:int = session.getItem("tests-succeeded") || 0;
        session.setItem("tests-succeeded", count+1);
        addTestToList(description, null, true, true);
    }

    private function addFailure(failure:Failure):void {
        var count:int = session.getItem("tests-failed") || 0;
        session.setItem("tests-failed", count+1);
        addTestToList(failure.description, failure, false, true);
    }

    private function addIgnored(description:IDescription):void {
        var count:int = session.getItem("tests-ignored") || 0;
        session.setItem("tests-ignored", count+1);
        addTestToList(description, null, true, true);
    }

    private function addTestToList(description:IDescription, failure:Failure = null, ignored:Boolean = false, complete:Boolean = false):void {
        const data:TestCaseData = findOrCreate(description);
        if (complete && !data.isComplete()) {
            data.complete(failure, ignored, totalAssertions);
        }
    }

    private function findOrCreate(description:IDescription):TestCaseData {
        const list:Vector.<TestCaseData> = session.getItem("list") as Vector.<TestCaseData>;
        var data:TestCaseData = first(list, isSameDescription, description);
        if (!data) {
            data = new TestCaseData(description);
            list.push(data);
        }
        return data;
    }

    private function isSameDescription(data:TestCaseData, description:IDescription):Boolean {
        return description.equals(data.description);
    }
}
}
