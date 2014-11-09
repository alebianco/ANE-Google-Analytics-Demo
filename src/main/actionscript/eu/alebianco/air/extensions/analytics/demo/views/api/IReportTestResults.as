
/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;

import org.osflash.signals.Signal;

public interface IReportTestResults {
    function addTest(test:Test):void;
    function updateResult(test:Test, success:Boolean, message:String, data:Array):void;
    function get selected():Signal;
}
}
