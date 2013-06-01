/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package feathers.display {

import starling.display.Quad;

public class VerticalSpacer extends Quad {
    public function VerticalSpacer(size:int) {
        super(size, size, 0x000000);
        this.visible = false;
    }
}
}
