# Recipe Explorer

This app allows you to browse recipes hosted on Marley Spoon's contentful account.

## Using The App

To run the app simply checkout this repository and run using XCode. No need to run `pod install` as all pods were pushed to remote following the guideline by Cocoapods.

There are two screens in the app, the main recipes list screen where a summary of different recipes can be seen and a details screen. On tapping on any of the cells on the list, a details screen can be seen that allows a more in depth look at the recipe.

## Technical Implementation

The app uses the MVVM-C architecture. The coordinator creates an instance of the RecipeViewController and returns it to the App Delegate where it is set as the root view controller of a navigation controller which itself becomes the root of window. Each view controller is injected with a view model which handles fetching and providing data to the view controller. The decision to avoid using a storyboard is in appreciation of the fact that storyboards are difficult to manage in a shared development team.

## Third Party Frameworks

1. Contentful
	- Used to access data from the Contentful CDN.

2. Down
	- Used to parse content provided in the mark down format.
  
3. SDWebImage
  - Used to asynchronously fetch profile images.
