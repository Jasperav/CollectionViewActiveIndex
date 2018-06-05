//
//  ViewController.swift
//  CollectionViewActiveIndex
//
//  Created by Jasper Visser on 05-06-18.
//  Copyright © 2018 Jasper Visser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: CollectionView!
    static var activeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.go()
    }
}

class Cell: UICollectionViewCell {
    @IBOutlet weak var button: MyButton!
    
}

class MyButton: UIButton {}

class CollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    func go() {
        delegate = self
        dataSource = self
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        if indexPath.row == ViewController.activeIndex {
            cell.button.setTitle("active", for: .normal)
        } else {
            cell.button.setTitle("not active", for: .normal)
        }
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc private func touchUpInside(_ sender: UIButton){
        let hitPoint = sender.convert(CGPoint.zero, to: self)
        guard let indexPath = indexPathForItem(at: hitPoint), let cell = cellForItem(at: indexPath) as? Cell else { return }
        
        if let oldCell = (visibleCells as! [Cell]).first(where: { $0.button.titleLabel!.text == "active" }) {
            oldCell.button.setTitle("not active", for: .normal)
        }
        
        cell.button.setTitle("active", for: .normal)
        
        ViewController.activeIndex = indexPath.row
    }
    
}
