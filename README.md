# Recipe-App 🥘
This is an Application that shows you a list of food categories presented in a table view, when you pick a category(Cell), it presents a list of meals under the chosen category. 

<img width="455" alt="Screen Shot 2022-02-11 at 5 55 59 PM" src="https://user-images.githubusercontent.com/61053657/153686390-3a1b19ee-5d4f-4611-aeed-710e20031275.png">

<img width="465" alt="Screen Shot 2022-02-11 at 5 56 35 PM" src="https://user-images.githubusercontent.com/61053657/153686422-b090b983-903d-44b5-b559-ddcf6d4c6a16.png">

<img width="473" alt="Screen Shot 2022-02-11 at 5 57 16 PM" src="https://user-images.githubusercontent.com/61053657/153686448-db49c38d-6128-4edf-aa36-8968e5007eb6.png">

# Prerequisites
Things you need to install the software 
- [Xcode](https://developer.apple.com/xcode/)

# Project Structure
This application has 3 major view controllers. The `CategoryListVC` is the first screen the user lands on after launching the app. It shows a list of meal categories in a table view, when a cell/category is selected, the `MealListVC` is presented. This shows a list of meals in the chosen category, when a meal is selected the `RecipeVC` is presented. This shows the recipe for preparing the selected meal as well as the ingredients required to prepare the meal.

# Network Layer
This project uses the MVC design pattern.
Data is gotten from [themealdb](https://www.themealdb.com).
The network layer uses `URLSession` to make requests to the remote server in order to fetch data.
The `NetworkManager` class holds all the methods for requesting all the data required for the application. Its also important to not that this class is a [Singleton](https://developer.apple.com/documentation/swift/cocoa_design_patterns/managing_a_shared_resource_using_a_singleton) and can be accessed anywhere it's needed.
See the example below of `downloadCategoryImage` that we used to download the image associated with each meal category.

` 
func downloadCategoryImage() {
        guard let imageUrl = category?.strCategoryThumb else { return }
        NetworkManager.shared.downloadImage(from: imageUrl ) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.categoryImageView.image = image
            }
        }
    }
    `
    
  we call the singleton like so `NetworkManager.shared` and thereby access the `downloadImage` method with which we get image data.
  
  # View Layer
  All views are built programmatically.
  
  # Model Layer
  The model consists of the following Codable structs `FoodCategory`, `Category`, `Meals`, `Meal`, `MealRecipe`, `Recipes` and we parse JSON using a `JSONDecoder()`   and a keyDecodingStrategy to convert the data from camel case to snake case.
  

