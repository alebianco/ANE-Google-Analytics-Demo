/**
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 02/11/2014 18:08
 */
package {
import avmplus.DescribeTypeJSON;

import eu.alebianco.air.extensions.analytics.demo.AnalyticsDemo;
import eu.alebianco.air.extensions.analytics.demo.commands.DisplayReport;
import eu.alebianco.air.extensions.analytics.demo.commands.GetVersion;
import eu.alebianco.air.extensions.analytics.demo.commands.ShowScreen;
import eu.alebianco.air.extensions.analytics.demo.commands.hooks.StopCurrentTest;
import eu.alebianco.air.extensions.analytics.demo.commands.macros.ExecuteSuiteMacro;
import eu.alebianco.air.extensions.analytics.demo.commands.macros.StartupMacro;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.events.RequestVersionEvent;
import eu.alebianco.air.extensions.analytics.demo.events.SelectedReportEvent;
import eu.alebianco.air.extensions.analytics.demo.events.SelectedSuiteEvent;
import eu.alebianco.air.extensions.analytics.demo.mediators.BackMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.MainMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.ReportDetailsMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.SuiteInformationMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.SuiteProgressMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.TestReportListMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.TestSuiteListMediator;
import eu.alebianco.air.extensions.analytics.demo.mediators.VersionDisplayMediator;
import eu.alebianco.air.extensions.analytics.demo.model.LayoutSettings;
import eu.alebianco.air.extensions.analytics.demo.model.SessionStorage;
import eu.alebianco.air.extensions.analytics.demo.tests.runner.SessionListener;
import eu.alebianco.air.extensions.analytics.demo.views.BaseScreen;
import eu.alebianco.air.extensions.analytics.demo.views.api.IBack;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayExecutionProgress;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayReportDetails;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplaySuiteInformation;
import eu.alebianco.air.extensions.analytics.demo.views.api.IListTestReports;
import eu.alebianco.air.extensions.analytics.demo.views.api.IDisplayVersion;
import eu.alebianco.air.extensions.analytics.demo.views.api.IListTestSuites;

import feathers.controls.ScreenNavigator;

import flash.events.IEventDispatcher;
import flash.filesystem.File;

import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

import org.flexunit.runner.FlexUnitCore;
import org.flexunit.runner.notification.RunListener;

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
        injector.map(SessionStorage).asSingleton();
        injector.map(RunListener).toSingleton(SessionListener);
        injector.map(FlexUnitCore).toValue(new FlexUnitCore());
        injector.map(DescribeTypeJSON).asSingleton();

        mediator.map(IBack).toMediator(BackMediator);
        mediator.map(AnalyticsDemo).toMediator(MainMediator);
        mediator.map(IDisplayVersion).toMediator(VersionDisplayMediator);
        mediator.map(IListTestSuites).toMediator(TestSuiteListMediator);
        mediator.map(IListTestReports).toMediator(TestReportListMediator);
        mediator.map(IDisplaySuiteInformation).toMediator(SuiteInformationMediator);
        mediator.map(IDisplayExecutionProgress).toMediator(SuiteProgressMediator);
        mediator.map(IDisplayReportDetails).toMediator(ReportDetailsMediator);

        views.mapMatcher(new TypeMatcher().allOf(BaseScreen)).toInjection();

        commander.map(LifecycleEvent.POST_INITIALIZE, LifecycleEvent).toCommand(StartupMacro);
        commander.map(NavigateEvent.TO, NavigateEvent).toCommand(ShowScreen).withHooks(StopCurrentTest);
        commander.map(RequestVersionEvent.GET, RequestVersionEvent).toCommand(GetVersion);
        commander.map(SelectedSuiteEvent.CHANGE, SelectedSuiteEvent).toCommand(ExecuteSuiteMacro);
        commander.map(SelectedReportEvent.CHANGE, SelectedReportEvent).toCommand(DisplayReport);
    }
}
}