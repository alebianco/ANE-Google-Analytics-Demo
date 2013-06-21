/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 01/06/13 12.37
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands.macro {

import eu.alebianco.air.extensions.analytics.demo.commands.*;
import eu.alebianco.air.extensions.analytics.demo.commands.guards.NoTrackerRegistered;
import eu.alebianco.air.extensions.analytics.demo.commands.guards.OtherTrackerRegistered;
import eu.alebianco.air.extensions.analytics.demo.events.CreateTrackerEvent;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;
import eu.alebianco.robotlegs.utils.impl.SequenceMacro;
import eu.alebianco.robotlegs.utils.impl.SubCommandPayload;

import feathers.controls.Toast;

import flash.events.IEventDispatcher;

public class ChangeTrackerMacro extends SequenceMacro {

    [Inject]
    public var dispatcher:IEventDispatcher;

    [Inject]
    public var event:CreateTrackerEvent;

    [Inject]
    public var resources:ResourceBundle;

    override public function prepare():void {

        this.atomic = false;

        const account:SubCommandPayload = new SubCommandPayload(event.account).withName("account");

        add(DestroyTracker).withGuards(OtherTrackerRegistered).withPayloads(account);
        add(CreateTracker).withGuards(NoTrackerRegistered).withPayloads(account);

        registerCompleteCallback(onComplete);
    }

    override public function execute():void {
        super.execute();
    }

    private function onComplete(success:Boolean):void {
        if (success) {
            dispatcher.dispatchEvent(new NavigateEvent(DemoScreen.TRACKER_INFO));
        } else {
            new Toast(resources.common.errors.trackercreationfail).show();
        }
    }
}
}
