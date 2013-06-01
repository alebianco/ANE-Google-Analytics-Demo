/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 13/04/13 19.42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import eu.alebianco.air.extensions.analytics.demo.model.LayoutSettings;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;

import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.List;
import feathers.controls.Screen;
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

public class SettingsScreen extends Screen {

	[Inject]
	public var settings:LayoutSettings;

	[Inject]
	public var resources:ResourceBundle;

	private var _changed:ISignal;
	private var _completed:ISignal;

	private var header:Header;
	private var list:List;
	private var interval_box:ScrollContainer;

	private var back_btn:Button;
	private var manualDispatch_tgl:ToggleSwitch;
	private var intervalValue_lbl:Label;
	private var intervalDispatch_sld:Slider;
	private var debug_tgl:ToggleSwitch;
	private var optout_tgl:ToggleSwitch;

	public function get changed():ISignal {
		return _changed ||= new Signal();
	}

	public function get completed():ISignal {
		return _completed ||= new Signal();
	}

	private var _debug:Boolean;
	private var _dispatchInterval:int;
	private var _dispatchManually:Boolean;
	private var _optOut:Boolean;

	public function get debug():Boolean {
		return _debug;
	}
	public function set debug(value:Boolean):void {
		_debug = value;
		invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
	}
	public function get dispatchInterval():int {
		return _dispatchInterval;
	}
	public function set dispatchInterval(value:int):void {
		_dispatchInterval = value;
		invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
	}
	public function get dispatchManually():Boolean {
		return _dispatchManually;
	}
	public function set dispatchManually(value:Boolean):void {
		_dispatchManually = value;
		invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
	}
	public function get optOut():Boolean {
		return _optOut;
	}
	public function set optOut(value:Boolean):void {
		_optOut = value;
		invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
	}

	override protected function initialize():void {
		super.initialize();
		createHeader();
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
		super.initialize();
		header.width = this.actualWidth;
		header.validate();

		list.y = header.height;
		list.width = actualWidth;
		list.height = actualHeight - this.list.y;

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

	private function createContent():void {

		debug_tgl = new ToggleSwitch();
		debug_tgl.addEventListener(Event.CHANGE, debug_changeHandler);

		manualDispatch_tgl = new ToggleSwitch();
		manualDispatch_tgl.addEventListener(Event.CHANGE, manualDispatch_changeHandler);

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

		optout_tgl = new ToggleSwitch();
		optout_tgl.addEventListener(Event.CHANGE, optout_changeHandler);

		this.list = new List();
		this.list.isSelectable = false;
		this.list.dataProvider = new ListCollection(
				[
					{ label:resources.settings.debug.label, accessory:debug_tgl },
					{ label:resources.settings.optout.label, accessory:optout_tgl },
					{ label:resources.settings.manual.label, accessory:manualDispatch_tgl },
					{ label:resources.settings.interval.label, accessory:interval_box }
				]);

		this.addChild(this.list);
	}

	private function createHeader():void {
		back_btn = new Button();
		back_btn.label = resources.common.header.back.label;
		back_btn.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

		header = new Header();
		header.title = resources.home.settings.title;
		header.leftItems = new <DisplayObject>[back_btn];
		addChild(header);

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
