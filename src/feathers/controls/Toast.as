/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package feathers.controls {

import feathers.core.FeathersControl;
import feathers.core.PopUpManager;

import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import starling.display.Quad;

public class Toast extends FeathersControl {

    private static var exist:Boolean = false;

    private const DELAY:int = 3000;

    private var message:String = "";

    private var label:Label;
    private var back:Quad;

    private var timer:Timer;
    private var queue:uint;

    public function Toast(message:String) {
        super();
        this.message ||= message;

        timer = new Timer(DELAY);
    }

    public function show():void {
        if (Toast.exist) {
            clearTimeout(queue);
            queue = setTimeout(show, DELAY + 100);
        } else {
            PopUpManager.addPopUp(this, false, false);
            Toast.exist = true;
            timer.addEventListener(TimerEvent.TIMER, timer_completeHandler);
            timer.start();
        }
    }

    public function close():void {
        Toast.exist = false;
        PopUpManager.removePopUp(this);
        timer.removeEventListener(TimerEvent.TIMER, timer_completeHandler);
        timer.reset();
    }

    private function timer_completeHandler(event:TimerEvent):void {
        close()
    }

    override protected function draw():void {

        label.y = 5;
        label.x = 10;

        label.width = stage.stageWidth - 80;
        label.validate();

        back.width = stage.stageWidth - 60;
        back.height = label.height + 10;

        x = 30;
        y = stage.stageHeight - back.height - 40;

    }

    override protected function initialize():void {

        label = new Label();
        label.textRendererProperties.wordWrap = true;
        label.textRendererProperties.color = 0xe5e5e5;
        label.text = message;

        back = new Quad(100, 100, 0x1a1a1a, true);
        back.alpha = 0.5;

        addChild(back);
        addChild(label);
    }
}
}
