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

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.ScrollContainer;
import feathers.controls.Scroller;
import feathers.core.FeathersControl;
import feathers.layout.TiledRowsLayout;

import mx.utils.StringUtil;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.DisplayObject;
import starling.events.Event;

public class TrackerInfoScreen extends BaseScreen implements IManageTracker, INavigateScreens {

    private var _disconnectButton:Button;
    private var _settingsButton:Button;

    private var _disconnectTriggered:ISignal;
    private var _navigationRequested:ISignal;

    private var action_btns:ScrollContainer;

    private var _appID:String = "";
    private var _appName:String = "";
    private var _appVersion:String = "";
    private var _trackerID:String = "";

    private var info_lbl:Label;

    public function set appID(value:String):void {
        if (_appID != value) {
            _appID = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function set appName(value:String):void {
        if (_appName != value) {
            _appName = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function set appVersion(value:String):void {
        if (_appVersion != value) {
            _appVersion = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function set trackerID(value:String):void {
        if (_trackerID != value) {
            _trackerID = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

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

    override public function invalidate(flag:String = "all"):void {
        super.invalidate(flag);
        if (flag == FeathersControl.INVALIDATION_FLAG_DATA) {
            info_lbl.text = StringUtil.substitute(resources.tracker.home.info, _appID, _appName, _appVersion, _trackerID);
        }
    }

    override public function dispose():void {
        super.dispose();
        for (var n:int = 0; n < action_btns.numChildren; n++) {
            var button:Button = action_btns.getChildAt(n) as Button;
            button.removeEventListeners(Event.TRIGGERED);
        }
    }

    override protected function draw():void {
        super.draw();

        info_lbl.width = container.width - settings.paddingLeft - settings.paddingRight;
        action_btns.width = container.width - settings.paddingLeft - settings.paddingRight;
        action_btns.height = container.height - (info_lbl.y + info_lbl.height) - settings.paddingTop - settings.paddingBottom;
    }

    private function createContent():void {

        info_lbl = new Label();
        info_lbl.textRendererProperties.wordWrap = true;
        container.addChild(info_lbl);

        const layout:TiledRowsLayout = new TiledRowsLayout();
        layout.paddingTop = 20;
        layout.paddingRight = 15;
        layout.paddingBottom = 10;
        layout.paddingLeft = 15;
        layout.gap = 12;
        layout.verticalGap = 12;
        layout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
        layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_JUSTIFY;
        layout.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_MIDDLE;

        action_btns = new ScrollContainer();
        action_btns.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
        action_btns.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
        action_btns.layout = layout;

        for each (var action:TrackerAction in TrackerAction.getConstants()) {
            const button:Button = new Button();
            button.label = resources.tracker.home.action[action.name.toLowerCase()];
            button.addEventListener(Event.TRIGGERED, buildActionButtonHandler(DemoScreen.parseConstant(action.name)));
            action_btns.addChild(button);
        }

        container.addChild(action_btns);

        // TODO add dispatch button if manual dispatch
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
