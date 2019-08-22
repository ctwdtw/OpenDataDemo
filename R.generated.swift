//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `imagePlaceHolder`.
    static let imagePlaceHolder = Rswift.ImageResource(bundle: R.hostingBundle, name: "imagePlaceHolder")
    
    /// `UIImage(named: "imagePlaceHolder", bundle: ..., traitCollection: ...)`
    static func imagePlaceHolder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.imagePlaceHolder, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    /// Nib `AccountHeaderView`.
    static let accountHeaderView = _R.nib._AccountHeaderView()
    /// Nib `PlantCell`.
    static let plantCell = _R.nib._PlantCell()
    /// Nib `StrechyVC`.
    static let strechyVC = _R.nib._StrechyVC()
    
    /// `UINib(name: "AccountHeaderView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.accountHeaderView) instead")
    static func accountHeaderView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.accountHeaderView)
    }
    
    /// `UINib(name: "PlantCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.plantCell) instead")
    static func plantCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.plantCell)
    }
    
    /// `UINib(name: "StrechyVC", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.strechyVC) instead")
    static func strechyVC(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.strechyVC)
    }
    
    static func accountHeaderView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> AccountHeaderView? {
      return R.nib.accountHeaderView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? AccountHeaderView
    }
    
    static func plantCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> OpenDataDemo.PlantCell? {
      return R.nib.plantCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? OpenDataDemo.PlantCell
    }
    
    static func strechyVC(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.strechyVC.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `PlantCell`.
    static let plantCell: Rswift.ReuseIdentifier<OpenDataDemo.PlantCell> = Rswift.ReuseIdentifier(identifier: "PlantCell")
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.apI` struct is generated, and contains static references to 4 localization keys.
    struct apI {
      /// Value: 伺服器回傳資料為空
      static let noData = Rswift.StringResource(key: "noData", tableName: "API", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 伺服器回傳非預期的 JSON 資料
      static let unexpectedJSON = Rswift.StringResource(key: "unexpectedJSON", tableName: "API", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 伺服器無回應
      static let noResponse = Rswift.StringResource(key: "noResponse", tableName: "API", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 發生未預期的錯誤
      static let unexpectedError = Rswift.StringResource(key: "unexpectedError", tableName: "API", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: 伺服器回傳資料為空
      static func noData(_: Void = ()) -> String {
        return NSLocalizedString("noData", tableName: "API", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: 伺服器回傳非預期的 JSON 資料
      static func unexpectedJSON(_: Void = ()) -> String {
        return NSLocalizedString("unexpectedJSON", tableName: "API", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: 伺服器無回應
      static func noResponse(_: Void = ()) -> String {
        return NSLocalizedString("noResponse", tableName: "API", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: 發生未預期的錯誤
      static func unexpectedError(_: Void = ()) -> String {
        return NSLocalizedString("unexpectedError", tableName: "API", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _AccountHeaderView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "AccountHeaderView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> AccountHeaderView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? AccountHeaderView
      }
      
      fileprivate init() {}
    }
    
    struct _PlantCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = OpenDataDemo.PlantCell
      
      let bundle = R.hostingBundle
      let identifier = "PlantCell"
      let name = "PlantCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> OpenDataDemo.PlantCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? OpenDataDemo.PlantCell
      }
      
      fileprivate init() {}
    }
    
    struct _StrechyVC: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "StrechyVC"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UITabBarController
      
      let bundle = R.hostingBundle
      let name = "Main"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}