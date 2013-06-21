/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 20/06/2013 16:04
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.api.Hit;

import flash.events.Event;

public class TrackDataEvent extends Event {

    public static const TRACK:String = "TrackDataEvent::TRACK";
    private var _hit:Hit;

    public function get hit():Hit {
        return _hit;
    }

    public function TrackDataEvent(hit:Hit, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(TRACK, bubbles, cancelable);
        _hit = hit;
    }

    override public function clone():Event {
        return new TrackDataEvent(hit, bubbles, cancelable);
    }

    override public function formatToString(className:String, ...rest):String {
        return formatToString("TrackDataEvent", "hit", "bubbles", "cancelable");
    }
}
}
