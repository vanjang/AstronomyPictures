# AstronomyPictures

Astronomy Pictures is an iOS application project that shares amazing images related to space.
This project utilises NASA's [Astronomy Picture of the Day(APOD)](https://api.nasa.gov/) API to fetch and display a new space image every day.


**How to install**

- To run the project, just clone the [repository](https://github.com/vanjang/AstronomyPictures.git) and run, then you are good to go.


**Key Features**

- This is a fairly simple app consisting of two parts; Main page with space images and their detail pages.
- You can see the detailed explanation and HD quality picture by clicking on each image.
- The images are paginated so you will see more as you scroll down.


**Tech Stack**

- Swift
- UIKit
- SwiftUI
- Combine
- MVVM
- Unit Testing
- UI Testing
- Kingfisher library is imported for displaying remote images


**Project Structure**

- Main: The app's main view, accompanied by the View, ViewModel, and its logic.
- PictureDetail: Each image's detail page, accompanied by the View, ViewModel, and its logic.
- Network: The network layer with its protocols.
- APODUseCase: Defines the core usages of the APOD API.
- Model: Contains the data models used in the project.
- PropertyWrapper: Includes custom property wrappers.
- Util: Holds utility functions and classes. Currently, there is only PaginationManager that assists with API requests using offset.
 
