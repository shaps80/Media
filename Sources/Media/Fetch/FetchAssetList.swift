import Photos
import SwiftUI

@propertyWrapper
public struct FetchAssetList<Result>: DynamicProperty where Result: PHAsset {

    @ObservedObject
    internal private(set) var observer: ResultsObserver<Result>

    public var wrappedValue: MediaResults<Result> {
        get { MediaResults(observer.result) }
        set { observer.result = newValue.result }
    }

}

extension FetchAssetList {

    public init(_ result: PHFetchResult<PHAsset>) {
        observer = ResultsObserver(result: result as! PHFetchResult<Result>)
    }

    public init(_ options: PHFetchOptions? = nil) {
        let result = PHAsset.fetchAssets(with: options)
        observer = ResultsObserver(result: result as! PHFetchResult<Result>)
    }

    public init<Value>(sort: [(KeyPath<PHAsset, Value>, ascending: Bool)],
                       filter: NSPredicate? = nil,
                       sourceTypes: PHAssetSourceType = [.typeCloudShared, .typeUserLibrary, .typeiTunesSynced],
                       includeAllBurstAssets: Bool = false,
                       includeHiddenAssets: Bool = false) {
        let options = PHFetchOptions()
        options.sortDescriptors = sort.map { NSSortDescriptor(keyPath: $0.0, ascending: $0.ascending) }
        options.predicate = filter
        options.includeAssetSourceTypes = sourceTypes
        options.includeHiddenAssets = includeHiddenAssets
        options.includeAllBurstAssets = includeAllBurstAssets
        self.init(options)
    }

}

extension FetchAssetList {

    public init(in collection: PHAssetCollection,
                options: PHFetchOptions? = nil) {
        let result = PHAsset.fetchAssets(in: collection, options: options)
        self.init(observer: ResultsObserver(result: result as! PHFetchResult<Result>))
    }

    public init(in collection: PHAssetCollection,
                fetchLimit: Int = 0,
                filter: NSPredicate? = nil,
                sourceTypes: PHAssetSourceType = [.typeCloudShared, .typeUserLibrary, .typeiTunesSynced],
                includeAllBurstAssets: Bool = false,
                includeHiddenAssets: Bool = false) {
        let options = PHFetchOptions()
        options.fetchLimit = fetchLimit
        options.predicate = filter
        options.includeAssetSourceTypes = sourceTypes
        options.includeHiddenAssets = includeHiddenAssets
        options.includeAllBurstAssets = includeAllBurstAssets
        self.init(in: collection, options: options)
    }

    public init<Value>(in collection: PHAssetCollection,
                       fetchLimit: Int = 0,
                       filter: NSPredicate? = nil,
                       sort: [(KeyPath<PHAsset, Value>, ascending: Bool)],
                       sourceTypes: PHAssetSourceType = [.typeCloudShared, .typeUserLibrary, .typeiTunesSynced],
                       includeAllBurstAssets: Bool = false,
                       includeHiddenAssets: Bool = false) {
        let options = PHFetchOptions()
        options.fetchLimit = fetchLimit
        options.sortDescriptors = sort.map { NSSortDescriptor(keyPath: $0.0, ascending: $0.ascending) }
        options.predicate = filter
        options.includeAssetSourceTypes = sourceTypes
        options.includeHiddenAssets = includeHiddenAssets
        options.includeAllBurstAssets = includeAllBurstAssets
        self.init(in: collection, options: options)
    }

}
