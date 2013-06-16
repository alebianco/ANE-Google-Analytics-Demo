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

public interface IBuildTrackers {
	function get connectTriggered():ISignal;
	function get accountChanged():ISignal;

	function get account():String;
	function set account(value:String):void;
}
}
