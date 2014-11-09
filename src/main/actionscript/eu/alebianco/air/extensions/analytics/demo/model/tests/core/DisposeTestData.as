/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 08/11/2014 16:54
 */
package eu.alebianco.air.extensions.analytics.demo.model.tests.core {
import eu.alebianco.air.extensions.analytics.demo.commands.tests.core.DisposeTest;
import eu.alebianco.air.extensions.analytics.demo.model.api.Test;

public class DisposeTestData implements Test {
    public function get name():String {
        return "test.core.dispose.name";
    }

    public function get description():String {
        return "test.core.dispose.description";
    }

    public function get active():Boolean {
        return true;
    }

    public function get command():Class {
        return DisposeTest;
    }
}
}
