/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 17/06/2013 12:57
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {
import org.osflash.signals.ISignal;

public interface IManageTrackerSettings {

    function get changed():ISignal;

    function get sessionTimeout():uint;

    function set sessionTimeout(value:uint):void;

    function get secure():Boolean;

    function set secure(value:Boolean):void;

    function get sampleRate():uint;

    function set sampleRate(value:uint):void;

    function get anonymous():Boolean;

    function set anonymous(value:Boolean):void;
}
}
