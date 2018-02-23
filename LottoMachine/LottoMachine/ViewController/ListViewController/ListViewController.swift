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
    @IBOutlet weak var boundaryView: UIView!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    
    private var realm: Realm!
    private var contentsList: Results<Number>!
    
    private var realmManager = RealmManager()
    private let themaColor = ThemaColorManager()
    private var editStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRealm()
        setThema()
        setFlowLayout()
        setEditing(editing: false)
        
    }
    
    func setRealm() {
        do {
            realm = try Realm()
        } catch {
            print("\(error)")
        }
        contentsList = realmManager.getNumbers(type: Number.self)
    }
    
    func setThema() {
        let hex = themaColor.hex
        self.statusBar.backgroundColor = UIColor(hex: hex)
        self.collectionView.backgroundColor = UIColor(hex: hex)
        self.boundaryView.backgroundColor = UIColor(hex: hex)
    }
    
    func setFlowLayout() {
        let width = (view.frame.size.width)
        let height = (view.frame.size.height) / 6
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    func setEditing(editing: Bool) {
        editButton.isEnabled = !editing
        editButton.isHidden = editing
        
        backButton.isEnabled = !editing
        backButton.isHidden = editing
        
        doneButton.isEnabled = editing
        doneButton.isHidden = !editing
        
        trashButton.isEnabled = editing
        trashButton.isHidden = !editing
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map{$0.item}.sorted().reversed()
            for item in items {
                realmManager.delete(objc: contentsList[item])
            }
            collectionView.deleteItems(at: selected)
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        editStatus = true
        setEditing(editing: editStatus)
        collectionView.allowsMultipleSelection = editStatus
        let indexes = collectionView.indexPathsForVisibleItems
        for index in indexes {
            let cell = collectionView.cellForItem(at: index) as! CollectionViewCell
            cell.isEditing = editStatus
        }
    }
     
    @IBAction func doneButton(_ sender: Any) {
        editStatus = false
        setEditing(editing: editStatus)
        collectionView.allowsMultipleSelection = editStatus
        let indexes = collectionView.indexPathsForVisibleItems
        for index in indexes {
            let cell = collectionView.cellForItem(at: index) as! CollectionViewCell
            cell.isEditing = editStatus
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.lottoLabel.text = contentsList[indexPath.row].lottoNum
        cell.isEditing = false
        return cell
    }
}
