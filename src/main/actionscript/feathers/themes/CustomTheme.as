/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 05/11/2014 11:05
 */
package feathers.themes {
import feathers.controls.Label;
import feathers.controls.text.TextBlockTextRenderer;
import feathers.display.VerticalSpacer;

import flash.text.engine.ElementFormat;

public class CustomTheme extends MetalWorksMobileTheme {

    protected static const WARNING_TEXT_COLOR:uint = 0xff9900;

    protected var hugeFontSize:int;

    protected var warningElementFormat:ElementFormat;

    public function CustomTheme() {
        super(true);
    }

    override protected function initializeFonts():void {
        super.initializeFonts();

        this.hugeFontSize = Math.round(48 * this.scale);
        this.warningElementFormat = new ElementFormat(this.regularFontDescription, this.hugeFontSize, WARNING_TEXT_COLOR);
    }

    override protected function initializeStyleProviders():void {
        super.initializeStyleProviders();

        this.getStyleProviderForClass(Label)
            .setFunctionForStyleName("warning", setWarningLabelStyles);

        this.getStyleProviderForClass(VerticalSpacer)
            .defaultStyleFunction = this.setVerticalSpacerStyles;
    }

    private function setWarningLabelStyles(label:Label):void {

        label.textRendererProperties.elementFormat = this.warningElementFormat;
        label.textRendererProperties.disabledElementFormat = this.disabledElementFormat;
        label.textRendererProperties.textAlign = TextBlockTextRenderer.TEXT_ALIGN_CENTER;
        label.textRendererProperties.wordWrap = true;
    }

    private function setVerticalSpacerStyles(spacer:VerticalSpacer):void {
        spacer.scaleX = this.scale;
        spacer.scaleY = this.scale;
    }
}
}
