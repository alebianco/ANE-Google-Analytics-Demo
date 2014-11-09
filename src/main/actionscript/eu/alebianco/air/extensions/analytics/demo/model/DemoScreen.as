/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:18
 */
package eu.alebianco.air.extensions.analytics.demo.model {
import eu.alebianco.air.extensions.analytics.demo.views.ReportDetailsScreen;
import eu.alebianco.air.extensions.analytics.demo.views.SuiteRunnerScreen;
import eu.alebianco.air.extensions.analytics.demo.views.SuitesListScreen;
import eu.alebianco.air.extensions.analytics.demo.views.UnsupportedScreen;
import eu.alebianco.core.Enum;

public final class DemoScreen extends Enum {

    {
        initEnum(DemoScreen);
    }

    // Constants.
    public static const UNSUPPORTED:DemoScreen = new DemoScreen(UnsupportedScreen);
    public static const SUITES_LIST:DemoScreen = new DemoScreen(SuitesListScreen);
    public static const SUITE_RUNNER:DemoScreen = new DemoScreen(SuiteRunnerScreen);
    public static const REPORT_DETAILS:DemoScreen = new DemoScreen(ReportDetailsScreen);

    // Constant query.
    public static function getConstants():Vector.<DemoScreen> {
        return Vector.<DemoScreen>(Enum.getConstants(DemoScreen));
    }

    public static function parseConstant(constantName:String, caseSensitive:Boolean = false):DemoScreen {
        return DemoScreen(Enum.parseConstant(DemoScreen, constantName, caseSensitive));
    }

    // Properties.
    private var _view:Class;
    public function get view():Class {
        return _view;
    }

    // Constructor.
    public function DemoScreen(screen:Class) {
        super();
        _view = screen;
    }

    // Accessors.
    override public function toString():String {
        return "[Screen (name: " + name + ")]";
    }
}
}