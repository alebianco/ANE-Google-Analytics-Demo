/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 16:54
 */
package eu.alebianco.air.extensions.analytics.demo.model.tests.core {
import eu.alebianco.air.extensions.analytics.demo.commands.tests.core.CreateTest;
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;

public class CreateTestData implements Test {
    public function get name():String {
        return "test.core.create.name";
    }

    public function get description():String {
        return "test.core.create.description";
    }

    public function get active():Boolean {
        return true;
    }

    public function get command():Class {
        return CreateTest;
    }
}
}
