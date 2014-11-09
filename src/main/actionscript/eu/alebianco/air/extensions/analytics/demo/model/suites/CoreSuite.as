/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 13:26
 */
package eu.alebianco.air.extensions.analytics.demo.model.suites {
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;
import eu.alebianco.air.extensions.analytics.demo.model.api.TestSuite;
import eu.alebianco.air.extensions.analytics.demo.model.tests.core.CreateTestData;
import eu.alebianco.air.extensions.analytics.demo.model.tests.core.DisposeTestData;
import eu.alebianco.air.extensions.analytics.demo.model.tests.core.ReadVersionTestData;
import eu.alebianco.air.extensions.analytics.demo.model.tests.core.RecreateTestData;

public class CoreSuite implements TestSuite {

    private var suite:Vector.<Test>;

    public function get name():String {
        return "suite.core.name";
    }

    public function get description():String {
        return "suite.core.description";
    }

    public function get tests():Vector.<Test> {
        return suite ||= generateSuite();
    }

    private function generateSuite():Vector.<Test> {
        const list:Vector.<Test> = new <Test>
                [
                    new CreateTestData(),
                    new DisposeTestData(),
                    new RecreateTestData(),
                    new ReadVersionTestData(),
                ];
        return list;
    }

}
}
