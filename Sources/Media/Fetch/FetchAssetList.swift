import Photos
import SwiftUI

/// Fetches a set of assets from the `Photos` framework
@propertyWrapper
public struct FetchAssetList<Result>: DynamicProperty where Result: PHAsset {

    @ObservedObject
    internal private(set) var observer: ResultsObserver<Result>

    /// Represents the results of the fetch
    public var wrappedValue: MediaResults<Result> {
        get { MediaResults(observer.result) }
        set { observer.result = newValue.result }
    }

}

extension FetchAssetList {

    /// Instantiates a fetch with an existing `PHFetchResult<Result>` instance
    public init(_ result: PHFetchResult<PHAsset>) {
        observer = ResultsObserver(result: result as! PHFetchResult<Result>)
    }

    /// Instantiates a fetch with a custom `PHFetchOptions` instance
    public init(_ options: PHFetchOptions? = nil) {
        let result = PHAsset.fetchAssets(with: options)
        observer = ResultsObserver(result: result as! PHFetchResult<Result>)
    }

    /// Instantiates a fetch by applying the specified sort and filter options
    /// - Parameters:
    ///   - sort: <#sort description#>
    ///   - filter: <#filter description#>
    ///   - sourceTypes: <#sourceTypes description#>
    ///   - includeAllBurstAssets: <#includeAllBurstAssets description#>
    ///   - includeHiddenAssets: <#includeHiddenAssets description#>
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
