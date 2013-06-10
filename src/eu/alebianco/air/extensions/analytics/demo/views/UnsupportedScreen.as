/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {

import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayVersion;

import feathers.controls.Label;
import feathers.core.FeathersControl;
import feathers.display.VerticalSpacer;

import flash.text.TextFormat;
import flash.text.TextFormatAlign;

final public class UnsupportedScreen extends BaseScreen implements IDisplayVersion {

	private var version_lbl:Label;
	private var info_lbl:Label;
	private var support_lbl:Label;

	private var _version:String;

	public function set version(value:String):void {
		_version = value;
		invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
	}

	override protected function initialize():void {
		super.initialize();
        createContent();
	}

	override public function invalidate(flag:String = "all"):void {
		super.invalidate(flag);
		if (flag == FeathersControl.INVALIDATION_FLAG_DATA) {
			version_lbl.text = _version;
			support_lbl.textRendererProperties.textFormat = new TextFormat("Arial", 24 * dpiScale, 0xcc0000, true, false, false, null, null, TextFormatAlign.CENTER);
		}
	}

	override protected function draw():void {
		super.draw();

		info_lbl.width = container.width - settings.paddingLeft - settings.paddingRight;
		support_lbl.width = info_lbl.width;
	}

	private function createContent():void {
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
	}
}
}
