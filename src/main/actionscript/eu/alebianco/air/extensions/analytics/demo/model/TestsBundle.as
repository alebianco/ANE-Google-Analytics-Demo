/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 13:26
 */
package eu.alebianco.air.extensions.analytics.demo.model {
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.air.extensions.analytics.demo.model.suites.CoreSuite;

public class TestsBundle {

    private var bundle:Vector.<TestSuite>;

    public function getListOfSuites():Vector.<TestSuite> {
        return bundle ||= generateBundle();
    }

    private function generateBundle():Vector.<TestSuite> {
        const list:Vector.<TestSuite> = new <TestSuite>
                [
                    new CoreSuite()
                ];
        return list;
    }

}
}
