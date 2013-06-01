/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 13/04/13 19.42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.List;
import feathers.controls.Screen;
import feathers.data.ListCollection;
import feathers.skins.StandardIcons;

import starling.display.DisplayObject;
import starling.events.Event;
import starling.textures.Texture;

[Event(name="complete", type="starling.events.Event")]
[Event(name="showSettings", type="eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent")]
public class PageViewScreen extends Screen {

	private var _header:Header;
	private var _list:List;
	private var _backButton:Button;
	private var _settingsButton:Button;

	override protected function initialize():void {
		createHeader();
		createContent();
	}

	override protected function draw():void {
		this._header.width = this.actualWidth;
		this._header.validate();

		this._list.y = this._header.height;
		this._list.width = this.actualWidth;
		this._list.height = this.actualHeight - this._list.y;
	}

	private function createContent():void {
		this._list = new List();
		this._list.dataProvider = new ListCollection(
				[
					{ text:"Horizontal" },
					{ text:"Vertical" },
					{ text:"Tiled Rows" },
					{ text:"Tiled Columns" },
				]);
		this._list.itemRendererProperties.labelField = "text";
		this._list.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
		this._list.addEventListener(Event.CHANGE, list_changeHandler);
		this.addChild(this._list);
	}

	private function createHeader():void {
		this._backButton = new Button();
		this._backButton.label = "Back";
		this._backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

		this._settingsButton = new Button();
		this._settingsButton.label = "Settings";
		this._settingsButton.addEventListener(Event.TRIGGERED, settingsButton_triggeredHandler);

		this._header = new Header();
		this._header.title = "Vertical Layout";
		this.addChild(this._header);
		this._header.leftItems = new <DisplayObject>
				[
					this._backButton
				];
		this._header.rightItems = new <DisplayObject>
				[
					this._settingsButton
				];

		this.backButtonHandler = this.onBackButton;
	}

	private function accessorySourceFunction(item:Object):Texture {
		return StandardIcons.listDrillDownAccessoryTexture;
	}

	private function list_changeHandler(event:Event):void {
		const eventType:String = this._list.selectedItem.event as String;
		//this.dispatchEventWith(eventType);
	}

	private function onBackButton():void {
		this.dispatchEventWith(Event.COMPLETE);
	}

	private function backButton_triggeredHandler(event:Event):void {
		this.onBackButton();
	}

	private function settingsButton_triggeredHandler(event:Event):void {
		//this.dispatchEventWith(ShowScreenEvent.SHOW_SETTINGS);
	}
}
}
