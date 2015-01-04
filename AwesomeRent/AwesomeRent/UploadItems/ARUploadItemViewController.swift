//
//  ARUploadItemViewController.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/24/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit
import MobileCoreServices

class ARUploadItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    let ImageCellIdentifier = "ImageCell"
    
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
            
            println("Picker returned successfully")
            
            let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
            
            if let type:AnyObject = mediaType{
                
                if type is String{
                    let stringType = type as String
                    
                    if stringType == kUTTypeMovie as NSString{
                        let urlOfVideo = info[UIImagePickerControllerMediaURL] as? NSURL
                        if let url = urlOfVideo{
                            println("Video URL = \(url)")
                        }
                    }
                        
                    else if stringType == kUTTypeImage as NSString as NSString{
                        /* Let's get the metadata. This is only for images. Not videos */
                        let metadata = info[UIImagePickerControllerMediaMetadata]
                            as? NSDictionary
                        if let theMetaData = metadata{
                            let image = info[UIImagePickerControllerOriginalImage]
                                as? UIImage
                            if let theImage = image{
                                println("Image Metadata = \(theMetaData)")
                                println("Image = \(theImage)")
                                photos.append(theImage)
                            }
                        }
                    }
                    
                }
            }
            
            picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPressAddImage(sender: AnyObject) {
        self.presentCamera()
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
    
    
}
