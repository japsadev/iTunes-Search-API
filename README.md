<h1 align="center"> iMusic  </h1>

iMusic is a music preview application developed using the iTunes search API, where I try to provide a user experience with static data in general.
### Note : The application has been completely renewed. <a href="https://github.com/devmehmetates/iTunes-Search-API/blob/main/OldREADME.md">Click here</a>  to view the old generation version.

## Used technologies - New generation
+ **Pure SwiftUI**
+ **MVVM** Design Pattern
+ **AVKit**
+ <a href="https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html"> **iTunes Search API** </a>
+ **File Dictionary**

## Working principle
iMusic sends requests to the API using the static song names it contains and presents the results to the user as if it were a real list. In addition, by using the preview link provided on the response and AVKit, it allows the user to listen to the featured 30 seconds of the desired song. User can search for songs, view songs and artists, and add songs as favourites.

## Changes in the new version?
+ Huge performance improvements.
+ Unnecessary code cleaning and a clean code structure.
+ Service centralization.
+ Lots of visual editing.
+ Make it more flexible and user-friendly.
+ Lots of error handling.

## App Design

![Mockup](https://user-images.githubusercontent.com/74152011/174617137-0077121e-220f-4002-85eb-885b229b2daf.png)

## Demo Images
<div>
  <img width="255" alt="Screen Shot 2022-06-20 at 4 57 02 PM" src="https://user-images.githubusercontent.com/74152011/174618147-0af46242-d977-461a-8ce0-dbe570023638.png">
  <img width="255" alt="Screen Shot 2022-06-20 at 4 57 11 PM" src="https://user-images.githubusercontent.com/74152011/174618140-b053ef84-bcff-411b-8f81-67f598767a13.png">
  <img width="255" alt="Screen Shot 2022-06-20 at 4 57 26 PM" src="https://user-images.githubusercontent.com/74152011/174618130-37de7b9d-1475-4ee2-82eb-ade990518723.png">
  <img width="255" alt="Screen Shot 2022-06-20 at 4 58 01 PM" src="https://user-images.githubusercontent.com/74152011/174618122-e883f6a8-2023-456f-bd65-b75f2fdfa734.png">
  <img width="255" alt="Screen Shot 2022-06-20 at 4 57 53 PM" src="https://user-images.githubusercontent.com/74152011/174618113-e9abe85d-19b0-4305-ae63-4b5fe74da700.png">
  <img width="255" alt="Screen Shot 2022-06-20 at 4 58 34 PM" src="https://user-images.githubusercontent.com/74152011/174618107-9a4e36d0-bd63-4365-bc7e-b012aee6dba7.png">
</div>

