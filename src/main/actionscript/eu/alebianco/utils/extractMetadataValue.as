/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 30/11/2014 09:24
 */
package eu.alebianco.utils {
import eu.alebianco.utils.functional.first;

import flex.lang.reflect.metadata.MetaDataAnnotation;
import flex.lang.reflect.metadata.MetaDataArgument;

public function extractMetadataValue(tags:Array, tagName:String, argumentName:String):* {
    const equals:Function = function (annotation:MetaDataAnnotation, name:String):Boolean {
        return annotation.name == name;
    };
    const annotation:MetaDataAnnotation = first(tags, equals, tagName);
    const argument:MetaDataArgument = annotation.getArgument(argumentName);
    return argument.value;
}
}
