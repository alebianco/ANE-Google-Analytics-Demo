/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:18
 */
package eu.alebianco.air.extensions.analytics.demo.model {
import eu.alebianco.air.extensions.analytics.demo.tests.suites.Core;
import eu.alebianco.core.Enum;

public final class TestBundle extends Enum {

    {
        initEnum(TestBundle);
    }

    // Constants.
    public static const CORE:TestBundle = new TestBundle(Core);

    // Constant query.
    public static function getConstants():Vector.<TestBundle> {
        return Vector.<TestBundle>(Enum.getConstants(TestBundle));
    }

    public static function parseConstant(constantName:String, caseSensitive:Boolean = false):TestBundle {
        return TestBundle(Enum.parseConstant(TestBundle, constantName, caseSensitive));
    }

    // Properties.
    private var _suite:Class;
    public function get suite():Class {
        return _suite;
    }

    // Constructor.
    public function TestBundle(suite:Class) {
        super();
        _suite = suite;
    }

    // Accessors.
    override public function toString():String {
        return "[Suite (name: " + name + ")]";
    }
}
}