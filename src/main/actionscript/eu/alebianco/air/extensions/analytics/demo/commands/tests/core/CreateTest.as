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

public class CreateTest extends AbstractTest {

    override public function execute():void {
        try {
            verify(Analytics.getInstance());
        } catch(error:Error) {
            report(false, "error.runtime", error.errorID, error.name, error.message);
        }
    }

    override public function verify(...data):void {
        const first:IAnalytics = data[0];
        const isNotNull:Boolean = first != null;
        const isRightType:Boolean = first is Analytics;
        report(isNotNull && isRightType);
    }
}
}
