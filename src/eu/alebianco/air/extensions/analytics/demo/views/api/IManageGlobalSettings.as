/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 06/06/2013 11:18
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {

import org.osflash.signals.ISignal;

public interface IManageGlobalSettings {
	function get changed():ISignal;
	function get completed():ISignal;

	function get debug():Boolean;
	function set debug(value:Boolean):void;
	function get dispatchInterval():int;
	function set dispatchInterval(value:int):void;
	function get dispatchManually():Boolean;
	function set dispatchManually(value:Boolean):void;
	function get optOut():Boolean;
	function set optOut(value:Boolean):void;
}
}
