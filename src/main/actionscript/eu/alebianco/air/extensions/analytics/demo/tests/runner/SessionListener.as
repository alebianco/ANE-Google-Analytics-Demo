/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/11/2014 20:45
 */
package eu.alebianco.air.extensions.analytics.demo.tests.runner {
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;

import flash.events.Event;
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
        session.setItem("test-count", description.testCount);
        session.setItem("running", true);
        session.setItem("start-time", new Date().getTime());
        session.setItem("list", new <Object>[]);
    }

    override public function testRunFinished(result:Result):void {
        session.setItem("running", false);
        session.setItem("end-time", new Date().getTime());
        dispatcher.dispatchEvent(new Event(Event.COMPLETE)); // use custom event
    }

    override public function testFinished(description:IDescription):void {
        var count:int = session.getItem("tests-run") || 0;
        session.setItem("tests-run", count+1);

        if(!lastFailedTest || description.displayName != lastFailedTest.displayName) {
            addSuccess(description);
        }
    }

    override public function testStarted(description:IDescription):void {
        // add test as disabled
    }

    override public function testFailure(failure:Failure):void {
        lastFailedTest = failure.description;
        addFailure(failure);
    }

    override public function testIgnored(description:IDescription):void {
        addIgnored(description);
    }

    override public function testAssumptionFailure(failure:Failure):void {
        // nada
    }

    private function get totalAssertions():uint {
        return flexunit.framework.Assert.assetionsMade + org.flexunit.Assert.assertionsMade;
    }

    private function addSuccess(description:IDescription):void {
        var count:int = session.getItem("tests-succeeded") || 0;
        session.setItem("tests-succeeded", count+1);

        addTestToList(description, null, true, totalAssertions);
    }

    private function addFailure(failure:Failure):void {
        var count:int = session.getItem("tests-failed") || 0;
        session.setItem("tests-failed", count+1);

        addTestToList(failure.description, failure, false, totalAssertions);
    }

    private function addIgnored(description:IDescription):void {
        var count:int = session.getItem("tests-ignored") || 0;
        session.setItem("tests-ignored", count+1);

        addTestToList(description, null, true);
    }

    private function addTestToList(description:IDescription, failure:Failure = null, ignored:Boolean = false, assertionsMade:uint = 0):void {
        var list:Vector.<Object> = session.getItem("list");
        list.push({d:description, f:failure, i:ignored, a:assertionsMade});
    }
}
}
