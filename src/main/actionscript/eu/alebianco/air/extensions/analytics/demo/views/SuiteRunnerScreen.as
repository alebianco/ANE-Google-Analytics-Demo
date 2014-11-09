/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 13:29
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestResultVO;
import eu.alebianco.air.extensions.analytics.demo.views.api.IReportTestResults;

import feathers.controls.List;
import feathers.data.ListCollection;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.skins.StandardIcons;

import flash.utils.Dictionary;

import starling.textures.Texture;

public class SuiteRunnerScreen extends BaseBackScreen implements IReportTestResults {

    private var map:Dictionary = new Dictionary();

    private var results_list:List;

    public function addTest(test:Test):void {
        const vo:TestResultVO = new TestResultVO(test);
        map[test] = vo;
        results_list.dataProvider.addItem(vo);
    }

    public function updateResult(test:Test, success:Boolean, message:String, data:Array):void {
        const feedback:String = getRString.apply(this, [message].concat(data));

        const vo:TestResultVO = map[test] as TestResultVO;
        vo.complete(success, feedback);

        const index:int = results_list.dataProvider.getItemIndex(vo);
        results_list.dataProvider.updateItemAt(index);
    }

    override protected function initialize():void {
        super.initialize();

        results_list = createResultsList();
        addChild(results_list);
    }

    override public function dispose():void {
        removeChildren();

        results_list.dispose();
        results_list = null;

        super.dispose();
    }

    override protected function setupLayout():void {
        layout = new AnchorLayout();
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
        return list;
    }
}
}
