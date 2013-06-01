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

    private var account_txt:TextInput;
    private var info_lbl:Label;
    private var version_lbl:Label;

    private var _accountChanged:Signal;
    private var _connectTriggered:Signal;
    private var _navigationRequested:Signal;

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
        version_lbl.text = value;
    }

    public function get account():String {
        return StringUtil.trim(account_txt.text);
    }

    public function set account(value:String):void {
        account_txt.text = value;
    }

    override protected function initialize():void {
        setupLayout();
        createContent();
        createHeader();
    }

    private function setupLayout():void {
        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = settings.gap;
        layout.paddingTop = settings.paddingTop;
        layout.paddingRight = settings.paddingRight;
        layout.paddingBottom = settings.paddingBottom;
        layout.paddingLeft = settings.paddingLeft;
        layout.horizontalAlign = settings.horizontalAlign;
        layout.verticalAlign = settings.verticalAlign;
        this.layout = layout;
    }

    override protected function draw():void {
        header.width = actualWidth;
        header.validate();

        container.y = header.height;
        container.width = actualWidth;
        container.height = actualHeight - container.y;

        info_lbl.width = container.width - settings.paddingLeft - settings.paddingRight;
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

        var account_lbl:Label = new Label();
        account_lbl.text = resources.home.account.label;

        account_txt = new TextInput();
        account_txt.addEventListener(Event.CHANGE, account_changeHandler);
        account_txt.text = resources.common.account;

        var connect:Button = new Button();
        connect.label = resources.home.connect.label;
        connect.addEventListener(Event.TRIGGERED, connect_triggerHandler);

        var connectGroup:ScrollContainer = new ScrollContainer();
        connectGroup.layout = new HorizontalLayout();
        HorizontalLayout(connectGroup.layout).gap = 4;
        HorizontalLayout(connectGroup.layout).verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
        connectGroup.addChild(account_lbl);
        connectGroup.addChild(account_txt);
        connectGroup.addChild(connect);

        container.addChild(connectGroup);
    }

    private function createHeader():void {
        var settings:Button = new Button();
        settings.label = resources.home.settings.label;
        settings.addEventListener(Event.TRIGGERED, settings_triggeredHandler);

        header = new Header();
        header.title = resources.home.title;
        addChild(header);

        header.rightItems = new <DisplayObject>[settings];
    }

    private function connect_triggerHandler(event:Event):void {
        connectTriggered.dispatch()
    }

    private function account_changeHandler(event:Event):void {
        accountChanged.dispatch()
    }

    private function settings_triggeredHandler(event:Event):void {
        navigationRequested.dispatch(DemoScreen.SETTINGS);
    }
}
}
