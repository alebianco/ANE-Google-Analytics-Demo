/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 06/06/2013 10:16
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {

import org.osflash.signals.ISignal;

public interface IManageTracker {
    function get disconnectTriggered():ISignal;

    function set appID(value:String):void;

    function set appName(value:String):void;

    function set appVersion(value:String):void;

    function set trackerID(value:String):void;
}
}
