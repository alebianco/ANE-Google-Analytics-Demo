/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 13:29
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestResultVO;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;
import eu.alebianco.air.extensions.analytics.demo.views.api.IReportTestResults;

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
import feathers.skins.StandardIcons;

import flash.utils.Dictionary;

import org.osflash.signals.Signal;

import starling.events.Event;

import starling.textures.Texture;

public class SuiteRunnerScreen extends BaseBackScreen implements IReportTestResults, IDisplaySuiteInformation {

    private var map:Dictionary = new Dictionary();

    private var title:String = " ";
    private var description:String = " ";
    private var testsTotal:uint;
    private var testsCompleted:uint;

    private var info_group:LayoutGroup;
    private var title_lbl:Label;
    private var description_lbl:Label;
    private var progress_group:LayoutGroup;
    private var progress_lbl:Label;
    private var progress_bar:ProgressBar;
    private var results_list:List;

    private var _selected:Signal;

    public function get selected():Signal {
        return _selected ||= new Signal(TestResultVO);
    }

    public function showDetails(suite:TestSuite):void {
        title = getRString(suite.name);
        description = getRString(suite.description);
        testsTotal = suite.tests.length;

        invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
    }

    public function addTest(test:Test):void {
        const vo:TestResultVO = new TestResultVO(test);
        map[test] = vo;
        results_list.dataProvider.addItem(vo);
    }

    public function updateResult(test:Test, success:Boolean, message:String, data:Array):void {
        const feedback:String = getRString.apply(this, [message].concat(data));

        const vo:TestResultVO = map[test] as TestResultVO;
        vo.complete(success, feedback);

        testsCompleted++;

        const index:int = results_list.dataProvider.getItemIndex(vo);
        results_list.dataProvider.updateItemAt(index);

        invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
    }

    public function enableTestInspection():void {
        results_list.isSelectable = true;
    }

    override protected function initialize():void {
        super.initialize();

        info_group = createInfoGroup();
        title_lbl = createTitleLabel();
        description_lbl = createDescriptionLabel();
        progress_lbl = createProgressLabel();
        progress_group = createProgressGroup();
        progress_bar = createProgressBar();
        results_list = createResultsList();

        progress_group.addChild(progress_lbl);
        progress_group.addChild(progress_bar);

        info_group.addChild(title_lbl);
        info_group.addChild(description_lbl);
        info_group.addChild(progress_group);

        addChild(info_group);
        addChild(results_list);
    }

    override protected function draw():void {

        const isDataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);
        const isLayoutInvalid:Boolean = isInvalid(INVALIDATION_FLAG_LAYOUT);

        if (isDataInvalid) {
            if (title_lbl)
                title_lbl.text = title;
            if (description_lbl)
                description_lbl.text = description;
            if (progress_lbl)
                progress_lbl.text = getRString("runner.progress.label", testsCompleted, testsTotal);
            if (progress_bar)
                progress_bar.value = testsCompleted/testsTotal;
        }

        super.draw();

        if (isLayoutInvalid) {
            if (results_list && info_group)
                AnchorLayoutData(results_list.layoutData).top = info_group.height;
        }
    }

    override public function dispose():void {
        removeChildren();

        info_group.removeChildren();
        info_group.dispose();
        info_group = null;

        title_lbl.dispose();
        title_lbl = null;

        description_lbl.dispose();
        description_lbl = null;

        progress_group.removeChildren();
        progress_group.dispose();
        progress_group = null;

        progress_lbl.dispose();
        progress_lbl = null;

        progress_bar.dispose();
        progress_bar = null;

        results_list.dispose();
        results_list = null;

        results_list.removeEventListener(Event.CHANGE, onTestSelected);
        results_list.dispose();
        results_list = null;

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

    private function createTitleLabel():Label {
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

    private function createResultsList():List {
        const list:List = new List();
        list.dataProvider = new ListCollection([]);
        list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
        list.clipContent = true;
        list.autoHideBackground = true;
        list.isSelectable = false;
        list.itemRendererProperties.isQuickHitAreaEnabled = true;
        list.itemRendererProperties.accessorySourceFunction = function(item:TestResultVO):Texture {
            return StandardIcons.listDrillDownAccessoryTexture;
        };
        list.itemRendererProperties.iconSourceFunction = function(item:TestResultVO):Texture {
            if (!item.finished) {
                return assets.getTexture("progress");
            } else {
                return assets.getTexture(item.success ? "success" : "failure");
            }
        };
        list.itemRendererProperties.labelFunction = function(item:TestResultVO):String {
            return getRString(item.test.name) + (item.finished ? "" : " ...");
        };
        list.addEventListener(Event.CHANGE, onTestSelected);
        return list;
    }

    private function onTestSelected(event:Event):void {
        _selected.dispatch(results_list.selectedItem);
    }
}
}
