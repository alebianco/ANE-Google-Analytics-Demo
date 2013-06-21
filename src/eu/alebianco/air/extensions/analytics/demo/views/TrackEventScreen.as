/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/06/2013 15:38
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.views.api.ITrackEvent;

import feathers.controls.Label;
import feathers.controls.ScrollContainer;
import feathers.controls.Scroller;
import feathers.controls.TextInput;

import starling.events.Event;

public class TrackEventScreen extends TrackBaseScreen implements ITrackEvent {

    private var name_row:ScrollContainer;
    private var name_lbl:Label;
    private var name_fld:TextInput;

    public function get category():String {
        return "";
    }

    public function get action():String {
        return "";
    }

    public function get label():String {
        return "";
    }

    public function get value():int {
        return 0;
    }

    public function get hasLabel():Boolean {
        return false;
    }

    public function get hasValue():Boolean {
        return false;
    }

    override public function dispose():void {
        super.dispose();
    }

    override protected function initialize():void {
        super.initialize();
        info_lbl.text = resources.tracker.event.info;
    }

    override protected function createFormFields():void {

        name_row = new ScrollContainer();
        name_row.layout = getFormFieldLayout();
        container.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
        container.addChild(name_row);

        name_lbl = new Label();
        name_lbl.text = resources.tracker.view.fields.name;
        name_row.addChild(name_lbl);

        name_fld = new TextInput();
        name_fld.addEventListener(Event.CHANGE, name_changeHandler);
        name_row.addChild(name_fld);
    }

    override protected function createHeader():void {
        super.createHeader();
        header.title = resources.tracker.event.title;
    }

    private function name_changeHandler(event:Event):void {
        change.dispatch();
    }
}
}
