/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.model.LayoutSettings;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;

import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.Screen;
import feathers.controls.ScrollContainer;
import feathers.controls.Scroller;
import feathers.controls.TextInput;
import feathers.core.FeathersControl;
import feathers.display.VerticalSpacer;
import feathers.layout.HorizontalLayout;
import feathers.layout.IVirtualLayout;
import feathers.layout.VerticalLayout;

import mx.utils.StringUtil;

import org.osflash.signals.Signal;

import starling.display.DisplayObject;
import starling.events.Event;

public class HomeScreen extends Screen {

	[Inject]
	public var settings:LayoutSettings;

	[Inject]
	public var resources:ResourceBundle;

	private var layout:IVirtualLayout;
	private var header:Header;
	private var container:ScrollContainer;

	private var settings_btn:Button;
	private var account_txt:TextInput;
	private var info_lbl:Label;

	private var version_lbl:Label;
	private var _accountChanged:Signal;
	private var _connectTriggered:Signal;

	private var _navigationRequested:Signal;
	private var _version:String;
	private var _account:String;
	private var connect_btn:Button;
	private var account_lbl:Label;

	public function get navigationRequested():Signal {
		return _navigationRequested ||= new Signal(DemoScreen);
	}

	public function get connectTriggered():Signal {
		return _connectTriggered ||= new Signal();
	}

	public function get accountChanged():Signal {
		return _accountChanged ||= new Signal();
	}

	public function set version(value:String):void {
		_version = value;
		invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
	}

	public function get account():String {
		return _account;
	}

	public function set account(value:String):void {
		_account = StringUtil.trim(value);
		invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
	}

	override protected function initialize():void {
		setupLayout();
		createContent();
		createHeader();
	}

	override public function invalidate(flag:String = "all"):void {
		super.invalidate(flag);
		if (flag == FeathersControl.INVALIDATION_FLAG_DATA) {
			account_txt.text = _account;
			version_lbl.text = _version;
		}
	}

	override protected function draw():void {
		header.width = actualWidth;
		header.validate();

		container.y = header.height;
		container.width = actualWidth;
		container.height = actualHeight - container.y;

		info_lbl.width = container.width - settings.paddingLeft - settings.paddingRight;
	}

	override public function dispose():void {
		super.dispose();

		account_txt.addEventListener(Event.CHANGE, account_changeHandler);
		connect_btn.addEventListener(Event.TRIGGERED, connect_triggerHandler);
		settings_btn.addEventListener(Event.TRIGGERED, settings_triggeredHandler);
	}
	private function setupLayout():void {
		const layout:VerticalLayout = new VerticalLayout();
		layout.gap = settings.gap;
		layout.paddingTop = settings.paddingTop;
		layout.paddingRight = settings.paddingRight;
		layout.paddingBottom = settings.paddingBottom;
		layout.paddingLeft = settings.paddingLeft;
		layout.horizontalAlign = settings.horizontalAlign;
		layout.verticalAlign = settings.verticalAlign;
		this.layout = layout;
	}

	private function createContent():void {
		container = new ScrollContainer();
		container.layout = layout;
		container.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_AUTO;
		container.scrollerProperties.snapScrollPositionsToPixels = true;
		addChild(container);

		version_lbl = new Label();
		container.addChild(version_lbl);

		info_lbl = new Label();
		info_lbl.text = resources.home.intro;
		info_lbl.textRendererProperties.wordWrap = true;
		container.addChild(info_lbl);
		container.addChild(new VerticalSpacer(48 * dpiScale));

		account_lbl = new Label();
		account_lbl.text = resources.home.account.label;

		account_txt = new TextInput();
		account_txt.addEventListener(Event.CHANGE, account_changeHandler);

		connect_btn = new Button();
		connect_btn.label = resources.home.connect.label;
		connect_btn.addEventListener(Event.TRIGGERED, connect_triggerHandler);

		const connectGroup:ScrollContainer = new ScrollContainer();
		connectGroup.layout = new HorizontalLayout();
		HorizontalLayout(connectGroup.layout).gap = 4;
		HorizontalLayout(connectGroup.layout).verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
		connectGroup.addChild(account_lbl);
		connectGroup.addChild(account_txt);
		connectGroup.addChild(connect_btn);

		container.addChild(connectGroup);
	}

	private function createHeader():void {
		settings_btn = new Button();
		settings_btn.label = resources.home.settings.label;
		settings_btn.addEventListener(Event.TRIGGERED, settings_triggeredHandler);

		header = new Header();
		header.title = resources.home.title;
		addChild(header);

		header.rightItems = new <DisplayObject>[settings_btn];
	}

	private function connect_triggerHandler(event:Event):void {
		connectTriggered.dispatch()
	}

	private function account_changeHandler(event:Event):void {
		account = account_txt.text;
		accountChanged.dispatch()
	}

	private function settings_triggeredHandler(event:Event):void {
		navigationRequested.dispatch(DemoScreen.SETTINGS);
	}
}
}
