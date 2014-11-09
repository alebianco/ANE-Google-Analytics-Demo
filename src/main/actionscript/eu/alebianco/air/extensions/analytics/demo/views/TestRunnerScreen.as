/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 13:29
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;
import eu.alebianco.air.extensions.analytics.demo.views.api.IReportTestResults;

import feathers.controls.List;
import feathers.data.ListCollection;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.skins.StandardIcons;

import starling.textures.Texture;

public class TestRunnerScreen extends BaseBackScreen implements IReportTestResults {

    private var results_list:List;

    public function appendResult(test:Test, success:Boolean, message:String, data:Array):void {
        const feedback:String = getRString.apply(this, [message].concat(data));
        results_list.dataProvider.addItem({test:test, success:success, feedback:feedback})
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
        list.itemRendererProperties.accessorySourceFunction = function(item:Object):Texture {
            return StandardIcons.listDrillDownAccessoryTexture;
        };
        list.itemRendererProperties.iconSourceFunction = function(item:Object):Texture {
            return assets.getTexture(item.success ? "success" : "failure");
        };
        list.itemRendererProperties.labelFunction = function(item:Object):String {
            return getRString(item.test.name) + "\n" + getRString(item.test.description);
        };
        return list;
    }
}
}
