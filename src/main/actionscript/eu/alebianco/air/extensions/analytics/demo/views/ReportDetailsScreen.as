/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 09/11/2014 18:42
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;

public class ReportDetailsScreen extends BaseBackScreen {
    public function ReportDetailsScreen() {
        super();
    }

    override protected function onBackButton():void {
        back.dispatch(DemoScreen.SUITE_RUNNER);
    }
}
}
