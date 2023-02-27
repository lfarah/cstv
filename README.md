# CSTV
CSTV is an app that displays CS: GO matches happening across several worldwide tournaments

| Demo |
| --- |
![Simulator Screen Recording - iPhone 14 Pro - 2023-02-26 at 23 03 53](https://user-images.githubusercontent.com/6511079/221455277-6f1283d6-d6b0-4bef-9708-765c49adb163.gif)

### Architecture
This app was made in MVVM. The architecture follows the following Layers:
* UI (```MatchListViewController```,```MatchDetailViewController```)
* ViewModel (```MatchListViewModel```)
* Service (```Match Service```)

### External Tools
* [Swiftlint](https://github.com/realm/SwiftLint): tool to enforce Swift style and conventions.
* [RxSwift](https://github.com/ReactiveX/RxSwift): reactive programming
* [Alamofire](https://github.com/Alamofire/Alamofire): network calls
* [Kingfisher](https://github.com/onevcat/Kingfisher): Image loading/caching

### What would I have done if I had more time?
* Repository Layer: It's job is to know where to fetch information from: Cache or Backend, for example
* Coordinator: it's job is to coordinate VC's presentation.
* Correct fonts and weights
* Custom Swiftlint rules
* Unit Tests for making sure password generation works how it's supposed to do
* Pagination
* Better way to handle collectionview cells with UICollectionViewCompositionalLayout

### Bugs and Limitations
* There's a "bug" in the API where it returns a ```not_started``` status even though the match's date already started, which causes the date not to be red
