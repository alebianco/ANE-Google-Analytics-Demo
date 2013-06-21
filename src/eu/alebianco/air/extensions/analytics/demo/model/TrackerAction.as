/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 19/06/2013 10:47
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.model {
import eu.alebianco.core.Enum;

public class TrackerAction extends Enum {

    {
        initEnum(TrackerAction);
    }

    // Constants.
    public static const VIEW:TrackerAction = new TrackerAction();
    public static const EVENT:TrackerAction = new TrackerAction();
    public static const TIMING:TrackerAction = new TrackerAction();
    public static const SOCIAL:TrackerAction = new TrackerAction();
    public static const EXCEPTION:TrackerAction = new TrackerAction();
    public static const TRANSACTION:TrackerAction = new TrackerAction();

    // Constant query.
    public static function getConstants():Vector.<TrackerAction> {
        return Vector.<TrackerAction>(Enum.getConstants(TrackerAction));
    }

    public static function parseConstant(constantName:String, caseSensitive:Boolean = false):TrackerAction {
        return TrackerAction(Enum.parseConstant(TrackerAction, constantName, caseSensitive));
    }

    // Properties.

    // Constructor.
    public function TrackerAction() {
        super();
    }

    // Accessors.
    override public function toString():String {
        return "[Action (name: " + name + ")]";
    }
}
}
