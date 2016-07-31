# johnLewis
## Third Party Dependences
I am using [Carthage](https://github.com/Carthage/Carthage) as a third party dependency manager. For this tech test, we will include carthage builds into the repo. Normally, we would need to use carthage update and let that build the libraries. This is to ensure when you do the build, it should work without the use of carthage.

* [AFNetworking](https://github.com/AFNetworking/AFNetworking) - For making network calls to the API

* [JSONModel](https://github.com/jsonmodel/jsonmodel) - A tool to map JSON objects to Objective-C objects

## Assumptions and Notes
* CommsHandler class has some service methods for the product grid page and product page. I would normally have each services separately that all use the CommsHandler.
* I assume there is a menu system or even a login system. This can be done using the left navigation bar.
* I did not use any WebViews due to poor performance and always prefer native elements.
* The productInformation string contains HTML elements with class definitions that require an accompanying CSS file (not supplied). I assume this was used for the web where there is a CSS already loaded. This would mean that there should be a mobile version of productInformation that does not have HTML.
* For now we are using dishwashers as an example. But my code here allows for anything to be searched and loaded the same way. Check code below. Where it says "q=dishasher", you can change that to anything else, i.e. "q=ovens" and it will return 20 oven products that can be clicked on. This method allows for adding additional service classes that deal with searching or going to specific product pages. For example, deep linking from google to open up product in the app.

```objective-c
+ (void)getProductsWithCompletion:(void(^)(NSArray *products))completion {
    [CommsHandler requestFromResource:@"products" action:@"search" queries:@[@"q=dishwasher",@"key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb",@"pageSize=20"] completion:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]){
            //Would normally use an entity, but doing it quick for now.
            completion(response[@"products"]);
        }
    }];
}
```
