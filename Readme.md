## Guide Code Challenge

**Instructions**

Simply pull down the repository, open the xcode project, and you should be able to build and run the app

### Description of the problem and solution.

**Problem**

Build a basic list UI from an API endpoint. 

**Solution (Application Flow)**

- On app launch, initialize a GuideListVC as the root view controller
- Get the upcoming guides from the GuideListDataService
  - Use the GuideNetworkService to get the list of guides form the API, then map them to something useful for the VC
    - This just uses NSURLSession
- Display them in a GuideTableViewCell

### Reasoning behind your technical choices. Trade-offs you might have made, anything you left out, or what you might do differently if you were to spend additional time on the project.

**Architecture**

I'm not too opinionated when it comes to Architecture, but generally I stick pretty close to a standard MVC pattern. MVVM or MVP could be used as well, but I don't find massive view controllers (and associated issues) to be problematic if appropriately offloading work to isolated services.

**API Choices**

- This project is exclusively vanilla swift. 
- Task vs DispatchQueue. I opted to use Swift 5 async/await + task instead of DispatchQueue, as it provides a functionally similar result with much cleaner code
- If the project didn't specifically ask for a TableView/CollectionView, I probably would have opted to use SwiftUI, as it makes this kind of list/layout much quicker/easier to implement. 

**Changes with Additional Time**

- Make the UI look a lot nicer
- Add the icons to the UI, and a basic (or complex) Image Cache
- Add a persistence layer to make the app more responsive
- Add a NavigationCoordinator or similar to handle navigation

**Additional Notes**

- The image for the tableview layout wasn't showing up, so I just went with my own basic layout
- The API was not returning Venue (City/State) information. I verified my code should work with this in the Tests, and I added placeholder text in the UI