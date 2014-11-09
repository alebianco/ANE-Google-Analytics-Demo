
/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;

import org.osflash.signals.Signal;

public interface IDisplayTestReports {
    function updateReport(report:TestReportVO):void;
    function get selected():Signal;
}
}
