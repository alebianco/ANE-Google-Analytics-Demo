/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 06/06/2013 10:27
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import eu.alebianco.air.extensions.analytics.demo.model.LayoutSettings;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;

import feathers.controls.Header;
import feathers.controls.Screen;
import feathers.controls.ScrollContainer;
import feathers.controls.Scroller;
import feathers.layout.IVirtualLayout;
import feathers.layout.VerticalLayout;

public class BaseScreen extends Screen {

	[Inject]
	public var settings:LayoutSettings;

	[Inject]
	public var resources:ResourceBundle;

	protected var header:Header;
	protected var container:ScrollContainer;

	override protected function initialize():void {
		createHeader();
		createContainer();
	}

	override protected function draw():void {
		header.width = actualWidth;
		header.validate();

		container.y = header.height;
		container.width = actualWidth
		container.height = actualHeight - container.y;
		container.validate();
	}

	protected function getContainerLayout():IVirtualLayout {
		const layout:VerticalLayout = new VerticalLayout();
		layout.gap = settings.gap;
		layout.paddingTop = settings.paddingTop;
		layout.paddingRight = settings.paddingRight;
		layout.paddingBottom = settings.paddingBottom;
		layout.paddingLeft = settings.paddingLeft;
		layout.horizontalAlign = settings.horizontalAlign;
		layout.verticalAlign = settings.verticalAlign;
		return layout;
	}

	protected function createContainer():void {
		container = new ScrollContainer();
		container.layout = getContainerLayout();
		container.verticalScrollPolicy = Scroller.SCROLL_POLICY_AUTO;
		container.snapScrollPositionsToPixels = true;
		addChild(container);
	}

	protected function createHeader():void {
		header = new Header();
		header.title = resources.home.title;
		addChild(header);
	}
}
}
