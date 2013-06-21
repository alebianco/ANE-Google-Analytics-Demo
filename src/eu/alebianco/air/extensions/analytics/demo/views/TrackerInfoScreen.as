/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 13/04/13 19.42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.model.TrackerAction;
import eu.alebianco.air.extensions.analytics.demo.views.api.IManageTracker;
import eu.alebianco.air.extensions.analytics.demo.views.api.INavigateScreens;
import eu.alebianco.utils.VectorUtils;

import feathers.controls.Button;
import feathers.controls.ButtonGroup;
import feathers.data.ListCollection;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.DisplayObject;
import starling.events.Event;

public class TrackerInfoScreen extends BaseScreen implements IManageTracker, INavigateScreens {

    private var _disconnectButton:Button;
    private var _settingsButton:Button;

    private var _disconnectTriggered:ISignal;
    private var _navigationRequested:ISignal;

    private var action_btns:ButtonGroup;

    public function get navigationRequested():ISignal {
        return _navigationRequested ||= new Signal(DemoScreen);
    }

    public function get disconnectTriggered():ISignal {
        return _disconnectTriggered ||= new Signal();
    }

    override protected function initialize():void {
        super.initialize();
        createContent();
    }

    override public function dispose():void {
        super.dispose();
    }

    override protected function draw():void {
        super.draw();
    }

    private function createContent():void {
        action_btns = new ButtonGroup();
        action_btns.direction = ButtonGroup.DIRECTION_HORIZONTAL;
        action_btns.gap = 4;
        action_btns.dataProvider = new ListCollection(buildActionsList());
        container.addChild(action_btns);
    }

    override protected function createHeader():void {

        super.createHeader();
        header.title = resources.tracker.home.title;

        _disconnectButton = new Button();
        _disconnectButton.label = resources.tracker.home.disconnect.label;
        _disconnectButton.addEventListener(Event.TRIGGERED, disconnectButton_triggeredHandler);
        header.leftItems = new <DisplayObject>[this._disconnectButton];

        _settingsButton = new Button();
        _settingsButton.label = resources.common.header.settings.label;
        _settingsButton.addEventListener(Event.TRIGGERED, settingsButton_triggeredHandler);
        header.rightItems = new <DisplayObject>[this._settingsButton];

        this.backButtonHandler = this.onBackButton;
    }

    private function buildActionsList():Array {
        const consts:Array = VectorUtils.toArray(TrackerAction.getConstants());
        const list:Array = consts.map(function (item:TrackerAction, index:int, list:Array):Object {
            return {
                label: resources.tracker.home.action[item.name.toLowerCase()],
                triggered: buildActionButtonHandler(DemoScreen.parseConstant(item.name))
            };
        });
        return list;
    }

    private function buildActionButtonHandler(target:DemoScreen):Function {
        return function (event:Event):void {
            navigationRequested.dispatch(target);
        }
    }

    private function onBackButton():void {
        disconnectTriggered.dispatch();
        this.dispatchEventWith(Event.COMPLETE);
    }

    private function disconnectButton_triggeredHandler(event:Event):void {
        this.onBackButton();
    }

    private function settingsButton_triggeredHandler(event:Event):void {
        navigationRequested.dispatch(DemoScreen.TRACKER_SETTINGS);
    }
}
}
