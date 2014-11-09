/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 09/11/2014 14:39
 */
package eu.alebianco.air.extensions.analytics.demo.model {
import flash.utils.Dictionary;

public class SessionStorage {

    private var map:Dictionary = new Dictionary();
    private var keylist:Array = [];

    public function setItem(key:String, value:*):void {
        if (!(key in map)) {
            keylist.push(key);
        }
        map[key] = value;
    }

    public function getItem(key:String):* {
        return map[key];
    }

    public function removeItem(key:String):void {
        if (key in map) {
            keylist.splice(keylist.indexOf(key), 1);
            delete key[map];
        }
    }

    public function clear():void {
        map = new Dictionary();
        keylist.length = 0;
        keylist = [];
    }

    public function key(index:uint):String {
        return keylist[index];
    }

    public function get length():uint {
        return keylist.length;
    }
}
}
