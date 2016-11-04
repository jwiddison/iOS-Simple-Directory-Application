//
//  PhotoManager.swift
//  Founders Directory
//
//  Created by Steve Liddle on 11/3/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation

class PhotoManager {

    // MARK: - Singleton

    static let shared = PhotoManager()

    fileprivate init() { }

/*
    // Return the bitmap for a photo corresponding to a given filename.
    public Bitmap getPhoto(String filename) {
    File photoFile = fileForExistingPhotoUrl(filename);

    if (photoFile != null) {
    BitmapFactory.Options options = new BitmapFactory.Options();

    options.inPreferredConfig = Bitmap.Config.ARGB_8888;
    
    return BitmapFactory.decodeFile(photoFile.getAbsolutePath(), options);
    }
    
    return null;
    }
    
    // Get a photo for a given Founder record ID.
    public Bitmap getPhotoForFounderId(int id) {
    return getPhoto("founder" + id);
    }
    
    // Get a spouse photo for a given Founder record ID.
    public Bitmap getSpousePhotoForFounderId(int id) {
    return getPhoto("spouse" + id);
    }

    // Save a photo for a given Founder record ID.
    public void savePhotoForFounderId(int id, Bitmap photo) {
    savePhoto("founder" + id, photo);
    }
    
    // Save a spouse photo for a given Founder record ID.
    public void saveSpousePhotoForFounderId(int id, Bitmap photo) {
    savePhoto("spouse" + id, photo);
    }
    
    // Get the full URL string for a given image filename.
    public String urlForFileName(String imageFileName) {
    File photoFile = fileForExistingPhotoUrl(imageFileName);
    
    if (photoFile != null) {
    return photoFile.getAbsolutePath();
    }
    
    return null;
    }
    
    // Retrieve a File corresponding
    private File fileForExistingPhotoUrl(String url) {
    File[] cacheDirs = ContextCompat.getExternalCacheDirs(mContext);
    
    for (File dir : cacheDirs) {
    if (dir != null) {
    File photoFile = new File(dir.getAbsolutePath() + File.separator + url);
    
    if (photoFile.exists()) {
    return photoFile;
    }
    }
    }
    
    return null;
    }
    
    private File fileForNewPhotoUrl(String url) {
    File cacheDir = ContextCompat.getExternalCacheDirs(mContext)[0];
    
    return new File(cacheDir.getAbsolutePath() + File.separator + url);
    }
    
    private void savePhoto(String url, Bitmap photo) {
    File photoFile = fileForNewPhotoUrl(url);
    
    if (photoFile != null) {
    if (photoFile.exists()) {
    photoFile.delete();
    }
    
    Log.d(TAG, "savePhoto: " + url);
    BitmapWorkerTask.clearImageFromCache(url);
    
    FileOutputStream out = null;
    
    try {
    out = new FileOutputStream(photoFile);
    photo.compress(Bitmap.CompressFormat.PNG, 100, out);
    } catch (FileNotFoundException e) {
    Log.d(TAG, "savePhoto unable to save: " + e);
    } finally {
    try {
    if (out != null) {
    out.close();
    }
    } catch (IOException e) {
    Log.d(TAG, "savePhoto unable to close: " + e);
    }
    }
    }
    }
*/
}
