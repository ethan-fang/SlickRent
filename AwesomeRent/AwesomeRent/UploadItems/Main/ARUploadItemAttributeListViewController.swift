//
//  ARUploadItemMainViewController.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 1/6/15.
//  Copyright (c) 2015 awesomerent. All rights reserved.
//

import UIKit

class ARUploadItemAttributeListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionView: UICollectionView!
    let ItemCellIdentifier = "ItemCell"
    
    var models:NSArray = []
    var cellSizes:NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSaveAndCloseButton()
        self.setupContinueButton()
        let cellViewNIB = UINib(nibName:"ARUploadItemAttributeListItemCell", bundle: nil)
        collectionView.registerNib(cellViewNIB, forCellWithReuseIdentifier: ItemCellIdentifier)
        models = [
            [
                ARUploadItemAttributeListItemCellModel(isChecked: false, title: "Photos", details: "Add photos"),
                ARUploadItemAttributeListItemCellModel(isChecked: false, title: "Title", details: "Your title"),
                ARUploadItemAttributeListItemCellModel(isChecked: false, title: "Category", details: "select"),
                ARUploadItemAttributeListItemCellModel(isChecked: false, title: "Details", details: nil)
            ],
            [
                ARUploadItemAttributeListItemCellModel(isChecked: false, title: "Format & Price", details: "Select"),
                ARUploadItemAttributeListItemCellModel(isChecked: false, title: "Postage", details: "Select"),
                ARUploadItemAttributeListItemCellModel(isChecked: false, title: "Preferences", details: "Select")
            ]
        ]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setupSizes()
    }
    
    func setupSizes() {
        let width = self.collectionView.frame.size.width;
        let cellSizes = NSMutableArray();
        let nib = UINib(nibName:"ARUploadItemAttributeListItemCell", bundle:nil);
        let cell = nib.instantiateWithOwner(nil, options: nil)[0] as ARUploadItemAttributeListItemCell
        
        cell.frame = CGRectMake(0, 0, width, 0);
        for section in models {
            let sectionModels = section as NSArray
            let sectionCellSizes = NSMutableArray()
            for model in sectionModels {
                cell.model = model as ARUploadItemAttributeListItemCellModel
                let height:CGFloat = cell.cellHeight();
                sectionCellSizes.addObject(NSValue(CGSize:CGSizeMake(width, height)))
            }
            cellSizes.addObject(sectionCellSizes)
        }
        self.cellSizes = cellSizes;
        
        self.collectionView.collectionViewLayout.invalidateLayout();
    }
        
    func setupSaveAndCloseButton() {
        let saveAndCloseButton = UIBarButtonItem(title: "Save&Close", style: .Plain, target: self, action: "onPressSaveAndCloseButton:")
        self.navigationItem.leftBarButtonItem = saveAndCloseButton
    }
    
    func setupContinueButton() {
        let continueButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "onPressContinueButton:")
        self.navigationItem.rightBarButtonItem = continueButton
    }
    
    func onPressSaveAndCloseButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onPressContinueButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return models.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            let uploadItemVC = ARUploadItemViewController(nibName: "ARUploadItemViewController", bundle: nil)
            self.navigationController?.pushViewController(uploadItemVC, animated: true)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (models[section] as NSArray).count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as ARUploadItemAttributeListItemCell
        cell.model = models[indexPath.section][indexPath.row] as ARUploadItemAttributeListItemCellModel
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var returnSize = CGSizeZero;
        if (indexPath.section < self.cellSizes.count && indexPath.row < self.cellSizes[indexPath.section].count) {
            returnSize = self.cellSizes[indexPath.section][indexPath.row].CGSizeValue()
        }
        return returnSize;
    }
}
