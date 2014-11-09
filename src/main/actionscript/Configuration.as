/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:08
 */
package {
import eu.alebianco.air.extensions.analytics.demo.AnalyticsDemo;
import eu.alebianco.air.extensions.analytics.demo.commands.GetVersion;
import eu.alebianco.air.extensions.analytics.demo.commands.ShowScreen;
import eu.alebianco.air.extensions.analytics.demo.commands.hooks.CreateReportSession;
import eu.alebianco.air.extensions.analytics.demo.commands.macros.DisplayReportDetails;
import eu.alebianco.air.extensions.analytics.demo.commands.macros.ExecuteTestSuiteMacro;
import eu.alebianco.air.extensions.analytics.demo.commands.macros.StartupMacro;
import eu.alebianco.air.extensions.analytics.demo.events.DisplayReportDetailsEvent;
import eu.alebianco.air.extensions.analytics.demo.events.ExecuteSuiteEvent;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.events.RequestVersionEvent;
import eu.alebianco.air.extensions.analytics.demo.mediators.BackMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.MainMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.SuiteInformationMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.TestReportMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.TestSuiteListMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.VersionDisplayMediator;
import eu.alebianco.air.extensions.analytics.demo.model.LayoutSettings;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.model.TestsBundle;
import eu.alebianco.air.extensions.analytics.demo.views.BaseScreen;
import eu.alebianco.air.extensions.analytics.demo.views.api.IBack;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayTestReports;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayVersion;
import eu.alebianco.air.extensions.analytics.demo.views.api.IListTestSuites;

import feathers.controls.ScreenNavigator;

import flash.events.IEventDispatcher;
import flash.filesystem.File;

import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.bender.extensions.matching.TypeMatcher;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;
import robotlegs.bender.framework.api.LifecycleEvent;
import robotlegs.starling.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.starling.extensions.viewProcessorMap.api.IViewProcessorMap;

import starling.utils.AssetManager;

public class Configuration implements IConfig {

    [Inject]
    public var injector:IInjector;

    [Inject]
    public var mediator:IMediatorMap;

    [Inject]
    public var commander:IEventCommandMap;

    [Inject]
    public var views:IViewProcessorMap;

    [Inject]
    public var dispatcher:IEventDispatcher;

    public function configure():void {

        injector.map(IResourceManager).toValue(ResourceManager.getInstance());
        injector.map(File, "assets").toValue(File.applicationDirectory.resolvePath("assets"));
        injector.map(LayoutSettings).asSingleton();
        injector.map(ScreenNavigator).asSingleton();
        injector.map(AssetManager).toValue(new AssetManager(1, false));
        injector.map(TestsBundle).asSingleton();
        injector.map(SessionStorage).asSingleton();

        mediator.map(IBack).toMediator(BackMediator);
        mediator.map(AnalyticsDemo).toMediator(MainMediator);
        mediator.map(IDisplayVersion).toMediator(VersionDisplayMediator);
        mediator.map(IListTestSuites).toMediator(TestSuiteListMediator);
        mediator.map(IDisplayTestReports).toMediator(TestReportMediator);
        mediator.map(IDisplaySuiteInformation).toMediator(SuiteInformationMediator);

        views.mapMatcher(new TypeMatcher().allOf(BaseScreen)).toInjection();

        commander.map(LifecycleEvent.POST_INITIALIZE, LifecycleEvent).toCommand(StartupMacro);
        commander.map(NavigateEvent.TO, NavigateEvent).toCommand(ShowScreen);
        commander.map(RequestVersionEvent.GET, RequestVersionEvent).toCommand(GetVersion);
        commander.map(ExecuteSuiteEvent.RUN, ExecuteSuiteEvent).toCommand(ExecuteTestSuiteMacro).withHooks(CreateReportSession);
        commander.map(DisplayReportDetailsEvent.SHOW, DisplayReportDetailsEvent).toCommand(DisplayReportDetails);
    }
}
}