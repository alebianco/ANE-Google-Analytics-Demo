/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/06/2013 10:29
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {

public interface ITrackEvent extends ITrack {
    function get category():String;

    function get action():String;

    function get label():String;

    function get value():int;

    function get hasLabel():Boolean;

    function get hasValue():Boolean;
}
}
