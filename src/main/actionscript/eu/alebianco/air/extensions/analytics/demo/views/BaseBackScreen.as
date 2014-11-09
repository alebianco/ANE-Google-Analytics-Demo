/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:38
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.views.api.IBack;

import feathers.controls.Button;

import org.osflash.signals.Signal;

import starling.display.DisplayObject;
import starling.events.Event;

public class BaseBackScreen extends BaseScreen implements IBack {

    protected var backButton:Button;

    private var _back:Signal;

    public function get back():Signal {
        return _back ||= new Signal();
    }

    override protected function createHeader():void {
        super.createHeader();

        backButton = new Button();
        backButton.styleNameList.add(Button.ALTERNATE_NAME_BACK_BUTTON);
        backButton.label = getRString("common.back.label");
        backButton.addEventListener(Event.TRIGGERED, onBackTriggered);

        headerProperties.leftItems = new <DisplayObject>
                [
                    backButton
                ];

        backButtonHandler = onBackButton;
    }

    protected function onBackButton():void {
        back.dispatch();
    }

    protected function onBackTriggered(event:Event):void {
        onBackButton();
    }
}
}