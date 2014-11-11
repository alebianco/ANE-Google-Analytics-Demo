/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 11/11/2014 14:52
 */
package eu.alebianco.air.extensions.analytics.demo.events {
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;

import flash.events.Event;

public class ShowReportDataEvent extends Event {
    public function ShowReportDataEvent(report:TestReportVO) {
        super();
    }
}
}
