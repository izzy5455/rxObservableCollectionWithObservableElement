//
//  ObservableCollection+Extension.swift
//  ObservableCollection
//
//  Created by Otero, Alex on 8/11/18.
//  Copyright © 2018 CertifiedNoob LLC. All rights reserved.
//

import Foundation

 extension ObservableCollection{
	
	func arrayDidChange(event: arrayChangedType) {
		rx.onNext(event)
	}
	
	func subscribeForEntityChange(elements:[T]){
		let x = elements.enumerated()
		for (index, element) in x {
			element.elementChanged.subscribe({ event in
				self.arrayDidChange(event: arrayChangedType(event: .updatedIndices([index]), element: [element]))
			}).disposed(by: disposeBag)
		}
	}
}

 extension ObservableCollection: MutableCollection{
	
	
	public mutating func reserveCapacity(_ minimumCapacity: Int) {
		rxElements.reserveCapacity(minimumCapacity)
	}
	
	public mutating func append(_ newElement: T) {
		rxElements.append(newElement)
		subscribeForEntityChange(elements: [newElement])
		arrayDidChange(event: arrayChangedType(.insertedIndices( [rxElements.count - 1]),[newElement]))
	}
	
	public mutating func append<S : Sequence>(contentsOf newElements: S) where S.Iterator.Element == T {
		let end = rxElements.count
		rxElements.append(contentsOf: newElements)
		guard end != rxElements.count else {
			return
		}
		subscribeForEntityChange(elements: newElements.map{ $0 })
		arrayDidChange(event: arrayChangedType( .insertedIndices(Array(end..<rxElements.count)), newElements.map{ $0 }))
	}
	
	public mutating func appendContentsOf<C : Collection>(_ newElements: C) where C.Iterator.Element == T {
		guard !newElements.isEmpty else {
			return
		}
		let end = rxElements.count
		rxElements.append(contentsOf: newElements)
		subscribeForEntityChange(elements: newElements.map{ $0 })
		arrayDidChange(event: arrayChangedType( .insertedIndices(Array(end..<rxElements.count)), newElements.map{ $0 }))
	}
	
	@discardableResult public mutating func removeLast() -> T {
		let lastElement = rxElements.removeLast()
		arrayDidChange(event: arrayChangedType( .deletedIndices( [rxElements.count]),[lastElement]))
		
		return lastElement
	}
	
	public mutating func insert(_ newElement: T, at i: Int) {
		rxElements.insert(newElement, at: i)
		subscribeForEntityChange(elements: [newElement])
		arrayDidChange(event: arrayChangedType( .insertedIndices([i]),[newElement]))
	}
	
	@discardableResult public mutating func remove(at index: Int) -> T {
		let elementAt = rxElements.remove(at: index)
		arrayDidChange(event: arrayChangedType(.deletedIndices([index]), [elementAt]))
		return elementAt
	}
	
	public mutating func removeAll(_ keepCapacity: Bool = false) {
		guard !rxElements.isEmpty else {
			return
		}
		let removedElements = rxElements
		rxElements.removeAll(keepingCapacity: keepCapacity)
		arrayDidChange(event: arrayChangedType(.deletedIndices(Array(0..<removedElements.count)),removedElements))
	}
	
	public mutating func insertContentsOf(_ newElements: [T], atIndex i: Int) {
		guard !newElements.isEmpty else {
			return
		}
		rxElements.insert(contentsOf: newElements, at: i)
		arrayDidChange(event: arrayChangedType(.insertedIndices(Array(i..<i + newElements.count)),newElements))
		subscribeForEntityChange(elements: newElements)
	}
	
	public mutating func popLast() -> T? {
		let lastElement = rxElements.popLast()
		if let lastElement = lastElement {
			arrayDidChange(event: arrayChangedType(.deletedIndices([rxElements.count]), [lastElement]))
		}
		return lastElement
	}
	
	
}

 extension ObservableCollection:Collection  {
	public typealias Element = T
	
	public typealias Index = collectionType.Index
	
	public var startIndex: Index { get{ return rxElements.startIndex } }
	
	public var endIndex: Index { get{ return rxElements.endIndex } }
	
	public func index(after i: Index) -> Index {
		return rxElements.index(after: i)
	}
	
	public subscript(position:Index)-> T{
		get{
			return rxElements[position]
		}
		
		set(newValue){
			rxElements[position] = newValue
		}
	}
}
