//
//  PhotoSearchMetadataViewModel.swift
//  BindingWithBond
//
//  Created by Colin Eberhardt on 10/12/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Foundation
import Bond

class PhotoSearchMetadataViewModel {
  let creativeCommons = Observable<Bool>(false)
  let dateFilter = Observable<Bool>(false)
  let minUploadDate = Observable<NSDate>(NSDate())
  let maxUploadDate = Observable<NSDate>(NSDate())
}