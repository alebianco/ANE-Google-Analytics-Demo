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

public class DisposeTest extends AbstractTest {

    override public function execute():void {
        super.execute();

        try {
            const instance:IAnalytics = Analytics.getInstance();
            instance.dispose();
            verify();
        } catch(error:Error) {
            report(false, "error.runtime", error.errorID, error.name, error.message);
        }
    }

    override public function verify(...data):void {
        report(true); // There's no way to verify disposal right now.
    }
}
}
