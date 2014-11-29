/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 27/11/2014 21:10
 */
package eu.alebianco.utils {
    import flash.system.Capabilities;

    public class ModeCheck {
        private static var error:Error;

        public static function isDebugPlayer():Boolean {
            return Capabilities.isDebugger;
        }

        public static function isDebugBuild():Boolean {
            error ||= new Error();
            var stackTrace:String = error.getStackTrace();
            return (stackTrace && stackTrace.search(/:[0-9]+]$/m) > -1);
        }

        public static function isDebugMode():Boolean {
            return CONFIG::debug == true;
        }
    }
}
