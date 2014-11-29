/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 20/11/2014 21:41
 */
package eu.alebianco.air.extensions.analytics.demo.tests.suites {
import eu.alebianco.air.extensions.analytics.demo.tests.Creating;
import eu.alebianco.air.extensions.analytics.demo.tests.Versioning;

[Suite(order=1)]
[RunWith("org.flexunit.runners.Suite")]
public class Core {
    public var creating:Creating;
    public var versioning:Versioning;
}
}
