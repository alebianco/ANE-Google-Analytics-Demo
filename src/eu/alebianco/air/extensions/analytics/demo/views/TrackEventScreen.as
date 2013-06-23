/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/06/2013 15:38
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import eu.alebianco.air.extensions.analytics.demo.views.api.ITrackEvent;

import feathers.controls.NumericStepper;
import feathers.controls.ScrollContainer;
import feathers.controls.Scroller;
import feathers.controls.TextInput;
import feathers.controls.ToggleSwitch;
import feathers.core.FeathersControl;

import starling.events.Event;

public class TrackEventScreen extends TrackBaseScreen implements ITrackEvent {

	private var _category:String;
	private var _action:String;
	private var _label:String;
	private var _value:int;
	private var _hasLabel:Boolean;
	private var _hasValue:Boolean;

	public function get category():String {
		return _category || "";
	}

	public function get action():String {
		return _action || "";
	}

	public function get label():String {
		return _label || "";
	}

	public function get value():int {
		return _value;
	}

	public function get hasLabel():Boolean {
		return _hasLabel;
	}

	public function get hasValue():Boolean {
		return _hasValue;
	}

	override protected function createContent():void {
		super.createContent();
		info_lbl.text = resources.tracker.event.info;
		addFormField(resources.tracker.event.fields.category, createCategoryField());
		addFormField(resources.tracker.event.fields.action, createActionField());
		addFormField(resources.tracker.event.fields.label, createLabelField());
		addFormField(resources.tracker.event.fields.value, createValueField());
	}

	private function createCategoryField():FeathersControl {
		const txt:TextInput = new TextInput();
		txt.addEventListener(Event.CHANGE, function (event:Event):void {
			_category = txt.text;
		});
		return txt;
	}

	private function createActionField():FeathersControl {
		const txt:TextInput = new TextInput();
		txt.addEventListener(Event.CHANGE, function (event:Event):void {
			_action = txt.text;
		});
		return txt;
	}

	private function createLabelField():FeathersControl {
		const field:ScrollContainer = new ScrollContainer();
		field.layout = getFormFieldLayout();
		field.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
		field.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;

		const txt:TextInput = new TextInput();
		txt.isEnabled = false;
		txt.addEventListener(Event.CHANGE, function (event:Event):void {
			_label = txt.text;
			field.dispatchEvent(event);
		});
		field.addChild(txt);

		const chk:ToggleSwitch = new ToggleSwitch();
		chk.addEventListener(Event.CHANGE, function (event:Event):void {
			_hasValue = chk.isSelected;
			txt.isEnabled = chk.isSelected;
			_label = txt.text;
			field.dispatchEvent(event);
		});
		field.addChild(chk);

		return field;
	}

	private function createValueField():FeathersControl {

		const field:ScrollContainer = new ScrollContainer();
		field.layout = getFormFieldLayout();
		field.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
		field.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;

		const num:NumericStepper = new NumericStepper();
		num.minimum = 1;
		num.maximum = 100;
		num.step = 1;
		num.value = 1;
		num.isEnabled = false;
		num.width = 260;
		num.addEventListener(Event.CHANGE, function (event:Event):void {
			_value = num.value;
			field.dispatchEvent(event);
		});
		field.addChild(num);

		const chk:ToggleSwitch = new ToggleSwitch();
		chk.addEventListener(Event.CHANGE, function (event:Event):void {
			_hasValue = chk.isSelected;
			num.isEnabled = chk.isSelected;
			_value = num.value;
			field.dispatchEvent(event);
		});
		field.addChild(chk);

		return field;
	}

	override protected function createHeader():void {
		super.createHeader();
		header.title = resources.tracker.event.title;
	}
}
}
