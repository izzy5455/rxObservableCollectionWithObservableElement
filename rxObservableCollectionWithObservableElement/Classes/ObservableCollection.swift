//
//  ObservableArray.swift
//  ObservableArray
//
//  Created by Otero, Alex on 7/13/18.
//  Copyright © 2018 CertifiedNoob LLC. All rights reserved.
//
import Foundation
import RxSwift

public struct ObservableCollection<T> : ExpressibleByArrayLiteral where T: NotifyChanged {
	public typealias arrayChangedType = (event:CollectionChangedEvent, element:[T])
	public typealias collectionType = [T]
	public var rx: PublishSubject<arrayChangedType>!
	public var rxElements: collectionType
	internal var rxChangeType:[arrayChangedType]
	internal let disposeBag = DisposeBag()
	public init(){
		rx = PublishSubject<arrayChangedType>()
		rxElements = []
		rxChangeType = []
	}
	
	public init(count:Int, repeatedValue:T){
		rx = PublishSubject<arrayChangedType>()
		rxElements = Array(repeating: repeatedValue, count: count)
		rxChangeType = []
		guard count > 0  else {
			return
		}
		
		rxChangeType =  [(.insertedIndices(Array(0...count)) , rxElements)]
	}
	
	public init<S: Sequence>(_ s: S) where S.Iterator.Element == T{
		rx = PublishSubject<arrayChangedType>()
		rxElements = Array(s)
		
		rxChangeType = [(event: .insertedIndices((0...rxElements.count).map {$0}),
							element: rxElements)]
		
		
	}
	
	public init(arrayLiteral elements: T...) {
		rxElements = elements
		rxChangeType = [(event: .insertedIndices((0...rxElements.count).map {$0}),
						element: rxElements)]
	}
}








