/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {

import eu.alebianco.air.extensions.analytics.demo.events.TestsStartedEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.TestStats;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;
import eu.alebianco.utils.extractMetadataValue;

import mx.resources.IResourceManager;

import org.flexunit.runner.IDescription;

import robotlegs.starling.bundles.mvcs.Mediator;

public class SuiteInformationMediator extends Mediator {

    [Inject]
    public var view:IDisplaySuiteInformation;

    [Inject]
    public var resource:IResourceManager;

    [Inject]
    public var session:SessionStorage;

    override public function initialize():void {
        super.initialize();

        updateInfo();
        addContextListener(TestsStartedEvent.STARTED, onTestsStarted, TestsStartedEvent);
    }

    private function updateInfo():void {
        const stats:TestStats = session.getItem("stats") as TestStats;
        if (stats) {
            view.showDetails(suiteName, suiteDescription, stats.total);
        }
    }

    private function onTestsStarted(event:TestsStartedEvent):void {
        updateInfo();
    }

    private function get suiteName():String {
        const suite:IDescription = session.getItem("suite") as IDescription;
        return suite.displayName.split("::")[1];
    }

    private function get suiteDescription():String {
        const suite:IDescription = session.getItem("suite") as IDescription;
        var localised:String;
        try {
            const description:String = extractMetadataValue(suite.getAllMetadata(), "Suite", "description") as String;
            localised = resource.getString("resources", description);
        } catch (error:Error) {
            localised = resource.getString("resources", "error.suite.description.rte", [error.message]);
        } finally {
            localised ||= resource.getString("resources", "error.suite.description.not.found", [suite.displayName.split("::")[1]]);
        }
        return localised;
    }
}
}
