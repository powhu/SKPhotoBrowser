//
//  ViewController.swift
//  SKPhotoBrowserExample
//
//  Created by suzuki_keishi on 2015/10/06.
//  Copyright © 2015 suzuki_keishi. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SKPhotoBrowserDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var browser : SKPhotoBrowser?
    var images = [SKPhoto]()
    var caption = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
                   "It has survived not only five centuries, but also the leap into electronic typesetting",
                   "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                   "It has survived not only five centuries, but also the leap into electronic typesetting",
                   "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                   "It has survived not only five centuries, but also the leap into electronic typesetting",
                   "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<5 {
            let photo = SKPhoto.photoWithImage(UIImage(named: "image\(i%10).jpg")!)
            photo.caption = caption[i%10]
            images.append(photo)
        }
        
        setupTableView()
    }
    
    private func setupTableView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("exampleCollectionViewCell", forIndexPath: indexPath) as? ExampleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.exampleImageView.image = images[indexPath.row].underlyingImage
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? ExampleCollectionViewCell else {
            return
        }
        guard let originImage = cell.exampleImageView.image else {
            return
        }
        browser = SKPhotoBrowser(originImage: originImage, photos: images, animatedFromView: cell)
        browser!.initializePageIndex(indexPath.row)
        browser!.delegate = self
        
        // Can hide the action button by setting to false
        browser!.displayAction = true
        
        // Optional action button titles (if left off, it uses activity controller
        // browser.actionButtonTitles = ["Do One Action", "Do Another Action"]
        
        presentViewController(browser!, animated: true, completion: {})
        
        performSelector("appendPhoto", withObject: nil, afterDelay: 1)
        
    }
    
    func appendPhoto() {
        var photos = [SKPhoto]()
        for i in 0..<5 {
            let photo = SKPhoto.photoWithImage(UIImage(named: "image\(i%10).jpg")!)
            photo.caption = caption[i%10]
            photos.append(photo)
        }
        images.appendContentsOf(photos)
        collectionView.reloadData()
        browser!.appendPhotos(photos)
    }
    
    // MARK: - SKPhotoBrowserDelegate
    func didShowPhotoAtIndex(index: Int) {
        // do some handle if you need
    }
    
    func willDismissAtPageIndex(index: Int) {
        // do some handle if you need
    }
   
    func willShowActionSheet(photoIndex: Int) {
        // do some handle if you need
    }
    
    func didDismissAtPageIndex(index: Int) {
        // do some handle if you need
    }
    
    func didDismissActionSheetWithButtonIndex(buttonIndex: Int, photoIndex: Int) {
        // handle dismissing custom actions
    }
    
}


class ExampleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exampleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exampleImageView.image = nil
    }
    
    override func prepareForReuse() {
        exampleImageView.image = nil
    }
}

