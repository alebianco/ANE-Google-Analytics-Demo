/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 06/06/2013 11:36
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.commands {
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;
import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

import feathers.controls.Toast;

import org.swiftsuspenders.Injector;
import org.swiftsuspenders.mapping.MappingEvent;

public class DestroyTracker extends AsyncCommand {

    [Inject]
    public var injector:Injector;

    [Inject]
    public var resources:ResourceBundle;

    [Inject]
    public var tracker:ITracker;

    override public function execute():void {
        tracker.dispose();
        injector.addEventListener(MappingEvent.POST_MAPPING_REMOVE, onMappingRemove)
        injector.unmap(ITracker);

        new Toast(resources.common.tracker.destroy).show();
    }

    private function onMappingRemove(event:MappingEvent):void {
        injector.removeEventListener(event.type, arguments.callee);
        this.dispatchComplete(event.mappedType == ITracker);
    }
}
}
