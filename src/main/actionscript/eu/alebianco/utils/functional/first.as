/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 30/11/2014 09:29
 */
package eu.alebianco.utils.functional {
    public function first(list:*, matcher:Function, ...params):* {
        const result:Array = filter.apply(null, [list, matcher].concat(params));
        var data:* = null;
        if (result && result.length > 0) {
            data = result[0];
        }
        return data;
    }
}
