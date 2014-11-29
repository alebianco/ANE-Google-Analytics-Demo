/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 20/11/2014 21:44
 */
package eu.alebianco.air.extensions.analytics.demo.tests {

import eu.alebianco.air.extensions.analytics.Analytics;

import org.flexunit.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.text.re;

[TestCase(order=3)]
public class Versioning {

    private static var analytics:Analytics;
    private static var matcher:RegExp;

    [BeforeClass]
    public static function initialise():void {
        analytics = Analytics.getInstance();
        matcher = /[a-zA-Z]+\sv\d+\.\d+.\d+/;
    }

    [AfterClass]
    public static function dispose():void {
        analytics = null;
        matcher = null;
    }

    [Test]
    public function shouldReturnAString():void {
        assertThat(analytics.version, instanceOf(String));
    }

    [Test]
    public function shouldMatchFormat():void {
        assertThat(analytics.version, re(matcher));
    }
}
}
