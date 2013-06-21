/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 17/06/2013 12:56
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.views.api.IManageTrackerSettings;

import feathers.controls.GroupedList;
import feathers.controls.Label;
import feathers.controls.ScrollContainer;
import feathers.controls.Slider;
import feathers.controls.ToggleSwitch;
import feathers.core.FeathersControl;
import feathers.data.HierarchicalCollection;
import feathers.layout.HorizontalLayout;

import starling.events.Event;

public class TrackerSettingsScreen extends GlobalSettingsScreen implements IManageTrackerSettings {

    private var _list:GroupedList;

    private var session_box:ScrollContainer;
    private var session_sld:Slider;
    private var secure_tgl:ToggleSwitch;
    private var session_lbl:Label;
    private var sampleRate_box:ScrollContainer;
    private var sampleRate_sld:Slider;
    private var sampleRate_lbl:Label;
    private var anonymous_tgl:ToggleSwitch;

    private var _sessionTimeout:uint;
    private var _secure:Boolean;
    private var _sampleRate:uint;
    private var _anonymous:Boolean;

    public function get sessionTimeout():uint {
        return _sessionTimeout;
    }

    public function set sessionTimeout(value:uint):void {
        if (_sessionTimeout != value) {
            _sessionTimeout = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function get secure():Boolean {
        return _secure;
    }

    public function set secure(value:Boolean):void {
        if (_secure != value) {
            _secure = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function get sampleRate():uint {
        return _sampleRate;
    }

    public function set sampleRate(value:uint):void {
        if (_sampleRate != value) {
            _sampleRate = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function get anonymous():Boolean {
        return _anonymous;
    }

    public function set anonymous(value:Boolean):void {
        if (_anonymous != value) {
            _anonymous = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    override protected function get list():FeathersControl {
        return _list;
    }

    override public function invalidate(flag:String = "all"):void {
        super.invalidate(flag);
        if (flag == FeathersControl.INVALIDATION_FLAG_DATA) {
            session_sld.value = _sessionTimeout;
            session_lbl.text = _sessionTimeout.toString();
            secure_tgl.isSelected = _secure;
            sampleRate_sld.value = _sampleRate;
            sampleRate_lbl.text = _sampleRate.toString();
            anonymous_tgl.isSelected = _anonymous;
        }
    }

    override protected function draw():void {
        super.draw();

        sampleRate_sld.validate();
        session_sld.validate();

        sampleRate_box.validate();
        session_box.validate();
    }

    override public function dispose():void {
        super.dispose();

        session_sld.removeEventListener(Event.CHANGE, session_changeHandler);
        secure_tgl.removeEventListener(Event.CHANGE, secure_changeHandler);
        sampleRate_sld.removeEventListener(Event.CHANGE, sample_changeHandler);
        anonymous_tgl.removeEventListener(Event.CHANGE, anonymous_changeHandler);
    }

    override protected function createContent():void {
        _list = new GroupedList();
        _list.isSelectable = false;
        _list.dataProvider = new HierarchicalCollection(createControls());
        container.addChild(_list);
    }

    override protected function createControls():Array {

        return [
            {
                header: resources.settings.global.title,
                children: super.createControls()
            },
            {
                header: resources.settings.tracker.title,
                children: [
                    { label: resources.settings.tracker.properties.anonymous, accessory: createAnonymousControl() },
                    { label: resources.settings.tracker.properties.samplerate, accessory: createSampleRateControl() },
                    { label: resources.settings.tracker.properties.secure, accessory: createSecureControl() },
                    { label: resources.settings.tracker.properties.session, accessory: createSessionTimeoutControl() }
                ]
            }
        ]
    }

    private function createSessionTimeoutControl():FeathersControl {
        session_box = new ScrollContainer();
        session_box.layout = new HorizontalLayout();
        HorizontalLayout(session_box.layout).gap = 4;
        HorizontalLayout(session_box.layout).verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;

        session_sld = new Slider();
        session_sld.minimum = 0;
        session_sld.maximum = 100;
        session_sld.step = 5;
        session_sld.page = 10;
        session_sld.addEventListener(Event.CHANGE, session_changeHandler);
        session_box.addChild(session_sld);

        session_lbl = new Label();
        session_box.addChild(session_lbl);

        return session_box;
    }

    private function createSecureControl():FeathersControl {
        secure_tgl = new ToggleSwitch();
        secure_tgl.addEventListener(Event.CHANGE, secure_changeHandler);
        return secure_tgl;
    }

    private function createSampleRateControl():FeathersControl {
        sampleRate_box = new ScrollContainer();
        sampleRate_box.layout = new HorizontalLayout();
        HorizontalLayout(sampleRate_box.layout).gap = 4;
        HorizontalLayout(sampleRate_box.layout).verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;

        sampleRate_sld = new Slider();
        sampleRate_sld.minimum = 0;
        sampleRate_sld.maximum = 100;
        sampleRate_sld.step = 5;
        sampleRate_sld.page = 10;
        sampleRate_sld.addEventListener(Event.CHANGE, sample_changeHandler);
        sampleRate_box.addChild(sampleRate_sld);

        sampleRate_lbl = new Label();
        sampleRate_box.addChild(sampleRate_lbl);

        return sampleRate_box;
    }

    private function createAnonymousControl():FeathersControl {
        anonymous_tgl = new ToggleSwitch();
        anonymous_tgl.addEventListener(Event.CHANGE, anonymous_changeHandler);
        return anonymous_tgl;
    }

    private function session_changeHandler(event:Event):void {
        sessionTimeout = session_sld.value;
        changed.dispatch();
    }

    private function secure_changeHandler(event:Event):void {
        secure = secure_tgl.isSelected;
        changed.dispatch();
    }

    private function sample_changeHandler(event:Event):void {
        sampleRate = sampleRate_sld.value;
        changed.dispatch();
    }

    private function anonymous_changeHandler(event:Event):void {
        anonymous = anonymous_tgl.isSelected;
        changed.dispatch();
    }

    override protected function onBackButton():void {
        navigationRequested.dispatch(DemoScreen.TRACKER_INFO);
    }
}
}
