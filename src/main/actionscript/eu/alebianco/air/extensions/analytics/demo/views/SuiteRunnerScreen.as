/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 13:29
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayExecutionProgress;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayTestReports;
import eu.alebianco.utils.getRString;

import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.ProgressBar;
import feathers.core.FeathersControl;
import feathers.data.ListCollection;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalLayout;
import feathers.layout.HorizontalLayoutData;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.events.Event;
import starling.textures.Texture;

public class SuiteRunnerScreen extends BaseBackScreen implements IDisplayTestReports, IDisplaySuiteInformation, IDisplayExecutionProgress {

    private var _title:String = " ";
    private var _description:String = " ";
    private var _testsTotal:uint;
    private var _testsCompleted:uint;
    private var _testsPassed:uint;
    private var _testsFailed:uint;
    private var _testsIgnored:uint;
    private var _assertsAverage:Number = 0;
    private var _timeTaken:int;

    private var _selected:Signal;
    private var info_group:LayoutGroup;
    private var head_group:LayoutGroup;
    private var state_bmp:Image;
    private var title_lbl:Label;
    private var description_lbl:Label;
    private var progress_group:LayoutGroup;
    private var progress_lbl:Label;
    private var progress_bar:ProgressBar;
    private var stats_lbl:Label;
    private var fitness_lbl:Label;

    private var report_list:List;

    public function get selected():Signal {
        return _selected ||= new Signal();
    }

    public function showDetails(name:String, description:String, testCount:uint):void {
        _title = name;
        _description = description;
        _testsTotal = testCount;
        invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
    }

    public function updateProgress(completed:uint):void {
        _testsCompleted = completed;
        invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
    }

    public function updateStats(passed:uint, failed:uint, ignored:uint):void {
        _testsPassed = passed;
        _testsFailed = failed;
        _testsIgnored = ignored;
        invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
    }

    public function updateStatus(running:Boolean, successful:Boolean):void {
        const icon:Texture = assets.getTexture(running ? "progress" : successful ? "success" : "failure");
        state_bmp.texture = icon;
    }

    public function updateFitness(time:int, assertsAverage:Number):void {
        _timeTaken = time;
        _assertsAverage = assertsAverage;
        invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
    }

    override protected function initialize():void {
        super.initialize();

        info_group = createInfoGroup();
        head_group = createHeadGroup();
        title_lbl = createTitleLabel();
        state_bmp = creatStatusIcon();
        description_lbl = createDescriptionLabel();
        progress_lbl = createProgressLabel();
        progress_group = createProgressGroup();
        progress_bar = createProgressBar();
        stats_lbl = createStatsLabel();
        fitness_lbl = createFitnessLabel();
        report_list = createReportList();

        head_group.addChild(state_bmp);
        head_group.addChild(title_lbl);

        progress_group.addChild(progress_lbl);
        progress_group.addChild(progress_bar);

        info_group.addChild(head_group);
        info_group.addChild(description_lbl);
        info_group.addChild(progress_group);
        info_group.addChild(stats_lbl);
        info_group.addChild(fitness_lbl);

        addChild(info_group);
        addChild(report_list);
    }

    override protected function draw():void {

        const isDataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);
        const isLayoutInvalid:Boolean = isInvalid(INVALIDATION_FLAG_LAYOUT);

        if (isDataInvalid) {
            if (title_lbl)
                title_lbl.text = _title;
            if (description_lbl)
                description_lbl.text = _description;
            if (progress_lbl)
                progress_lbl.text = getRString("runner.progress.label", _testsCompleted, _testsTotal);
            if (progress_bar)
                progress_bar.value = _testsCompleted/_testsTotal;
            if (stats_lbl)
                stats_lbl.text = getRString("runner.stats.label", _testsPassed, _testsFailed, _testsIgnored);
            if (fitness_lbl)
                fitness_lbl.text = getRString("runner.fitness.label", (_timeTaken/1000).toFixed(2), _assertsAverage.toFixed(2));
        }

        super.draw();

        if (isLayoutInvalid) {
            if (report_list && info_group)
                AnchorLayoutData(report_list.layoutData).top = info_group.height;
        }
    }

    override public function dispose():void {
        removeChildren();

        info_group.removeChildren();
        info_group.dispose();
        info_group = null;

        head_group.removeChildren();
        head_group.dispose();
        head_group = null;

        title_lbl.dispose();
        title_lbl = null;

        state_bmp.dispose();
        state_bmp = null;

        description_lbl.dispose();
        description_lbl = null;

        progress_group.removeChildren();
        progress_group.dispose();
        progress_group = null;

        progress_lbl.dispose();
        progress_lbl = null;

        stats_lbl.dispose();
        stats_lbl = null;

        fitness_lbl.dispose();
        fitness_lbl = null;

        progress_bar.dispose();
        progress_bar = null;

        report_list.removeEventListener(Event.CHANGE, onTestSelected);
        report_list.dispose();
        report_list = null;

        super.dispose();
    }

    override protected function setupLayout():void {
        layout = new AnchorLayout();
    }

    private function createInfoGroup():LayoutGroup {
        const layout:VerticalLayout = new VerticalLayout();
        layout.gap = settings.gap;
        layout.paddingTop = settings.gap;
        layout.paddingRight = settings.paddingRight;
        layout.paddingBottom = settings.gap;
        layout.paddingLeft = settings.paddingLeft;
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
        layout.verticalAlign = settings.verticalAlign;

        const group:LayoutGroup = new LayoutGroup();
        group.layoutData = new AnchorLayoutData(0, 0, NaN, 0);
        group.layout = layout;
        return group;
    }

    private function createHeadGroup():LayoutGroup {
        const layout:HorizontalLayout = new HorizontalLayout();
        layout.gap = settings.gap;
        layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
        const group:LayoutGroup = new LayoutGroup();
        group.layoutData = new VerticalLayoutData(100);
        group.layout = layout;
        return group;
    }

    private function creatStatusIcon():Image {
        const icon:Image = new Image(Texture.empty(16, 16));
        return icon;
    }

    private function createTitleLabel():Label {
        const label:Label = new Label();
        label.styleNameList.add(Label.ALTERNATE_NAME_HEADING);
        label.layoutData = new HorizontalLayoutData(100);
        return label;
    }

    private function createDescriptionLabel():Label {
        const label:Label = new Label();
        label.textRendererProperties.wordWrap = true;
        label.layoutData = new VerticalLayoutData(100);
        return label;
    }

    private function createProgressGroup():LayoutGroup {
        const layout:HorizontalLayout = new HorizontalLayout();
        layout.gap = settings.gap;

        const group:LayoutGroup = new LayoutGroup();
        group.layoutData = new VerticalLayoutData(100);
        group.layout = layout;
        return group;
    }

    private function createProgressLabel():Label {
        const label:Label = new Label();
        return label;
    }

    private function createProgressBar():ProgressBar {
        const progress:ProgressBar = new ProgressBar();
        progress.minimum = 0;
        progress.maximum = 1;
        progress.value = 0;
        progress.layoutData = new HorizontalLayoutData(100);
        return progress;
    }

    private function createStatsLabel():Label {
        const label:Label = new Label();
        label.layoutData = new VerticalLayoutData(100);
        return label;
    }

    private function createFitnessLabel():Label {
        const label:Label = new Label();
        label.layoutData = new VerticalLayoutData(100);
        return label;
    }

    private function createReportList():List {
        const list:List = new List();
        list.dataProvider = new ListCollection([]);
        list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
        list.clipContent = true;
        list.autoHideBackground = true;
        list.isSelectable = true;
        list.itemRendererProperties.isQuickHitAreaEnabled = true;
        list.addEventListener(Event.CHANGE, onTestSelected);
        return list;
    }

    private function onTestSelected(event:Event):void {
        if (report_list.selectedIndex > -1) {

        }
    }
}
}
