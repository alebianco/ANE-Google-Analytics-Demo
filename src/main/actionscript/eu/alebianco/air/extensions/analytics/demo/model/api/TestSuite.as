/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 13:25
 */
package eu.alebianco.air.extensions.analytics.demo.model.api {
public interface TestSuite {
    function get name():String;
    function get description():String;
    function get tests():Vector.<Test>;
}
}
