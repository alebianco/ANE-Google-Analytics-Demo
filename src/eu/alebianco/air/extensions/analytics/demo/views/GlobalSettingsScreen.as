/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 13/04/13 19.42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import eu.alebianco.air.extensions.analytics.demo.views.api.IManageGlobalSettings;

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.List;
import feathers.controls.ScrollContainer;
import feathers.controls.Slider;
import feathers.controls.ToggleSwitch;
import feathers.core.FeathersControl;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.DisplayObject;
import starling.events.Event;

public class GlobalSettingsScreen extends BaseScreen implements IManageGlobalSettings {

    private var _changed:ISignal;
    private var _completed:ISignal;

    private var _list:List;
    protected var interval_box:ScrollContainer;

    protected var back_btn:Button;
    protected var manualDispatch_tgl:ToggleSwitch;
    protected var intervalValue_lbl:Label;
    protected var intervalDispatch_sld:Slider;
    protected var debug_tgl:ToggleSwitch;
    protected var optout_tgl:ToggleSwitch;

    private var _debug:Boolean;
    private var _dispatchInterval:int;
    private var _dispatchManually:Boolean;
    private var _optOut:Boolean;

    public function get changed():ISignal {
        return _changed ||= new Signal();
    }

    public function get completed():ISignal {
        return _completed ||= new Signal();
    }

    public function get debug():Boolean {
        return _debug;
    }

    public function set debug(value:Boolean):void {
        if (_debug != value) {
            _debug = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function get dispatchInterval():int {
        return _dispatchInterval;
    }

    public function set dispatchInterval(value:int):void {
        if (_dispatchInterval != value) {
            _dispatchInterval = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function get dispatchManually():Boolean {
        return _dispatchManually;
    }

    public function set dispatchManually(value:Boolean):void {
        if (_dispatchManually != value) {
            _dispatchManually = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function get optOut():Boolean {
        return _optOut;
    }

    public function set optOut(value:Boolean):void {
        if (_optOut != value) {
            _optOut = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    protected function get list():FeathersControl {
        return _list;
    }

    override protected function initialize():void {
        super.initialize();
        createContent();
    }

    override public function invalidate(flag:String = "all"):void {
        super.invalidate(flag);
        if (flag == FeathersControl.INVALIDATION_FLAG_DATA) {
            debug_tgl.isSelected = _debug;
            manualDispatch_tgl.isSelected = _dispatchManually;
            intervalDispatch_sld.value = _dispatchInterval;
            intervalDispatch_sld.isEnabled = !_dispatchManually;
            intervalValue_lbl.text = _dispatchInterval.toString();
            optout_tgl.isSelected = _optOut;
        }
    }

    override protected function draw():void {
        super.draw();

        list.height = container.height;
        list.validate();

        intervalValue_lbl.validate();
        intervalDispatch_sld.validate();

        interval_box.validate();
    }

    override public function dispose():void {
        super.dispose();

        debug_tgl.removeEventListener(Event.CHANGE, debug_changeHandler);
        manualDispatch_tgl.removeEventListener(Event.CHANGE, manualDispatch_changeHandler);
        intervalDispatch_sld.removeEventListener(Event.CHANGE, intervalDispatch_changeHandler);
        optout_tgl.removeEventListener(Event.CHANGE, optout_changeHandler);
        back_btn.removeEventListener(Event.TRIGGERED, backButton_triggeredHandler);
    }

    protected function createContent():void {
        _list = new List();
        _list.isSelectable = false;
        _list.dataProvider = new ListCollection(createControls());
        container.addChild(_list);
    }

    protected function createControls():Array {
        return [
            { label: resources.settings.global.properties.debug, accessory: createDebugControl() },
            { label: resources.settings.global.properties.optout, accessory: createOptoutControl() },
            { label: resources.settings.global.properties.manual, accessory: createManualDispatchControl() },
            { label: resources.settings.global.properties.interval, accessory: createIntervalDispatchControl() }
        ];
    }

    protected function createOptoutControl():FeathersControl {
        optout_tgl = new ToggleSwitch();
        optout_tgl.addEventListener(Event.CHANGE, optout_changeHandler);
        return optout_tgl;
    }

    protected function createIntervalDispatchControl():FeathersControl {
        interval_box = new ScrollContainer();
        interval_box.layout = new HorizontalLayout();
        HorizontalLayout(interval_box.layout).gap = 4;
        HorizontalLayout(interval_box.layout).verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;

        intervalDispatch_sld = new Slider();
        intervalDispatch_sld.minimum = 0;
        intervalDispatch_sld.maximum = 300;
        intervalDispatch_sld.step = 5;
        intervalDispatch_sld.page = 30;
        intervalDispatch_sld.addEventListener(Event.CHANGE, intervalDispatch_changeHandler);
        interval_box.addChild(intervalDispatch_sld);

        intervalValue_lbl = new Label();
        interval_box.addChild(intervalValue_lbl);

        return interval_box;
    }

    protected function createManualDispatchControl():FeathersControl {
        manualDispatch_tgl = new ToggleSwitch();
        manualDispatch_tgl.addEventListener(Event.CHANGE, manualDispatch_changeHandler);
        return manualDispatch_tgl;
    }

    protected function createDebugControl():FeathersControl {
        debug_tgl = new ToggleSwitch();
        debug_tgl.addEventListener(Event.CHANGE, debug_changeHandler);

        return debug_tgl;
    }

    override protected function createHeader():void {
        super.createHeader();
        header.title = resources.settings.title;
        back_btn = new Button();
        back_btn.label = resources.common.header.back.label;
        back_btn.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
        header.leftItems = new <DisplayObject>[back_btn];

        backButtonHandler = this.onBackButton;
    }

    private function optout_changeHandler(event:Event):void {
        optOut = optout_tgl.isSelected;
        changed.dispatch();
    }

    private function intervalDispatch_changeHandler(event:Event):void {
        dispatchInterval = intervalDispatch_sld.value;
        changed.dispatch();
    }

    private function manualDispatch_changeHandler(event:Event):void {
        dispatchManually = manualDispatch_tgl.isSelected;
        changed.dispatch();
    }

    private function debug_changeHandler(event:Event):void {
        debug = debug_tgl.isSelected;
        changed.dispatch();
    }

    private function onBackButton():void {
        completed.dispatch();
    }

    private function backButton_triggeredHandler(event:Event):void {
        this.onBackButton();
    }
}
}
