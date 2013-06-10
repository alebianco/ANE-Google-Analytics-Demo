/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 06/06/2013 10:21
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views.api {
import org.osflash.signals.ISignal;

public interface INavigateScreens {
    function get navigationRequested():ISignal;
}
}
