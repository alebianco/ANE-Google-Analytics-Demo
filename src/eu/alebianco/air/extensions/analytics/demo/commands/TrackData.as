/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 20/06/2013 16:10
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.demo.events.TrackDataEvent;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;

import feathers.controls.Toast;

import robotlegs.bender.bundles.mvcs.Command;

public class TrackData extends Command {

    [Inject]
    public var event:TrackDataEvent;

    [Inject]
    public var tracker:ITracker;

    [Inject]
    public var resources:ResourceBundle;

    override public function execute():void {
        tracker.send(event.hit);
        new Toast(resources.tracker.common.sent).show();
    }
}
}
