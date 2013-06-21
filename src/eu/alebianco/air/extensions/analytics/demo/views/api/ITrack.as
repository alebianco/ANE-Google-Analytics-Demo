/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/06/2013 10:30
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {
import org.osflash.signals.ISignal;

public interface ITrack extends INavigateScreens {
    function get track():ISignal;

    function get change():ISignal;

    function get enabled():Boolean;

    function set enabled(value:Boolean):void;
}
}
