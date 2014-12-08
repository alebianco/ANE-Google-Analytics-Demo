/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 09/11/2014 18:42
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.model.TestCaseData;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayReportDetails;

import feathers.controls.Label;
import feathers.display.VerticalSpacer;
import feathers.layout.VerticalLayoutData;

public class ReportDetailsScreen extends BaseBackScreen implements IDisplayReportDetails {

    private var name_lbl:Label;
    private var description_lbl:Label;
    private var time_lbl:Label;
    private var result_lbl:Label;
    private var feedback_lbl:Label;

    private var _data:TestCaseData;

    override protected function initialize():void {
        super.initialize();

        name_lbl = createNameLabel();
        description_lbl = createDescriptionLabel();
        time_lbl = createTimeLabel();
        result_lbl = createResultLabel();
        feedback_lbl = createFeedbackLabel();

        addChild(name_lbl);
        addChild(description_lbl);
        addChild(new VerticalSpacer(48));
        addChild(time_lbl);
        addChild(result_lbl);
        addChild(new VerticalSpacer(48));
        addChild(feedback_lbl);

    }

    public function updateInfo(group:String, name:String, description:String):void {
        trace(group, name, description)
    }

    public function updateTime(duration:int):void {
        trace(duration);
    }

    public function updateStatus(complete:Boolean, successful:Boolean, ignored:Boolean):void {
        trace(complete, successful, ignored);
    }

    public function updateFailure(message:String, stackTrace:String):void {
        trace(message, stackTrace);
    }

    override protected function draw():void {

        const isDataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);

        if (isDataInvalid && _data) {
            if (name_lbl)
                name_lbl.text = _data.description.displayName;
            if (description_lbl)
                description_lbl.text = "...";
            if (time_lbl)
                time_lbl.text = "...";
            if (result_lbl)
                result_lbl.text = _data.wasIgnored() ? "ignored" : (_data.wasSuccessful() ? "success" : "failure");
            if (feedback_lbl)
                feedback_lbl.text = !_data.wasSuccessful() ? _data.failure.message : "";
        }

        super.draw();
    }

    override public function dispose():void {
        removeChildren();

        name_lbl.dispose();
        name_lbl = null;

        description_lbl.dispose();
        description_lbl = null;

        time_lbl.dispose();
        time_lbl = null;

        result_lbl.dispose();
        result_lbl = null;

        feedback_lbl.dispose();
        feedback_lbl = null;

        super.dispose();
    }

    private function createNameLabel():Label {
        const label:Label = new Label();
        label.styleNameList.add(Label.ALTERNATE_NAME_HEADING);
        label.layoutData = new VerticalLayoutData(100);
        return label;
    }

    private function createDescriptionLabel():Label {
        const label:Label = new Label();
        label.textRendererProperties.wordWrap = true;
        label.layoutData = new VerticalLayoutData(100);
        return label;
    }

    private function createTimeLabel():Label {
        const label:Label = new Label();
        label.styleNameList.add(Label.ALTERNATE_NAME_DETAIL);
        label.layoutData = new VerticalLayoutData(100);
        return label;
    }

    private function createResultLabel():Label {
        const label:Label = new Label();
        label.styleNameList.add(Label.ALTERNATE_NAME_DETAIL);
        label.layoutData = new VerticalLayoutData(100);
        return label;
    }

    private function createFeedbackLabel():Label {
        const label:Label = new Label();
        label.textRendererProperties.wordWrap = true;
        label.layoutData = new VerticalLayoutData(100);
        return label;
    }

    override protected function onBackButton():void {
        back.dispatch(DemoScreen.SUITE_RUNNER);
    }
}
}
