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

public class ReadVersionTest extends AbstractTest {

    public static var VERSION_MATCHER:RegExp = /[a-zA-Z]+\sv\d+\.\d+.\d+/;

    override public function execute():void {
        super.execute();

        try {
            const instance:IAnalytics = Analytics.getInstance();
            const version:String = instance.version;
            verify(version);
        } catch(error:Error) {
            report(false, "error.runtime", error.errorID, error.name, error.message);
        }
    }

    override public function verify(...data):void {
        const version:String = data[0];
        const isValid:Boolean = VERSION_MATCHER.test(version);
        report(isValid);
    }
}
}
