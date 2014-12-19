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
* Rename the _user.properties.eg_ file in the _gradle_ folder to _user.properties_ and follow the instructions to fill the appropriate values.
* Execute the `gradlew launch` script.