/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 31/05/2013 12:08
 */
package {

import eu.alebianco.air.extensions.analytics.Analytics;
import eu.alebianco.air.extensions.analytics.api.IAnalytics;
import eu.alebianco.air.extensions.analytics.demo.AnalyticsDemo;
import eu.alebianco.air.extensions.analytics.demo.commands.ShowScreen;
import eu.alebianco.air.extensions.analytics.demo.commands.Startup;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.mediators.HomeMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.MainMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.SettingsMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.UnsupportedMediator;
import eu.alebianco.air.extensions.analytics.demo.model.LayoutSettings;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;
import eu.alebianco.air.extensions.analytics.demo.views.HomeScreen;
import eu.alebianco.air.extensions.analytics.demo.views.SettingsScreen;
import eu.alebianco.air.extensions.analytics.demo.views.UnsupportedScreen;

import feathers.controls.ScreenNavigator;

import flash.events.IEventDispatcher;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.starling.extensions.viewProcessorMap.api.IViewProcessorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.LifecycleEvent;
import robotlegs.starling.extensions.mediatorMap.api.IMediatorMap;

public class AppConfig implements IConfig {

    [Inject]
    public var injector:Injector;

    [Inject]
    public var mediator:IMediatorMap;

    [Inject]
    public var commander:IEventCommandMap;

	[Inject]
	public var views:IViewProcessorMap;

	[Inject]
    public var dispatcher:IEventDispatcher;

    public function configure():void {

        injector.map(LayoutSettings).asSingleton();
        injector.map(ResourceBundle).asSingleton();
        injector.map(ScreenNavigator).asSingleton();
        injector.map(IAnalytics).toValue(Analytics.getInstance());

        mediator.map(AnalyticsDemo).toMediator(MainMediator);
        mediator.map(UnsupportedScreen).toMediator(UnsupportedMediator);
        mediator.map(HomeScreen).toMediator(HomeMediator);
        mediator.map(SettingsScreen).toMediator(SettingsMediator);

	    views.map(HomeScreen).toInjection();
	    views.map(UnsupportedScreen).toInjection();

        commander.map(LifecycleEvent.POST_INITIALIZE, LifecycleEvent).toCommand(Startup);
        commander.map(NavigateEvent.TO, NavigateEvent).toCommand(ShowScreen);
    }
}
}
