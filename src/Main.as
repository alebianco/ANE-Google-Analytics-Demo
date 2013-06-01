package {

import eu.alebianco.air.extensions.analytics.Analytics;
import eu.alebianco.air.extensions.analytics.demo.AnalyticsDemo;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.impl.Context;
import robotlegs.starling.bundles.mvcs.StarlingBundle;
import robotlegs.starling.extensions.contextView.ContextView;
import robotlegs.starling.extensions.viewProcessorMap.ViewProcessorMapExtension;

import starling.core.Starling;

public class Main extends Sprite {

	private var _context:IContext;
	private var _starling:Starling;

	public function Main() {

		Analytics.getInstance().debug = true;

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
		//this._starling.showStats = true;
		this._starling.start();

		this._context = new Context().install(StarlingBundle, ViewProcessorMapExtension).configure(AppConfig, new ContextView(this._starling))
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

	/*
	 private const ANALYTICS_ID:String = "UA-29711569-2";

	 if (Analytics.isSupported()) {
	 var analytics:Analytics = Analytics.getInstance();
	 var tracker:ITracker = analytics.getTracker(ANALYTICS_ID);

	 // Track a page view
	 tracker.buildView("Home").track();

	 // Track an event
	 tracker.buildEvent("click", "button").withLabel("play").withValue(10).track();
	 tracker.buildEvent("click", "button").withLabel("stop").track();
	 tracker.buildEvent("swipe", "screen").withValue(1).track();
	 tracker.buildEvent("app", "quit").track();

	 // Track an exception
	 tracker.buildException(false).withDescription("ok, an error occurred, but it wasn't that bad").track();
	 tracker.buildException(true).withDescription("panic! this shit is hitting the fan!").track();
	 tracker.buildException(false).track();

	 // Track a timer
	 tracker.buildTiming("loading", 5000).withName("resources").withLabel("audio.mp3").track();
	 tracker.buildTiming("waiting", 1000).track();

	 // Track a social interaction
	 tracker.buildSocial("GooglePlus", "+1").forContent("http://alessandrobianco.eu").track();
	 tracker.buildSocial("Facebook", "like").track();

	 // Track an ecommerce transaction
	 tracker.buildTransaction(new Date().getTime().toString(), 10.5)
	 .withAffiliation("In-App Purchase")
	 .withTaxCost(0.5)
	 .createProduct("cr-300", "300 credits pack", 7, 1).inCategory("credits").add()
	 .createProduct("it-156", "extra life item", 1.5, 2).add()
	 .track();
	 }
	 }
	 */
}
}
