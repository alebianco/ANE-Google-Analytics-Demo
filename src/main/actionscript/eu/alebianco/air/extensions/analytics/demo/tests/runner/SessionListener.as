/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/11/2014 20:45
 */
package eu.alebianco.air.extensions.analytics.demo.tests.runner {
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.TestCaseData;

import flash.events.IEventDispatcher;

import flexunit.framework.Assert;

import org.flexunit.Assert;
import org.flexunit.flexui.event.TestsCompleteEvent;
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
        session.setItem("list", new <TestCaseData>[]);
    }

    override public function testRunFinished(result:Result):void {
        session.setItem("running", false);
        session.setItem("successful", result.successful);
        session.setItem("end-time", new Date().getTime());
        dispatcher.dispatchEvent(new TestsCompleteEvent());
    }

    override public function testStarted(description:IDescription):void {
        addRunning(description);
    }

    override public function testFinished(description:IDescription):void {
        var count:int = session.getItem("tests-run") || 0;
        session.setItem("tests-run", count+1);

        if(!lastFailedTest || !description.equals(lastFailedTest)) {
            addSuccess(description);
        }
    }

    override public function testFailure(failure:Failure):void {
        lastFailedTest = failure.description;
        addFailure(failure);
    }

    override public function testIgnored(description:IDescription):void {
        addIgnored(description);
    }

    override public function testAssumptionFailure(failure:Failure):void {
        lastFailedTest = failure.description;
        addFailure(failure);
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
        var data:TestCaseData = null;
        const list:Vector.<TestCaseData> = session.getItem("list") as Vector.<TestCaseData>;
        const filtered:Vector.<TestCaseData> = list.filter(isSame(description));
        if (filtered && filtered.length > 0) {
            data = filtered[0];
        } else {
            data = new TestCaseData(description);
            list.push(data);
        }
        return data;
    }

    private function isSame(description:IDescription):Function {
        return function(data:TestCaseData, index:uint, list:Vector.<TestCaseData>):Boolean {
            return description.equals(data.description);
        };
    }
}
}