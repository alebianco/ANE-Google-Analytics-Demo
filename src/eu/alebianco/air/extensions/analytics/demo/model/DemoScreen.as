/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/13 12.08
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.model {

import eu.alebianco.air.extensions.analytics.demo.views.GlobalSettingsScreen;
import eu.alebianco.air.extensions.analytics.demo.views.HomeScreen;
import eu.alebianco.air.extensions.analytics.demo.views.TrackViewScreen;
import eu.alebianco.air.extensions.analytics.demo.views.TrackerInfoScreen;
import eu.alebianco.air.extensions.analytics.demo.views.TrackerSettingsScreen;
import eu.alebianco.air.extensions.analytics.demo.views.UnsupportedScreen;
import eu.alebianco.core.Enum;

public final class DemoScreen extends Enum {

    {
        initEnum(DemoScreen);
    }

    // Constants.
    public static const UNSUPPORTED:DemoScreen = new DemoScreen(UnsupportedScreen);
    public static const HOME:DemoScreen = new DemoScreen(HomeScreen);
    public static const SETTINGS:DemoScreen = new DemoScreen(GlobalSettingsScreen);
    public static const TRACKER_INFO:DemoScreen = new DemoScreen(TrackerInfoScreen);
    public static const TRACKER_SETTINGS:DemoScreen = new DemoScreen(TrackerSettingsScreen);

    public static const VIEW:DemoScreen = new DemoScreen(TrackViewScreen);
    public static const EVENT:DemoScreen = new DemoScreen(null);
    public static const TIMING:DemoScreen = new DemoScreen(null);
    public static const SOCIAL:DemoScreen = new DemoScreen(null);
    public static const EXCEPTION:DemoScreen = new DemoScreen(null);
    public static const TRANSACTION:DemoScreen = new DemoScreen(null);

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
