# Questions part

1. Explain some differences between a modal and push navigation.
Modal presentation covers the whole UI. In can be considered as an interruption of what user is doing right now with ability to perform an action and then return back. Modal presentation should be used, for example, for presenting paywalls, performing inline authorizing when unauthorized user tries to leave a comment, etc.
Push navigation is used when you're advancing in a sequence of connected screens, for example exploring nested collections, making multi-step onboarding, etc.
Technically push navigation keeps a LIFO stack of viewcontrollers inside itself and uses slide from side animation, while modal presentation uses linked list of viewcontrollers (presentingViewController <-> presentedViewController) and features slide from bottom animation. 

2. When is it preferred to use Keychain Services, UserDefaults or Core Data? Please explain some different scenarios or use cases.
Keychain Services provides additional security and should be used for storing passwords or auth tokens. Keychain content is not removed along with the application, so keychain can be used to keep information even if the app was uninstalled and reinstalled again.
UserDefaults is basically a dictionary stored in a form of an XML file (property list). This file is written at once, so usually you want to keep this file as small as possible. It can keep small amounts of non-sensitive data which we want to retain between sessions. For example,  timestamp of the last news feed update, IDs of favorite recipies or number of application launches to determine if it is ok to show "review us" prompt already.
CoreData is a relational database used to store significant amounts of data and it provides powerful instruments to query datasets even if there are millions of records. 

3. Given the following function inside a UIViewController, what can go wrong here?:
```func fetchData() {
        service.fetchFromAPI { result in
            self.data = result
        }
    }```
    - Architecturally, I'd put fetching into a viewmodel layer, not in viewcontroller
    - I suppose, fetching is done on background thread, so we will probably want to ensure that assignment is done on main thread. If there is any UI refreshing in didSet of self.data, assignment should be called on main to avoid errors. One way is to enqueue update on DispatchQueue.main
    - Not clear if errors are handled or not. Anyway it's better to handle all possible outcomes on the same level.
    
4. Give a brief explanation of protocol oriented programming.

Value types (structs and enums) do not support inheritance. However, they support conforming to protocols. Protocol Oriented Programming encourages us to use value types over reference types and replace inheritance with conforming to protocols. Unlike regular inheritance, an object can conform to multiple protocols at once and we also can provide default implementations of protocol methods via protocol extrensions, even making them different form different kinds of objects.
On my opinion, POP is not a silver bullet, but just another powerful technique with it's own pros and cons and we can take most of it using it in conjuction with other approaches where applicable.
