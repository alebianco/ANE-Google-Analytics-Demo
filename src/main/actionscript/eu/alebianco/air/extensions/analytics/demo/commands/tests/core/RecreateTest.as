/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 16:01
 */
package eu.alebianco.air.extensions.analytics.demo.commands.tests.core {
import eu.alebianco.air.extensions.analytics.Analytics;
import eu.alebianco.air.extensions.analytics.api.IAnalytics;
import eu.alebianco.air.extensions.analytics.demo.commands.tests.AbstractTest;

public class RecreateTest extends AbstractTest {

    override public function execute():void {
        super.execute();

        try {
            const first:IAnalytics = Analytics.getInstance();
            first.dispose();
            const second:IAnalytics = Analytics.getInstance();
            verify(first, second);
        } catch(error:Error) {
            report(false, "error.runtime", error.errorID, error.name, error.message);
        }
    }

    override public function verify(...data):void {
        const first:IAnalytics = data[0];
        const second:IAnalytics = data[1];
        const areEqual:Boolean = first == second;
        report(!areEqual);
    }
}
}
