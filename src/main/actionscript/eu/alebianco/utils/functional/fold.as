/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 30/11/2014 09:29
 */
package eu.alebianco.utils.functional {
    public function fold(value:*, list:*, transformer:Function):* {
        const iterable:Array = eu.alebianco.utils.functional.toArray(list);
        var result:* = value;
        iterable.forEach(function(object:*, index:int, list:*):void {
            result += transformer(object);
        });
        return result;
    }
}
