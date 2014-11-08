/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 05/11/2014 09:06
 */
package feathers.display {
import feathers.core.FeathersControl;
import feathers.skins.IStyleProvider;

public class VerticalSpacer extends FeathersControl {

    public static var globalStyleProvider:IStyleProvider;

    public function VerticalSpacer(height:Number) {
        super();

        this.height = height;
        this.width = 0;
        this.visible = false;
    }
    
    override protected function get defaultStyleProvider():IStyleProvider {
        return VerticalSpacer.globalStyleProvider;
    }
}
}
