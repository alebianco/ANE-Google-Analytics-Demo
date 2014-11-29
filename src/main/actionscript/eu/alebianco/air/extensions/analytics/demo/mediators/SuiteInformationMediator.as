/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 19:24
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {
import avmplus.DescribeTypeJSON;

import eu.alebianco.air.extensions.analytics.demo.events.TestsStartedEvent;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;

import flash.utils.getDefinitionByName;

import mx.resources.IResourceManager;
import mx.utils.StringUtil;

import org.flexunit.runner.IDescription;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SuiteInformationMediator extends Mediator {

    [Inject]
    public var view:IDisplaySuiteInformation;

    [Inject]
    public var resource:IResourceManager;

    [Inject]
    public var session:SessionStorage;

    [Inject]
    public var describer:DescribeTypeJSON;

    override public function initialize():void {
        super.initialize();

        addContextListener(TestsStartedEvent.STARTED, onTestsStarted, TestsStartedEvent);
    }

    private function onTestsStarted(event:TestsStartedEvent):void {
        view.showDetails(suiteName, suiteDescription, totalTests);
    }

    private function get suiteName():String {
        const suite:IDescription = session.getItem("suite") as IDescription;
        return suite.displayName.split("::")[1];
    }

    private function get suiteDescription():String {
        const suite:IDescription = session.getItem("suite") as IDescription;
        var description:String;
        try {
            const descriptor:Object = getDescriptionMetadata(suite.displayName);
            if (descriptor && StringUtil.trim(descriptor.value).length > 0) {
                description = resource.getString("resources", descriptor.value);
            }
        } catch (error:Error) {
            description = resource.getString("resources", "error.suite.description.rte", [error.message]);
        } finally {
            description ||= resource.getString("resources", "error.suite.description.not.found", [suite.displayName.split("::")[1]]);
        }
        return description;
    }

    private function get totalTests():uint {
        return session.getItem("test-count") as uint;
    }

    private function getDescriptionMetadata(className:String):Object {
        const suiteClass:Class = getDefinitionByName(className) as Class;
        const definition:Object = describer.getInstanceDescription(suiteClass);
        const tag:Object = getFirstMatch(definition.traits.metadata, propertyEquals("name", "Suite")) as Object;
        return getFirstMatch(tag.value, propertyEquals("key", "description")) as Object;
    }

    private function getFirstMatch(target:Array, matcher:Function):* {
        const list:Array = target.filter(matcher);
        return list && list.length > 0 ? list[0] : null;
    }

    private function propertyEquals(property:String, value:String):Function {
        return function(object:Object, index:int, list:Array):Boolean {
            return property in object && object[property] === value;
        }
    }
}
}
