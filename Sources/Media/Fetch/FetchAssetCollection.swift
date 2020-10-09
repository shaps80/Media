import Photos
import SwiftUI

@propertyWrapper
public struct FetchAssetCollection<Result>: DynamicProperty where Result: PHAssetCollection {

    @ObservedObject
    internal private(set) var observer: ResultsObserver<Result>

    public var wrappedValue: MediaResults<Result> {
        get { MediaResults(observer.result) }
        set { observer.result = newValue.result }
    }

}

extension FetchAssetCollection {

    public init(result: PHFetchResult<Result>) {
        self.init(observer: ResultsObserver(result: result))
    }

    public init(_ options: PHFetchOptions? = nil) {
        let result = PHAssetCollection.fetchTopLevelUserCollections(with: options)
        self.init(observer: ResultsObserver(result: result as! PHFetchResult<Result>))
    }

    public init<Value>(filter: NSPredicate? = nil,
                       sort: [(KeyPath<PHAssetCollection, Value>, ascending: Bool)]) {
        let options = PHFetchOptions()
        options.sortDescriptors = sort.map { NSSortDescriptor(keyPath: $0.0, ascending: $0.ascending) }
        options.predicate = filter
        self.init(options)
    }

}

extension FetchAssetCollection {

    public init(album: PHAssetCollectionType,
                kind: PHAssetCollectionSubtype = .any,
                options: PHFetchOptions? = nil) {
        let result = PHAssetCollection.fetchAssetCollections(with: album, subtype: kind, options: options)
        self.init(observer: ResultsObserver(result: result as! PHFetchResult<Result>))
    }

    public init(album: PHAssetCollectionType,
                kind: PHAssetCollectionSubtype = .any,
                fetchLimit: Int = 0,
                filter: NSPredicate? = nil) {
        let options = PHFetchOptions()
        options.fetchLimit = fetchLimit
        options.predicate = filter
        self.init(album: album, kind: kind, options: options)
    }

    public init<Value>(album: PHAssetCollectionType,
                       kind: PHAssetCollectionSubtype = .any,
                       fetchLimit: Int = 0,
                       filter: NSPredicate? = nil,
                       sort: [(KeyPath<PHAssetCollection, Value>, ascending: Bool)]) {
        let options = PHFetchOptions()
        options.fetchLimit = fetchLimit
        options.sortDescriptors = sort.map { NSSortDescriptor(keyPath: $0.0, ascending: $0.ascending) }
        options.predicate = filter
        self.init(album: album, kind: kind, options: options)
    }

}
