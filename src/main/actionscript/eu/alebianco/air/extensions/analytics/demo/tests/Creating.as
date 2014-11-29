/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 20/11/2014 21:44
 */
package eu.alebianco.air.extensions.analytics.demo.tests {

import eu.alebianco.air.extensions.analytics.Analytics;
import eu.alebianco.air.extensions.analytics.api.IAnalytics;

import flash.events.TimerEvent;
import flash.external.ExtensionContext;
import flash.sampler.DeleteObjectSample;
import flash.sampler.NewObjectSample;
import flash.sampler.Sample;
import flash.sampler.clearSamples;
import flash.sampler.getMemberNames;
import flash.sampler.getSamples;
import flash.sampler.pauseSampling;
import flash.sampler.sampleInternalAllocs;
import flash.sampler.startSampling;
import flash.system.System;
import flash.utils.Timer;

import org.flexunit.Assert;
import org.flexunit.assertThat;
import org.flexunit.async.Async;
import org.hamcrest.collection.arrayWithSize;
import org.hamcrest.collection.everyItem;
import org.hamcrest.collection.hasItems;
import org.hamcrest.core.not;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;

[TestCase(order=1)]
public class Creating {

    private var timer:Timer;

    [BeforeClass]
    public static function initialise():void {
        sampleInternalAllocs(true);
    }

    [Before]
    public function setUp():void {
        clearSamples();
        timer = new Timer(100, 1);
        Analytics.getInstance().dispose();
        System.gc();
    }

    [After]
    public function tearDown():void {
        if (timer) timer.stop();
        timer = null;
        System.gc();
    }

    [Test(expects="Error")]
    public function shouldNotBeInstantiable():void {
        new Analytics();
    }

    [Test]
    public function shouldHaveClassFields():void {
        const fields:Object = getMemberNames(Analytics);
        const list:Array = [];
        for each(var f:QName in fields) {
            list.push(f.localName);
        }

        assertThat(list, hasItems("instance", "canBuild", "isSupported", "getInstance"));
    }

    [Test]
    public function shouldHaveInstanceFields():void {
        const fields:Object = getMemberNames(Analytics, true);
        const list:Array = [];
        for each(var f:QName in fields) {
            list.push(f.localName);
        }

        assertThat(list, hasItems("context", "logger", "version", "dispose", "statusHandler"));
    }

    [Test(async)]
    public function shouldAllocateSingleton():void {
        startSampling();
        Analytics.getInstance();
        pauseSampling();

        const asyncCompleteHandler:Function = function (event:TimerEvent, passThroughData:Object):void {
            const instances:Array = countAllocationsOf(Analytics);
            assertThat(instances, arrayWithSize(1));
            assertThat(instances, everyItem(instanceOf(Analytics)));
        };

        const asyncHandler:Function = Async.asyncHandler(this, asyncCompleteHandler, 500, null, asyncTimeoutHandler);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncHandler, false, 0, true);
        timer.start();
    }

    [Test(async)]
    public function shouldAllocateExtensionContext():void {
        startSampling();
        Analytics.getInstance();
        pauseSampling();

        const asyncCompleteHandler:Function = function (event:TimerEvent, passThroughData:Object):void {
            const instances:Array = countAllocationsOf(ExtensionContext);
            assertThat(instances, arrayWithSize(1));
            assertThat(instances, everyItem(instanceOf(ExtensionContext)));
        };

        const asyncHandler:Function = Async.asyncHandler(this, asyncCompleteHandler, 500, null, asyncTimeoutHandler);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncHandler, false, 0, true);
        timer.start();
    }

    [Test(async)]
    public function shouldDeallocateSingleton():void {
        startSampling();
        Analytics.getInstance().dispose();
        pauseSampling();

        const asyncCompleteHandler:Function = function (event:TimerEvent, passThroughData:Object):void {
            const instances:Array = countDeallocationsOf(Analytics);
            assertThat(instances, arrayWithSize(1));
        };

        const asyncHandler:Function = Async.asyncHandler(this, asyncCompleteHandler, 500, null, asyncTimeoutHandler);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncHandler, false, 0, true);
        timer.start();
    }

    [Test(async)]
    public function shouldDeallocateExtensionContext():void {
        startSampling();
        Analytics.getInstance().dispose();
        pauseSampling();

        const asyncCompleteHandler:Function = function (event:TimerEvent, passThroughData:Object):void {
            const instances:Array = countDeallocationsOf(ExtensionContext);
            assertThat(instances, arrayWithSize(1));
        };

        const asyncHandler:Function = Async.asyncHandler(this, asyncCompleteHandler, 500, null, asyncTimeoutHandler);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncHandler, false, 0, true);
        timer.start();
    }

    [Test]
    public function shouldCreateOnlyOneInstance():void {
        const first:IAnalytics = Analytics.getInstance();
        const second:IAnalytics = Analytics.getInstance();

        assertThat(first, strictlyEqualTo(second));
    }

    [Test]
    public function shouldAllocateNewSingletonAfterDisposing():void {
        const first:IAnalytics = Analytics.getInstance();
        first.dispose();
        const second:IAnalytics = Analytics.getInstance();

        assertThat(first, not(equalTo(second)));
    }
    
    // ----- Utilities

    private function asyncTimeoutHandler(passThroughData:Object):void {
        Assert.fail("Timeout reached before event");
    }

    private function countAllocationsOf(klass:Class):Array {
        const list:Array = [];
        for each(var sample:Sample in getSamples()) {
            if (sample is NewObjectSample) {
                const nos:NewObjectSample = sample as NewObjectSample;
                if (nos.type === klass) {
                    list[nos.id] = nos.object;
                }
            } else if (sample is DeleteObjectSample) {
                const dos:DeleteObjectSample = sample as DeleteObjectSample;
                if (dos.id in list) {
                    list[dos.id] = null;
                    delete list[dos.id];
                }
            }
        }
        return list;
    }

    private function countDeallocationsOf(klass:Class):Array {
        const list:Array = [];
        for each(var sample:Sample in getSamples()) {
            if (sample is NewObjectSample) {
                const nos:NewObjectSample = sample as NewObjectSample;
                if (nos.type === klass) {
                    list[nos.id] = false;
                }
            } else if (sample is DeleteObjectSample) {
                const dos:DeleteObjectSample = sample as DeleteObjectSample;
                if (dos.id in list) {
                    list[dos.id] = true;
                }
            }
        }
        return list.filter(function(item:Boolean, index:int, list:Array):Boolean {return item === true;});
    }
}
}
