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
  
  init() {
    maxUploadDate.observe {
      [unowned self]
      maxDate in
      if maxDate.timeIntervalSinceDate(self.minUploadDate.value) < 0 {
        self.minUploadDate.value = maxDate
      }
    }
    minUploadDate.observe {
      [unowned self]
      minDate in
      if minDate.timeIntervalSinceDate(self.maxUploadDate.value) > 0 {
        self.maxUploadDate.value = minDate
      }
    }
  }
}