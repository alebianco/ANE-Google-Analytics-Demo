/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import eu.alebianco.air.extensions.analytics.demo.model.LayoutSettings;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;

import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.Screen;
import feathers.controls.ScrollContainer;
import feathers.controls.Scroller;
import feathers.display.VerticalSpacer;
import feathers.layout.IVirtualLayout;
import feathers.layout.VerticalLayout;

import flash.text.TextFormat;

import flash.text.TextFormatAlign;

public class UnsupportedScreen extends Screen {

	[Inject]
    public var settings:LayoutSettings;

	[Inject]
    public var resources:ResourceBundle;

    private var layout:IVirtualLayout;
    private var header:Header;
    private var container:ScrollContainer;

    private var version_lbl:Label;
    private var info_lbl:Label;
    private var support_lbl:Label;

    public function set version(value:String):void {
        version_lbl.text = value;
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
        container.width = actualWidth
        container.height = actualHeight - container.y;

        info_lbl.width = container.width - settings.paddingLeft - settings.paddingRight;

        support_lbl.width = info_lbl.width;
        support_lbl.textRendererProperties.textFormat = new TextFormat("Arial", 24 * dpiScale, 0xcc0000, true, false, false, null, null, TextFormatAlign.CENTER);
    }

    private function createContent():void {
        container = new ScrollContainer();
        container.layout = layout;
        container.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_AUTO;
        container.scrollerProperties.snapScrollPositionsToPixels = true;

        version_lbl = new Label();
        container.addChild(version_lbl);

        info_lbl = new Label();
        info_lbl.text = resources.home.intro;
        info_lbl.textRendererProperties.wordWrap = true;
        container.addChild(info_lbl);

        container.addChild(new VerticalSpacer(48 * dpiScale));

        support_lbl = new Label();
        support_lbl.textRendererProperties.embedFonts = false;
        support_lbl.textRendererProperties.wordWrap = true;
        support_lbl.text = resources.common.errors.unsupportedplatform;
        container.addChild(support_lbl);

        addChild(container);
    }

    private function createHeader():void {
        header = new Header();
        header.title = resources.home.title;
        addChild(header);
    }
}
}
