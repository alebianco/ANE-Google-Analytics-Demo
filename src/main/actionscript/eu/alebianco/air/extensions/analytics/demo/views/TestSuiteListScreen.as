/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:38
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import feathers.core.FeathersControl;

final public class TestSuiteListScreen extends BaseScreen{

    override protected function initialize():void {
        super.initialize();
        createContent();
    }

    override public function invalidate(flag:String = "all"):void {
        super.invalidate(flag);
        if (flag == FeathersControl.INVALIDATION_FLAG_DATA) {

        }
    }

    override protected function draw():void {
        super.draw();
    }

    override public function dispose():void {
        super.dispose();
    }

    private function createContent():void {

    }

    override protected function createHeader():void {
        super.createHeader();

    }
}
}
