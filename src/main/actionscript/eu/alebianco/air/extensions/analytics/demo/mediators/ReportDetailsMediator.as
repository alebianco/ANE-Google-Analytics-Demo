/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 11/11/2014 14:45
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.TestCaseData;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayReportDetails;
import eu.alebianco.utils.extractMetadataValue;

import mx.resources.IResourceManager;

import robotlegs.starling.bundles.mvcs.Mediator;

public class ReportDetailsMediator extends Mediator {

    [Inject]
    public var view:IDisplayReportDetails;

    [Inject]
    public var resource:IResourceManager;

    [Inject]
    public var session:SessionStorage;

    private var report:TestCaseData;

    override public function initialize():void {
        super.initialize();
        report = session.getItem("report") as TestCaseData;
        report.completed.add(onTestCompleted);
        updateView();
    }

    override public function destroy():void {
        super.destroy();
        report.completed.remove(onTestCompleted);
    }

    private function onTestCompleted():void {
        updateView();
    }

    private function updateView():void {
        view.updateInfo(testGroup, testName, testDescription);
        view.updateTime(0);
        view.updateStatus(report.isComplete(), report.wasSuccessful(), report.wasIgnored());
        if (!report.wasSuccessful()) {
            view.updateFailure(report.failure.message, report.failure.stackTrace);
        }
    }

    private function get testName():String {
        return report.description.displayName.split(".").pop();
    }

    private function get testGroup():String {
        return report.description.displayName.split("::")[1].split(".")[0];
    }

    private function get testDescription():String {
        var localised:String;
        try {
            const description:String = extractMetadataValue(report.description.getAllMetadata(), "Test", "description") as String;
            localised = resource.getString("resources", description);
        } catch (error:Error) {
            localised = resource.getString("resources", "error.suite.description.rte", [error.message]);
        } finally {
            localised ||= resource.getString("resources", "error.suite.description.not.found", [testName]);
        }
        return localised;
    }
}
}
