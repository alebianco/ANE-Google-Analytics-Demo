/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 13:29
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayTestReports;

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

import org.osflash.signals.Signal;

import starling.events.Event;
import starling.textures.Texture;

public class SuiteRunnerScreen extends BaseBackScreen implements IDisplayTestReports, IDisplaySuiteInformation {

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
    private var report_list:List;

    private var _selected:Signal;

    public function get selected():Signal {
        return _selected ||= new Signal(TestReportVO);
    }

    public function showDetails(suite:TestSuite):void {
        title = getRString(suite.name);
        description = getRString(suite.description);
        testsTotal = suite.tests.length;

        invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
    }

    public function updateReport(report:TestReportVO):void {

        if (!report_list.dataProvider.contains(report)) {
            report_list.dataProvider.addItem(report);
        } else {
            const index:int = report_list.dataProvider.getItemIndex(report);
            report_list.dataProvider.updateItemAt(index)
        }

        if (report.finished) {
            testsCompleted++;
        }

        invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
    }

    override protected function initialize():void {
        super.initialize();

        info_group = createInfoGroup();
        title_lbl = createTitleLabel();
        description_lbl = createDescriptionLabel();
        progress_lbl = createProgressLabel();
        progress_group = createProgressGroup();
        progress_bar = createProgressBar();
        report_list = createReportList();

        progress_group.addChild(progress_lbl);
        progress_group.addChild(progress_bar);

        info_group.addChild(title_lbl);
        info_group.addChild(description_lbl);
        info_group.addChild(progress_group);

        addChild(info_group);
        addChild(report_list);
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
            if (report_list && info_group)
                AnchorLayoutData(report_list.layoutData).top = info_group.height;
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

    private function createReportList():List {
        const list:List = new List();
        list.dataProvider = new ListCollection([]);
        list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
        list.clipContent = true;
        list.autoHideBackground = true;
        list.isSelectable = true;
        list.itemRendererProperties.isQuickHitAreaEnabled = true;
        list.itemRendererProperties.accessorySourceFunction = function(item:TestReportVO):Texture {
            return StandardIcons.listDrillDownAccessoryTexture;
        };
        list.itemRendererProperties.iconSourceFunction = function(item:TestReportVO):Texture {
            if (!item.finished) {
                return assets.getTexture("progress");
            } else {
                return assets.getTexture(item.success ? "success" : "failure");
            }
        };
        list.itemRendererProperties.labelFunction = function(item:TestReportVO):String {
            return getRString(item.test.name) + (item.finished ? "" : " ...");
        };
        list.addEventListener(Event.CHANGE, onTestSelected);
        return list;
    }

    private function onTestSelected(event:Event):void {
        if (report_list.selectedIndex > -1) {
            const report:TestReportVO = report_list.selectedItem as TestReportVO;
            if (report.finished) {
                _selected.dispatch(report);
            } else {
                report_list.selectedIndex = -1;
            }
        }
    }
}
}
