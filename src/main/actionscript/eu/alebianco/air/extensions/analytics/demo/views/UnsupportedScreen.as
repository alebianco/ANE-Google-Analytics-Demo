/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:38
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayVersion;
import eu.alebianco.utils.getRString;

import feathers.controls.Label;
import feathers.controls.text.TextBlockTextRenderer;
import feathers.core.FeathersControl;
import feathers.display.VerticalSpacer;
import feathers.layout.VerticalLayoutData;

final public class UnsupportedScreen extends BaseScreen implements IDisplayVersion {

    private static const LABEL_STYLE_WARNING:String = "warning";

    private var version_lbl:Label;
    private var info_lbl:Label;
    private var warning_lbl:Label;

    private var version:String;

    public function updateVersion(version:String):void {
        this.version = version;
        invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
    }

    override protected function initialize():void {
        super.initialize();

        info_lbl = createIntroLabel();
        version_lbl = createVersionLabel();
        warning_lbl = createWarningLabel();

        addChild(info_lbl);
        addChild(new VerticalSpacer(48));
        addChild(version_lbl);
        addChild(new VerticalSpacer(48));
        addChild(warning_lbl);
    }

    override protected function draw():void {

        const isDataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);

        if (isDataInvalid) {
            if (version_lbl)
                version_lbl.text = getRString("home.version", version);
        }

        super.draw();
    }

    override public function dispose():void {
        removeChildren();

        info_lbl.dispose();
        info_lbl = null;

        version_lbl.dispose();
        version_lbl = null;

        warning_lbl.dispose();
        warning_lbl = null;

        super.dispose();
    }

    private function createIntroLabel():Label {
        const label:Label = new Label();
        label.layoutData = new VerticalLayoutData(100);
        label.textRendererProperties.wordWrap = true;
        label.text = getRString("home.intro");
        return label;
    }

    private function createVersionLabel():Label {
        const label:Label = new Label();
        label.layoutData = new VerticalLayoutData(100);
        label.textRendererProperties.textAlign = TextBlockTextRenderer.TEXT_ALIGN_CENTER;
        return label;
    }

    private function createWarningLabel():Label {
        const label:Label = new Label();
        label.layoutData = new VerticalLayoutData(100);
        label.styleNameList.add(LABEL_STYLE_WARNING);
        label.text = getRString("error.unsupported");
        return label;
    }
}
}
