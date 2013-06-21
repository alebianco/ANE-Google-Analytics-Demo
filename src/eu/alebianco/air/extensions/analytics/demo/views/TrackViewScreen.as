/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 20/06/2013 15:10
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.views.api.INavigateScreens;
import eu.alebianco.air.extensions.analytics.demo.views.api.ITrackViews;

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.ScrollContainer;
import feathers.controls.Scroller;
import feathers.controls.TextInput;
import feathers.core.FeathersControl;

import mx.utils.StringUtil;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.DisplayObject;
import starling.events.Event;

public class TrackViewScreen extends BaseScreen implements INavigateScreens, ITrackViews {


    private var _navigationRequested:ISignal;
    private var _track:ISignal;
    private var _change:ISignal;

    private var back_btn:Button;
    private var info_lbl:Label;
    private var name_row:ScrollContainer;
    private var name_lbl:Label;
    private var name_fld:TextInput;
    private var track_btn:Button;

    private var _enabled:Boolean;

    public function get navigationRequested():ISignal {
        return _navigationRequested ||= new Signal(DemoScreen);
    }

    public function get track():ISignal {
        return _track ||= new Signal();
    }

    public function get change():ISignal {
        return _change ||= new Signal();
    }

    public function get screenName():String {
        return (isInitialized) ? StringUtil.trim(name_fld.text) : "";
    }

    public function get enabled():Boolean {
        return _enabled;
    }

    public function set enabled(value:Boolean):void {
        if (_enabled != value) {
            _enabled = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    override protected function initialize():void {
        super.initialize();
        createContent();
    }

    override public function dispose():void {
        super.dispose();
    }

    override public function invalidate(flag:String = "all"):void {
        super.invalidate(flag);
        if (flag == FeathersControl.INVALIDATION_FLAG_DATA) {
            track_btn.isEnabled = _enabled;
        }
    }

    override protected function draw():void {
        super.draw();

        track_btn.validate();
        track_btn.y = container.height - track_btn.height - settings.paddingBottom;
    }

    private function createContent():void {

        info_lbl = new Label();
        info_lbl.text = resources.tracker.view.info;
        container.addChild(info_lbl);

        name_row = new ScrollContainer();
        name_row.layout = getFormFieldLayout();
        container.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
        container.addChild(name_row);

        name_lbl = new Label();
        name_lbl.text = resources.tracker.view.fields.name;
        name_row.addChild(name_lbl);

        name_fld = new TextInput();
        name_fld.addEventListener(Event.CHANGE, name_changeHandler);
        name_row.addChild(name_fld);

        track_btn = new Button();
        track_btn.label = resources.tracker.common.track.label;
        track_btn.addEventListener(Event.TRIGGERED, track_triggeredHandler);
        container.addChild(track_btn);
    }

    private function name_changeHandler(event:Event):void {
        change.dispatch();
    }

    private function track_triggeredHandler(event:Event):void {
        track.dispatch();
    }

    override protected function createHeader():void {

        super.createHeader();
        header.title = resources.tracker.view.title;

        back_btn = new Button();
        back_btn.label = resources.common.header.back.label;
        back_btn.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
        header.leftItems = new <DisplayObject>[this.back_btn];

        this.backButtonHandler = this.onBackButton;
    }

    private function backButton_triggeredHandler(event:Event):void {
        onBackButton();
    }

    private function onBackButton():void {
        navigationRequested.dispatch(DemoScreen.TRACKER_INFO);
    }
}
}
