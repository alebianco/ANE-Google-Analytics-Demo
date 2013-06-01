/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.model {

import dupin.parsers.yaml.YAML;

import flash.utils.Proxy;
import flash.utils.flash_proxy;

import mx.core.ByteArrayAsset;

dynamic public class ResourceBundle extends Proxy {

	[Embed(source="/../assets/resources.yaml", mimeType="application/octet-stream")]
	private const Resources:Class;

	private var data:Object;

	public function ResourceBundle() {

		const ba:ByteArrayAsset = ByteArrayAsset(new Resources());
		var text:String = ba.readUTFBytes(ba.length);

		data = YAML.decode(text);
	}

	override flash_proxy function getProperty(name:*):* {

		return data[name];
	}

	override flash_proxy function setProperty(name:*, value:*):void {
		throw new Error("This class is read-only.");
	}

	override flash_proxy function deleteProperty(name:*):Boolean {
		throw new Error("This class is read-only.");
	}

	override flash_proxy function hasProperty(name:*):Boolean {
		return name in data;
	}
}
}
