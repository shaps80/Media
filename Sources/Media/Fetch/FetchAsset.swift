import UIKit
import Photos
import SwiftUI

@propertyWrapper
public struct FetchAsset: DynamicProperty {

    @ObservedObject
    internal private(set) var observer: AssetObserver

    public var wrappedValue: MediaAsset {
        MediaAsset(asset: observer.asset)
    }

}

extension FetchAsset {

    public init(_ asset: PHAsset) {
        let observer = AssetObserver(asset: asset)
        self.init(observer: observer)
    }

}

public struct MediaAsset {

    public private(set) var asset: PHAsset?

    public init(asset: PHAsset?) {
        self.asset = asset
    }

}

internal final class AssetObserver: NSObject, ObservableObject, PHPhotoLibraryChangeObserver {

    @Published
    internal var asset: PHAsset?

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }

    init(asset: PHAsset) {
        self.asset = asset
        super.init()
        PHPhotoLibrary.shared().register(self)
    }

    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let asset = asset else { return }
        self.asset = changeInstance.changeDetails(for: asset)?.objectAfterChanges
    }

}
