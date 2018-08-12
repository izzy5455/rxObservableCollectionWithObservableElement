//
//  CollectionChanged.swift
//  ObservableCollection
//
//  Created by Otero, Alex on 8/11/18.
//  Copyright © 2018 CertifiedNoob LLC. All rights reserved.
//

import Foundation


public enum CollectionChangedEvent{
	
	case insertedIndices([Int])
	case deletedIndices([Int])
	case updatedIndices([Int])

}
