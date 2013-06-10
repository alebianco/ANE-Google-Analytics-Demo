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
import eu.alebianco.air.extensions.analytics.demo.views.api.IBuildTrackers;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayVersion;
import eu.alebianco.air.extensions.analytics.demo.views.api.INavigateScreens;

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.core.FeathersControl;
import feathers.display.VerticalSpacer;
import feathers.layout.HorizontalLayout;

import mx.utils.StringUtil;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.DisplayObject;
import starling.events.Event;

final public class HomeScreen extends BaseScreen implements IDisplayVersion, IBuildTrackers, INavigateScreens {

	private var settings_btn:Button;
	private var account_txt:TextInput;
	private var info_lbl:Label;

	private var version_lbl:Label;
	private var _accountChanged:ISignal;
	private var _connectTriggered:ISignal;

	private var _navigationRequested:ISignal;
	private var _version:String;
	private var _account:String;
	private var connect_btn:Button;

	public function get navigationRequested():ISignal {
		return _navigationRequested ||= new Signal(DemoScreen);
	}

	public function get connectTriggered():ISignal {
		return _connectTriggered ||= new Signal();
	}

	public function get accountChanged():ISignal {
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
        super.initialize();
        createContent();
    }

	override public function invalidate(flag:String = "all"):void {
		super.invalidate(flag);
		if (flag == FeathersControl.INVALIDATION_FLAG_DATA) {
			account_txt.text = _account;
			version_lbl.text = _version;
		}
	}

	override protected function draw():void {
		super.draw();
		info_lbl.width = container.width - settings.paddingLeft - settings.paddingRight;
	}

	override public function dispose():void {
		super.dispose();
		account_txt.addEventListener(Event.CHANGE, account_changeHandler);
		connect_btn.addEventListener(Event.TRIGGERED, connect_triggerHandler);
		settings_btn.addEventListener(Event.TRIGGERED, settings_triggeredHandler);
	}

	private function createContent():void {
        version_lbl = new Label();
        container.addChild(version_lbl);

        info_lbl = new Label();
        info_lbl.text = resources.home.intro;
        info_lbl.textRendererProperties.wordWrap = true;
        container.addChild(info_lbl);
        container.addChild(new VerticalSpacer(48 * dpiScale));

        const account_lbl:Label = new Label();
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

	override protected function createHeader():void {
        super.createHeader();

        settings_btn = new Button();
        settings_btn.label = resources.home.settings.label;
        settings_btn.addEventListener(Event.TRIGGERED, settings_triggeredHandler);
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
