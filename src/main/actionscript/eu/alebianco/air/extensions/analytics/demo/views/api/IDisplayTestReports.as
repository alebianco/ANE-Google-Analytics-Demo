
/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {
import feathers.data.ListCollection;

import org.osflash.signals.Signal;

public interface IDisplayTestReports {
    function getReportsCollection():ListCollection;
    function get selected():Signal;
}
}
