/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 16:48
 */
package {
import eu.alebianco.air.extensions.analytics.demo.AnalyticsDemo;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.LogLevel;
import robotlegs.bender.framework.impl.Context;
import robotlegs.starling.bundles.mvcs.StarlingBundle;
import robotlegs.starling.extensions.contextView.ContextView;
import robotlegs.starling.extensions.viewProcessorMap.ViewProcessorMapExtension;

import starling.core.Starling;

public class Main extends Sprite {

    private var _context:IContext;
    private var _starling:Starling;

    public function Main() {
        if (this.stage) {
            this.stage.scaleMode = StageScaleMode.NO_SCALE;
            this.stage.align = StageAlign.TOP_LEFT;
        }

        this.mouseEnabled = this.mouseChildren = false;
        this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
    }

    private function loaderInfo_completeHandler(event:Event):void {
        initializeStarling();

        this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
        this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
    }

    private function initializeStarling():void {
        Starling.handleLostContext = true;
        Starling.multitouchEnabled = true;

        this._starling = new Starling(AnalyticsDemo, this.stage);
        this._starling.enableErrorChecking = false;
        this._starling.showStats = false;
        this._starling.start();

        this._context = new Context();
        this._context.logLevel = LogLevel.WARN;
        this._context.install(StarlingBundle);
        this._context.configure(Configuration, new ContextView(this._starling))
    }

    private function stage_resizeHandler(event:Event):void {
        this._starling.stage.stageWidth = this.stage.stageWidth;
        this._starling.stage.stageHeight = this.stage.stageHeight;

        const viewPort:Rectangle = this._starling.viewPort;
        viewPort.width = this.stage.stageWidth;
        viewPort.height = this.stage.stageHeight;
        try {
            this._starling.viewPort = viewPort;
        } catch (error:Error) {
            trace("Failed to update the viewport after screen resize.")
        }
    }

    private function stage_deactivateHandler(event:Event):void {
        this._starling.stop();
        this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
    }

    private function stage_activateHandler(event:Event):void {
        this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
        this._starling.start();
    }
}
}
