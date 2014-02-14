/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 06/06/2013 11:36
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands {

import eu.alebianco.air.extensions.analytics.Analytics;
import eu.alebianco.air.extensions.analytics.api.IAnalytics;
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

import feathers.controls.Toast;

import org.swiftsuspenders.mapping.MappingEvent;

import robotlegs.bender.framework.api.IInjector;

public class CreateTracker extends AsyncCommand {

    [Inject(name='account')]
    public var account:String;

    [Inject]
    public var injector:IInjector;

    [Inject]
    public var analytics:IAnalytics;

    override public function execute():void {
        const tracker:ITracker = getTrackerForID(account);
        if (tracker) {
            injector.addEventListener(MappingEvent.POST_MAPPING_CHANGE, onMappingCreated);
            injector.map(ITracker).toValue(tracker);
        } else {
            dispatchComplete(false);
        }
    }

    private function onMappingCreated(event:MappingEvent):void {
        injector.removeEventListener(event.type, arguments.callee);
        dispatchComplete(event.mappedType == ITracker);
    }

    private function getTrackerForID(id:String):ITracker {
        var tracker:ITracker;
        try {
            tracker = analytics.getTracker(id);
        } catch (error:ArgumentError) {
            tracker = null;
        }
        return tracker;
    }
}
}
