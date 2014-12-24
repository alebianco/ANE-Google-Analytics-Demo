# ANELytics-Demo

Project used to test and showcase the features of the [Google Analytics AIR extension](https://github.com/alebianco/ANE-Google-Analytics).

## Introduction

The project is built as a FlexUnit tests runner to be ran on mobile devices. This makes the project flexible enough so that every new feature of the native extension requires minimal changes on the demo itself.
It also allows to test individual features and assure non-breaking changes between releases.

Coincidentally the project makes also use of my other two open source projects: [RoboStarlegs](https://github.com/alebianco/robotlegs-utilities-starling) and [Macrobot](https://github.com/alebianco/robotlegs-utilities-macrobot).

## Usage

Check out the code and build from the sources.
This is meant to be a testing and debugging project and no release version will be provided.

## Building

Steps:
* Add your certificate in the root folder with the name _ANELytics-Demo.p12_
* If building for iOS add your provision file in the root folder with the name _ANELytics-Demo.mobileprovision_
* Edit _gradle.properties_ file to specify for which platform you're building the app and on which device you want to install it.
* Execute the build passing your certificate password `gradlew launch -Pstorepass=<password>`.
