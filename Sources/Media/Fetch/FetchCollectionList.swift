import Photos
import SwiftUI

@propertyWrapper
public struct FetchCollectionList<Result>: DynamicProperty where Result: PHCollectionList {

    @ObservedObject
    internal private(set) var observer: ResultsObserver<Result>

    public var wrappedValue: MediaResults<Result> {
        get { MediaResults(observer.result) }
        set { observer.result = newValue.result }
    }

}

extension FetchCollectionList {

    public init(_ options: PHFetchOptions?) {
        let result = PHCollectionList.fetchTopLevelUserCollections(with: options)
        self.init(observer: ResultsObserver(result: result as! PHFetchResult<Result>))
    }

    public init(filter: NSPredicate? = nil) {
        let options = PHFetchOptions()
        options.predicate = filter
        self.init(options)
    }

    public init<Value>(fetchLimit: Int = 0,
                       filter: NSPredicate? = nil,
                       sort: [(KeyPath<PHCollectionList, Value>, ascending: Bool)]) {
        let options = PHFetchOptions()
        options.fetchLimit = fetchLimit
        options.sortDescriptors = sort.map { NSSortDescriptor(keyPath: $0.0, ascending: $0.ascending) }
        options.predicate = filter
        self.init(options)
    }

}

extension FetchCollectionList {

    public init(list: PHCollectionListType,
                kind: PHCollectionListSubtype = .any,
                options: PHFetchOptions? = nil) {
        let result = PHCollectionList.fetchCollectionLists(with: list, subtype: kind, options: options)
        self.init(observer: ResultsObserver(result: result as! PHFetchResult<Result>))
    }

    public init(list: PHCollectionListType,
                kind: PHCollectionListSubtype = .any,
                fetchLimit: Int = 0,
                filter: NSPredicate) {
        let options = PHFetchOptions()
        options.fetchLimit = fetchLimit
        options.predicate = filter
        self.init(list: list, kind: kind, options: options)
    }

    public init<Value>(list: PHCollectionListType,
                       kind: PHCollectionListSubtype = .any,
                       fetchLimit: Int = 0,
                       filter: NSPredicate? = nil,
                       sort: [(KeyPath<PHCollectionList, Value>, ascending: Bool)]) {
        let options = PHFetchOptions()
        options.fetchLimit = fetchLimit
        options.sortDescriptors = sort.map { NSSortDescriptor(keyPath: $0.0, ascending: $0.ascending) }
        options.predicate = filter
        self.init(list: list, kind: kind, options: options)
    }

}
