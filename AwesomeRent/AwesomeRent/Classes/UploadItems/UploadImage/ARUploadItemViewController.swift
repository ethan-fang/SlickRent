//
//  ARUploadItemViewController.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/24/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit
import MobileCoreServices

struct ARUploadItemImageCollectionViewConstants {
    static let kMaxPhoto:Int = 12
    static let kColumn:CGFloat = 4
    static let kCellSpacing:CGFloat = 5
}

class ARUploadItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RAReorderableLayoutDelegate, RAReorderableLayoutDataSource {
    let ImageCellIdentifier = "ImageCell"
    var imagePicker = UIImagePickerController()
    lazy var photoSourceActionSheetController:UIAlertController = self.initphotoSourceActionSheetController()
    var cellWidth:CGFloat = 50
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var photoCollectionView: UICollectionView!
    var photos = [UIImage]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.setupUploadButton()
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        let columnHeaderViewNIB = UINib(nibName:"ARUploadItemImageCellCollectionViewCell", bundle: nil)
        photoCollectionView.registerNib(columnHeaderViewNIB, forCellWithReuseIdentifier: ImageCellIdentifier)
        photoCollectionView.hidden = true
        
        descriptionLabel.text = "Tap & Hold to reorder photos"
        
        if ARCameraUtils.doesCameraSupportTakingPhotos(){
            println("The camera supports taking photos")
        } else {
            println("The camera does not support taking photos")
        }
        
        if ARCameraUtils.doesCameraSupportShootingVideos(){
            println("The camera supports shooting videos")
        } else {
            println("The camera does not support shooting videos")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        cellWidth = (photoCollectionView.frame.size.width - (ARUploadItemImageCollectionViewConstants.kColumn + 1) * ARUploadItemImageCollectionViewConstants.kCellSpacing) / ARUploadItemImageCollectionViewConstants.kColumn
        photoCollectionView.collectionViewLayout.invalidateLayout()
        collectionViewHeightConstraint.constant = photoCollectionView.collectionViewLayout.collectionViewContentSize().height
        photoCollectionView.hidden = false
        self.view.layoutIfNeeded()
        
        println("collection view height:\(photoCollectionView.collectionViewLayout.collectionViewContentSize().height)")
        println("collection view width:\(photoCollectionView.collectionViewLayout.collectionViewContentSize().width)")
        let supposeWidth = ARUploadItemImageCollectionViewConstants.kColumn * (cellWidth + ARUploadItemImageCollectionViewConstants.kCellSpacing) + ARUploadItemImageCollectionViewConstants.kCellSpacing
        println("content view supposed with:\(supposeWidth)")
        println("cell width:\(cellWidth)")
    }
    
    func setupUploadButton() {
        let uploadButton = UIBarButtonItem(title: "upload", style: .Plain, target: self, action: "onPressUploadButton:")
        self.navigationItem.rightBarButtonItem = uploadButton
    }

    func onPressUploadButton(sender: UIBarButtonItem) {
        if (self.photos.count > 0) {
            let image = compressImage(self.photos[0] as UIImage)
            ARUploadImageService.uploadImage(image)
        }
    }
    
    func compressImage(image:UIImage) -> UIImage {
        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.1, 0.1))
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!){
            
            let tempImage = info[UIImagePickerControllerOriginalImage] as UIImage
            photos.append(tempImage)
            self.photoCollectionView.reloadData()
            picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPressDoneButton(sender: AnyObject) {
        if (photos.count == 0) {
            return
        }
        let image:UIImage = photos[0]
        ARUploadImageService.uploadImage(image)
    }
    
    func presentPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            println("Button capture")
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func presentCamera() {
        if ARCameraUtils.isCameraAvailable() && ARCameraUtils.doesCameraSupportTakingPhotos(){
            
            let controller = UIImagePickerController()
            
            let theController = controller
            theController.sourceType = .Camera
            
            theController.mediaTypes = [kUTTypeImage as NSString]
            
            theController.allowsEditing = true
            theController.delegate = self
            
            presentViewController(theController, animated: true, completion: nil)
            
            
        } else {
            println("Camera is not available")
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ARUploadItemImageCollectionViewConstants.kMaxPhoto
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCellWithReuseIdentifier(ImageCellIdentifier, forIndexPath: indexPath) as ARUploadItemImageCellCollectionViewCell
        
        let photo:UIImage? = photos.count > indexPath.row ? photos[indexPath.row] : nil
        let model = ARUploadItemImageCellModel(isCamera: indexPath.row == photos.count, photo: photo)
        cell.model = model
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: ARUploadItemImageCollectionViewConstants.kCellSpacing,
                left: ARUploadItemImageCollectionViewConstants.kCellSpacing,
                bottom: ARUploadItemImageCollectionViewConstants.kCellSpacing,
                right: ARUploadItemImageCollectionViewConstants.kCellSpacing)
            
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(cellWidth, cellWidth)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let isCameraCell = indexPath.row == photos.count
        if (isCameraCell) {
            self.presentViewController(self.photoSourceActionSheetController, animated: true, completion: nil)
        } else {
            
        }
    }
    
    func initphotoSourceActionSheetController() -> UIAlertController {
        var controller = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .ActionSheet)
        
        let actionCamera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
            self.presentCamera()
        })
        
        let actionLibrary = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
            self.presentPhotoLibrary()
        })
        
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (cancelSelected) -> Void in
            println("Cancel")
        }
        
        controller.addAction(actionCamera)
        controller.addAction(actionLibrary)
        controller.addAction(actionCancel)
        return controller
    }
    
    // RAReorderableLayout delegate datasource
    
    func collectionView(collectionView: UICollectionView, allowMoveAtIndexPath indexPath: NSIndexPath) -> Bool {
        return (self.photos.count > 1) && (self.photos.count > indexPath.item);
    }
    
    func collectionView(collectionView: UICollectionView, atIndexPath: NSIndexPath, canMoveToIndexPath toIndexPath: NSIndexPath) -> Bool {
        let canMove = self.photos.count > toIndexPath.item
        return canMove
    }
    
    func collectionView(collectionView: UICollectionView, atIndexPath: NSIndexPath, didMoveToIndexPath toIndexPath: NSIndexPath) {
        var photo: UIImage = self.photos.removeAtIndex(atIndexPath.item);
        
        if toIndexPath.item >= self.photos.count {
            self.photos.insert(photo, atIndex: self.photos.count)
        } else {
            self.photos.insert(photo, atIndex: toIndexPath.item)
        }
    }
    
    
    
    func scrollTrigerEdgeInsetsInCollectionView(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(100.0, 100.0, 100.0, 100.0)
    }
    
    func collectionView(collectionView: UICollectionView, reorderingItemAlphaInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else {
            return 0.3
        }
    }
    
    func scrollTrigerPaddingInCollectionView(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(self.photoCollectionView.contentInset.top, 0, self.photoCollectionView.contentInset.bottom, 0)
    }
    
}
