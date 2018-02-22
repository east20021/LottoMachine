//
//  ListViewController.swift
//  LottoMachine
//
//  Created by lee on 2018. 2. 19..
//  Copyright © 2018년 smith. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var statusBar: UIView!
    
    private var realm: Realm!
    private var contentsList: Results<Number>!
    
    private var numberManager = NumberManager()
    private let themaColor = ThemaColorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRealm()
        setThema()
        setFlowLayout()
    }
    
    func setRealm() {
        do {
            realm = try Realm()
        } catch {
            print("\(error)")
        }
        contentsList = numberManager.getNumbers(type: Number.self)
    }
    
    func setThema() {
        let hex = themaColor.hex
        self.statusBar.backgroundColor = UIColor(hex: hex)
        self.collectionView.backgroundColor = UIColor(hex: hex)
    }
    
    func setFlowLayout() {
        let width = (view.frame.size.width)
        let height = (view.frame.size.height) / 6
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = contentsList[indexPath.row].lottoNum
        }
        return cell
    }
    
}
