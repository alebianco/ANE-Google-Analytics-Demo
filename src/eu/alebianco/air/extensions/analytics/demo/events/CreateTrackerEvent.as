/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 06/06/2013 11:33
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.events {

import flash.events.Event;

public class CreateTrackerEvent extends Event {

	public static const CREATE:String = "CreateTrackerEvent::CREATE";

	private var _account:String;

	public function CreateTrackerEvent(account:String, bubbles:Boolean = false, cancelable:Boolean = false) {
		super(CREATE, bubbles, cancelable);

		this._account = account;
	}

	public function get account():String {
		return _account;
	}

	override public function clone():Event {
		return new CreateTrackerEvent(_account, bubbles, cancelable);
	}

	override public function toString():String {
		return formatToString("CreateTrackerEvent", "account", "type", "bubbles", "cancelable");
	}
}
}
