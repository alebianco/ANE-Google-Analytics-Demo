/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 30/11/2014 09:29
 */
package eu.alebianco.utils.functional {
    public function filter(list:*, matcher:Function, ...params):Array {
        const unfiltered:Array = eu.alebianco.utils.functional.toArray(list);
        var args:Array = [null].concat(params);
        return unfiltered.filter(function(object:*, index:int, list:*):Boolean {
            args[0] = object;
            return matcher.apply(null, args);
        });
    }
}
