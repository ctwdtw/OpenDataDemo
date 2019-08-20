//
//  uploadRequestable.swift
//  janitorapp
//
//  Created by Paul Lee on 2019/3/18.
//  Copyright © 2019 Paul Lee. All rights reserved.
//
/**
 有上傳檔案的 request 所必要遵循的 protocol
 
*/
import Foundation

/// 有上傳檔案的 request 所必要遵循的 protocol
public protocol UploadRequestable {
  /// encode 之後的 Data
  var uploadData: Data { get }
  
  /// encode uploadData 所需要的 boundary 字串
  var boundary: String { get }
}
