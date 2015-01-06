//
//  ARUploadItemViewController.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/24/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit
import MobileCoreServices

class ARUploadItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let ImageCellIdentifier = "ImageCell"
    var imagePicker = UIImagePickerController()
    
    @IBOutlet var photoCollectionView: UICollectionView!
    var photos = [UIImage]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        let columnHeaderViewNIB = UINib(nibName:"ARUploadItemImageCellCollectionViewCell", bundle: nil)
        photoCollectionView.registerNib(columnHeaderViewNIB, forCellWithReuseIdentifier: ImageCellIdentifier)
        
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
        photoCollectionView.reloadData()
    }
    
    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!){
            
            let tempImage = info[UIImagePickerControllerOriginalImage] as UIImage
            photos.append(tempImage)
            
            picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPressAddImage(sender: AnyObject) {
        self.presentPhotoLibrary()
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
        return photos.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCellWithReuseIdentifier(ImageCellIdentifier, forIndexPath: indexPath) as ARUploadItemImageCellCollectionViewCell
        cell.setImage(photos[indexPath.row])
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(60, 60)
    }
}
