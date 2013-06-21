/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/06/2013 16:10
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.views.api.ITrack;

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.core.FeathersControl;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.DisplayObject;
import starling.events.Event;

public class TrackBaseScreen extends BaseScreen implements ITrack {

    private var _navigationRequested:Signal;
    private var _track:ISignal;
    private var _change:ISignal;

    protected var back_btn:Button;
    protected var track_btn:Button;
    protected var info_lbl:Label;

    private var _enabled:Boolean;

    public function get enabled():Boolean {
        return _enabled;
    }

    public function set enabled(value:Boolean):void {
        if (_enabled != value) {
            _enabled = value;
            invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
        }
    }

    public function get navigationRequested():ISignal {
        return _navigationRequested ||= new Signal();
    }

    public function get track():ISignal {
        return _track ||= new Signal();
    }

    public function get change():ISignal {
        return _change ||= new Signal();
    }

    override protected function initialize():void {
        super.initialize();

        info_lbl = new Label();
        info_lbl.textRendererProperties.wordWrap = true;
        container.addChild(info_lbl);

        createFormFields();

        track_btn = new Button();
        track_btn.label = resources.tracker.common.track.label;
        track_btn.addEventListener(Event.TRIGGERED, track_triggeredHandler);
        container.addChild(track_btn);
    }

    override public function invalidate(flag:String = "all"):void {
        super.invalidate(flag);
        if (flag == FeathersControl.INVALIDATION_FLAG_DATA) {
            track_btn.isEnabled = enabled;
        }
    }

    override protected function draw():void {
        super.draw();

        track_btn.validate();
        track_btn.y = container.height - track_btn.height - settings.paddingBottom;
    }

    override public function dispose():void {
        super.dispose();
        track_btn.removeEventListener(Event.TRIGGERED, track_triggeredHandler);
    }

    protected function createFormFields():void {
        throw new Error("Method has to be overridden.")
    }

    override protected function createHeader():void {
        super.createHeader();

        back_btn = new Button();
        back_btn.label = resources.common.header.back.label;
        back_btn.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
        header.leftItems = new <DisplayObject>[this.back_btn];

        this.backButtonHandler = this.onBackButton;
    }

    private function track_triggeredHandler(event:Event):void {
        track.dispatch();
    }

    private function backButton_triggeredHandler(event:Event):void {
        onBackButton();
    }

    private function onBackButton():void {
        navigationRequested.dispatch(DemoScreen.TRACKER_INFO);
    }
}
}
