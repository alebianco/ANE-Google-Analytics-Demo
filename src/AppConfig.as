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
import eu.alebianco.air.extensions.analytics.demo.commands.CreateTracker;
import eu.alebianco.air.extensions.analytics.demo.commands.DestroyTracker;
import eu.alebianco.air.extensions.analytics.demo.commands.ShowScreen;
import eu.alebianco.air.extensions.analytics.demo.commands.macro.ChangeTrackerMacro;
import eu.alebianco.air.extensions.analytics.demo.commands.macro.StartupMacro;
import eu.alebianco.air.extensions.analytics.demo.commands.guards.NoTrackerRegistered;
import eu.alebianco.air.extensions.analytics.demo.commands.guards.OtherTrackerRegistered;
import eu.alebianco.air.extensions.analytics.demo.events.CreateTrackerEvent;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.mediators.NavigateMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.TrackerBuilderMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.MainMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.GlobalSettingsMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.VersionDisplayMediator;
import eu.alebianco.air.extensions.analytics.demo.model.LayoutSettings;
import eu.alebianco.air.extensions.analytics.demo.model.ResourceBundle;
import eu.alebianco.air.extensions.analytics.demo.views.BaseScreen;
import eu.alebianco.air.extensions.analytics.demo.views.api.IBuildTrackers;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayVersion;
import eu.alebianco.air.extensions.analytics.demo.views.api.IManageGlobalSettings;
import eu.alebianco.air.extensions.analytics.demo.views.api.INavigateScreens;

import feathers.controls.ScreenNavigator;

import flash.events.IEventDispatcher;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.bender.extensions.matching.TypeMatcher;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.LifecycleEvent;
import robotlegs.starling.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.starling.extensions.viewProcessorMap.api.IViewProcessorMap;

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
		mediator.map(IDisplayVersion).toMediator(VersionDisplayMediator);
		mediator.map(IBuildTrackers).toMediator(TrackerBuilderMediator);
		mediator.map(INavigateScreens).toMediator(NavigateMediator);
		mediator.map(IManageGlobalSettings).toMediator(GlobalSettingsMediator);

		views.mapMatcher(new TypeMatcher().allOf(BaseScreen)).toInjection();

		commander.map(LifecycleEvent.POST_INITIALIZE, LifecycleEvent).toCommand(StartupMacro);
        commander.map(CreateTrackerEvent.CREATE, CreateTrackerEvent).toCommand(ChangeTrackerMacro);
		commander.map(NavigateEvent.TO, NavigateEvent).toCommand(ShowScreen);
	}
}
}
