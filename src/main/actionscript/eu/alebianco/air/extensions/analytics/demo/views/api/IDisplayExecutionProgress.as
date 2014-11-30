/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 29/11/2014 20:36
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {
public interface IDisplayExecutionProgress {
    function updateProgress(completed:uint):void;
    function updateStats(passed:uint, failed:uint, ignored:uint):void;
    function updateStatus(running:Boolean, successful:Boolean):void;
}
}
