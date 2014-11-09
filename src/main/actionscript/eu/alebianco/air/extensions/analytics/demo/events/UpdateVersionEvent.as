/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 10:28
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import flash.events.Event;

public class UpdateVersionEvent extends Event {

    public static var UPDATE:String = "UpdateVersionEvent:UPDATE";

    private var _version:String;

    public function get version():String {
        return _version;
    }

    public function UpdateVersionEvent(version:String) {
        super(UPDATE);
        _version = version;
    }

    override public function clone():Event {
        return new UpdateVersionEvent(_version);
    }

    override public function toString():String {
        return formatToString("UpdateVersionEvent", "type", "bubbles", "cancelable", "version")
    }
}
}
