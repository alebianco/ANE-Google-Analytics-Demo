/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 19/06/2013 15:48
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.utils {
public class VectorUtils {

    public static function map(vector:*, mapper:Function, thisObj:Object = null):Vector.<*> {
        return Vector.<*>(vector).map(mapper, thisObj);
    }

    public static function forEach(vector:*, eacher:Function, thisObj:Object = null):void {
        Vector.<*>(vector).forEach(eacher, thisObj);
    }

    public static function toArray(vector:*):Array {
        const array:Array = [];
        forEach(vector, function (item:*, index:uint, list:Vector.<*>):void {
            array[index] = item;
        });
        return array;
    }
}
}
