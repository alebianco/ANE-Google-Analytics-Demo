/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:38
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.model.LayoutSettings;

import feathers.controls.PanelScreen;
import feathers.controls.ScrollContainer;
import feathers.events.FeathersEventType;
import feathers.layout.VerticalLayout;

import mx.resources.IResourceManager;

import starling.events.Event;

public class BaseScreen extends PanelScreen {

    private static const RESOURCE_BUNDLE_NAME:String = "resources";

    [Inject]
    public var settings:LayoutSettings;

    [Inject]
    public var resources:IResourceManager;

    final protected function getRString(id:String, ...arguments):String {
        return resources.getString(RESOURCE_BUNDLE_NAME, id, arguments);
    }

    override protected function initialize():void {
        super.initialize();

        setupLayout();
        setupScrollingPolicies();
        setupHeader();

        this.owner.addEventListener(FeathersEventType.TRANSITION_COMPLETE, transitionInCompleteHandler);
    }

    protected function setupLayout():void {
        const layout:VerticalLayout = new VerticalLayout();
        layout.gap = settings.gap;
        layout.paddingTop = settings.paddingTop;
        layout.paddingRight = settings.paddingRight;
        layout.paddingBottom = settings.paddingBottom;
        layout.paddingLeft = settings.paddingLeft;
        layout.horizontalAlign = settings.horizontalAlign;
        layout.verticalAlign = settings.verticalAlign;
        this.layout = layout;
    }

    protected function setupScrollingPolicies():void {
        this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_AUTO;
        this.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
        this.snapScrollPositionsToPixels = true;
    }

    protected function setupHeader():void {
        this.headerProperties.title = getRString("home.title");
    }

    private function transitionInCompleteHandler(event:Event):void {
        this.owner.removeEventListener(FeathersEventType.TRANSITION_COMPLETE, transitionInCompleteHandler);
        this.revealScrollBars();
    }

}
}