/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 20/06/2013 15:10
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import eu.alebianco.air.extensions.analytics.demo.views.api.ITrackViews;

import feathers.controls.TextInput;
import feathers.core.FeathersControl;

import mx.utils.StringUtil;

import starling.events.Event;

public class TrackViewScreen extends TrackBaseScreen implements ITrackViews {

	private var _screen:String;

	public function get screen():String {
		return _screen || "";
	}

	override protected function createContent():void {
		super.createContent();
		info_lbl.text = resources.tracker.view.info;
		addFormField(resources.tracker.view.fields.name, createScreenNameField());
	}

	private function createScreenNameField():FeathersControl {
		var fld:TextInput = new TextInput();
		fld.addEventListener(Event.CHANGE, function (event:Event):void {
			_screen = StringUtil.trim(TextInput(event.target).text);
		});
		return fld;
	}

	override protected function createHeader():void {
		super.createHeader();
		header.title = resources.tracker.view.title;
	}
}
}
