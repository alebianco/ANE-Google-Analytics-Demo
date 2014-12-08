/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 11/11/2014 14:44
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {

public interface IDisplayReportDetails {
    function updateInfo(group:String, name:String, description:String):void;
    function updateTime(duration:int):void;
    function updateStatus(complete:Boolean, successful:Boolean, ignored:Boolean):void;
    function updateFailure(message:String, stackTrace:String):void;
}
}
