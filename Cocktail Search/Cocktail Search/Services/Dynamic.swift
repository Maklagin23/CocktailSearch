//
//  Dynamic.swift
//  Cocktail Search
//
//  Created by Maksim Maklagin on 01.03.2023.
//

class Dynamic <T> {
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    init(_ v: T) {
        value = v
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
}
