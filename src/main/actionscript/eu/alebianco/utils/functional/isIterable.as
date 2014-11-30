/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 30/11/2014 09:29
 */
package eu.alebianco.utils.functional {
    public function isIterable(iterable:*):Boolean {
        const isVector:Boolean = iterable is Vector.<*>
                              || iterable is Vector.<Number>
                              || iterable is Vector.<int>
                              || iterable is Vector.<uint>;
        return isVector || iterable is Array;
    }
}
