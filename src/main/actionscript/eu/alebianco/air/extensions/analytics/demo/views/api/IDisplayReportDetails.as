/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 11/11/2014 14:44
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;

public interface IDisplayReportDetails {
    function showData(report:TestReportVO):void;
}
}
