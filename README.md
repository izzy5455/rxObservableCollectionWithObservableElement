# rxObservableCollectionWithObservableElement

[![CI Status](https://img.shields.io/travis/ismael.a.otero@gmail.com/rxObservableCollectionWithObservableElement.svg?style=flat)](https://travis-ci.org/ismael.a.otero@gmail.com/rxObservableCollectionWithObservableElement)
[![Version](https://img.shields.io/cocoapods/v/rxObservableCollectionWithObservableElement.svg?style=flat)](https://cocoapods.org/pods/rxObservableCollectionWithObservableElement)
[![License](https://img.shields.io/cocoapods/l/rxObservableCollectionWithObservableElement.svg?style=flat)](https://cocoapods.org/pods/rxObservableCollectionWithObservableElement)
[![Platform](https://img.shields.io/cocoapods/p/rxObservableCollectionWithObservableElement.svg?style=flat)](https://cocoapods.org/pods/rxObservableCollectionWithObservableElement)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

rxObservableCollectionWithObservableElement is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'rxObservableCollectionWithObservableElement'
```

## Author

ismael.a.otero@gmail.com, ismael.otero@allscripots.com

## License

rxObservableCollectionWithObservableElement is available under the MIT license. See the LICENSE file for more info.
=======



# Observable Collection

This observable collection works just likes any other providing collection changed events on insertions and deletions. Where this differs is that each element must implement the NotifyChanged protocol discussed below. This allows not only to received event's if elements are inserted but receive events for object's that implement the NotifyChanged Protocol any time a Variable is modified.

# NotifyChanged Protocol

```swift
protocol NotifyChanged: class {
func raiseChangeFor<A>(keyPath: AnyKeyPath, old:A, new:A)
func set<A>(keyPath: ReferenceWritableKeyPath<Self, A>, value: A)
var elementChanged: PublishSubject<(keyPath: AnyKeyPath, old:Any, new:Any)>{ get }
}
```

This protocol really only has one thing of note, and that is this  generic set method that can be used as below.
```Swift
elements.set(keyPath: \something.money, value: 100) 
/// you can use the set method to set any variable in your class this method emits an event on the obeservable collection letting the subscriber that an element in the observable collection has changed.
///

NOTE:
elements.money = 100 //does not emit collection changed event

```
# Full Example
```swift
final class something:NotifyChanged { //any class that inherits this must be a final class probably because im still a n0_ob
var elementChanged: PublishSubject<(keyPath: AnyKeyPath, old: Any, new: Any)>

var string:String
var int:Int
var money: Double
init(string:String,int:Int, money:Double) {
self.string = string
self.int = int

self.money = money


elementChanged = PublishSubject<(keyPath: AnyKeyPath, old: Any, new: Any)>()
}
}
var t = ObservableCollection<something>()


t.rx.subscribe { (event) in
print(event.element?.event.updatedIndeces.count)
}

var elements = something(string: "", int: 0, money: 0.0)

t.append(elements)

elements.set(keyPath: \something.money, value: 100) 
/// you can use the set method to set any variable in your class this method emits an event on the obeservable collection letting the subscriber that an element in the observable collection has changed.
///

t.append(something(string: "", int: 0, money: 100.0))
t[1].money = 0 // or set the variable directly note this does not emit an collectionchanged event.

```
