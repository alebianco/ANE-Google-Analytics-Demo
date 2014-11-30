/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 30/11/2014 09:29
 */
package eu.alebianco.utils.functional {
import avmplus.getQualifiedClassName;
    public function toArray(list:*):Array {
        if (eu.alebianco.utils.functional.isIterable(list)) {
            var len:int = list.length;
            var ret:Array = new Array(len);
            for (var i:int = 0; i < len; i++) {
                ret[i] = list[i];
            }
            return ret;
        } else {
            const listType:String = getQualifiedClassName(list);
            throw new ArgumentError("Expected an iterable list but it was of type " + listType + " instead.");
        }
    }
}
