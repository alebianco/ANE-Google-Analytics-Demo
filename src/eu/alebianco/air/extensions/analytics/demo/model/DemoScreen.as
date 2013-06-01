/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/13 12.08
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.model {

import eu.alebianco.air.extensions.analytics.demo.views.HomeScreen;
import eu.alebianco.air.extensions.analytics.demo.views.SettingsScreen;
import eu.alebianco.air.extensions.analytics.demo.views.TrackerScreen;
import eu.alebianco.air.extensions.analytics.demo.views.UnsupportedScreen;
import eu.alebianco.core.Enum;

public final class DemoScreen extends Enum {

    {
        initEnum(DemoScreen);
    }

    // Constants.
    public static const UNSUPPORTED:DemoScreen = new DemoScreen(UnsupportedScreen);
    public static const HOME:DemoScreen = new DemoScreen(HomeScreen);
    public static const SETTINGS:DemoScreen = new DemoScreen(SettingsScreen);
    public static const TRACKER:DemoScreen = new DemoScreen(TrackerScreen);

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