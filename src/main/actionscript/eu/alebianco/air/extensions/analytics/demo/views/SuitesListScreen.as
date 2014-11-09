/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:38
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.air.extensions.analytics.demo.views.api.IListTestSuites;

import feathers.controls.Button;
import feathers.controls.ButtonGroup;
import feathers.controls.Label;
import feathers.data.ListCollection;
import feathers.display.VerticalSpacer;
import feathers.layout.VerticalLayoutData;

import org.osflash.signals.Signal;

import starling.events.Event;

final public class SuitesListScreen extends BaseScreen implements IListTestSuites {

    private var info_lbl:Label;
    private var suites_group:ButtonGroup;

    private var _selected:Signal;

    public function get selected():Signal {
        return _selected ||= new Signal(TestSuite);
    }

    public function addSuite(item:TestSuite):void {
        suites_group.dataProvider.addItem(item);
    }

    override protected function initialize():void {
        super.initialize();

        info_lbl = createIntroLabel();
        suites_group = createSuitesList();

        addChild(info_lbl);
        addChild(new VerticalSpacer(48));
        addChild(suites_group);
    }

    override public function dispose():void {
        removeChildren();

        info_lbl.dispose();
        info_lbl = null;

        suites_group.dispose();
        suites_group.removeEventListener(Event.TRIGGERED, onSuiteSelected);
        suites_group = null;

        super.dispose();
    }

    private function createIntroLabel():Label {
        const label:Label = new Label();
        label.textRendererProperties.wordWrap = true;
        label.text = getRString("home.intro");
        label.layoutData = new VerticalLayoutData(100);
        return label;
    }

    private function createSuitesList():ButtonGroup {
        const group:ButtonGroup = new ButtonGroup();
        group.layoutData = new VerticalLayoutData(100);
        group.dataProvider = new ListCollection([]);
        group.buttonInitializer = function( button:Button, item:TestSuite ):void {
            button.label = getRString(item.name);
        };
        group.addEventListener(Event.TRIGGERED, onSuiteSelected);
        return group;
    }

    private function onSuiteSelected(event:Event, data:TestSuite):void {
       selected.dispatch(data);
    }
}
}
