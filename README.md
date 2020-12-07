# WanderList - A Travel Wish List
An iOS application to create and manage travel wishlist

## Summary
* [Introduction & General Information](#introduction--general-information)
* [Application Design](#application-design)
* [Run Locally](#run-locally)

## Introduction & General Information
- This iOS application is aimed at providing users with various functions to create and interact with their travel wishlist places.
- Users can view information about a particular place, find it in embedded maps, and view/add/update/delete notes about that particular place.
  - As of now, the application feautures a comprehensive list of popular travel destinations from around the world.
  - In future versions, functionality for users to add their own location will be added.
- This application is not yet published in the iOS app store, however it will be published soon.

## Application Design
- Wanderlist iOS application is based on multi controller design, presented modally.
- This application is powered by [Core Data Framework](https://developer.apple.com/documentation/coredata) in the backend.
- Some of the screenshots are shown below, which outline the design.

### Home Screen
![Home Screen](https://github.com/setu-parekh/wanderlist-ios-application/blob/main/Images/home-screen.png)
![Home Screen 1](https://github.com/setu-parekh/wanderlist-ios-application/blob/main/Images/home-screen-1.png)
![Home Screen 2](https://github.com/setu-parekh/wanderlist-ios-application/blob/main/Images/home-screen-2.png)

### Get Information about a Particular Location
![Detail Info Screen](https://github.com/setu-parekh/wanderlist-ios-application/blob/main/Images/detail-info-screen.png)

### Find a Particular Location in an Embedded Map
![Detail Map Screen](https://github.com/setu-parekh/wanderlist-ios-application/blob/main/Images/detail-map-screen.png)

### Create or Update a Note Related to a Location
![Create or Update Note](https://github.com/setu-parekh/wanderlist-ios-application/blob/main/Images/detail-note-create-screen.png)

### View or Delete a Note Related to a Location
![View or Delete Note](https://github.com/setu-parekh/wanderlist-ios-application/blob/main/Images/detail-note-view-delete-screen.png)

## Run Locally
* Make sure XCode is installed. XCode can be installed from [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12).
* Go to Terminal and clone the project: `git clone https://github.com/setu-parekh/wanderlist-ios-application.git`.
* Open XCode and open the project from location where it is cloned.
* Build and run the project by pressing `CMD + R` on the keyboard.
