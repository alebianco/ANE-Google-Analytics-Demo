/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 11/11/2014 14:50
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.demo.events.ShowReportDataEvent;
import eu.alebianco.air.extensions.analytics.demo.model.vo.TestReportVO;

import flash.events.IEventDispatcher;

import robotlegs.bender.bundles.mvcs.Command;

public class ShowReportData extends Command {

    [Inject]
    public var dispatcher:IEventDispatcher;

    [Inject]
    public var report:TestReportVO;

    override public function execute():void {
        dispatcher.dispatchEvent(new ShowReportDataEvent(report));
    }
}
}
