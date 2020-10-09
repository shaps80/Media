![ios](https://img.shields.io/badge/iOS-13-green)
![tv](https://img.shields.io/badge/tvOS-13-green)
![watch](https://img.shields.io/badge/watchOS-6-green)
![mac](https://img.shields.io/badge/macOS-10.15-green)

# Media

> WIP: This library is __not__ yet completed, as such no specific versioning will be included until documentation and such have been included.
>
> That said, you're free to try the library as its quite functional and a v1.0.0 will be released soon. 

A SwiftUI dynamic property wrapper for fetching media from your photo library.

> The wrapper is designed similarly to `FetchRequest` to provide a more discoverable and familiar API.

## Example

Fetch all asset collections of a given type and subtype:

```swift
import Media

struct AlbumsView: View {

    @FetchAssetCollection(album: .album, kind: .albumRegular)
    private var albums

    var body: some View {
        List(albums) { album in
            Text(album.localizedTitle ?? "")
        }
    }

}
```

> Note: Its not necessary to `import Photos` as the framework does this for you.

## Usage

The property wrapper has heavily inspired by the new `FetchRequest` provided by SwiftUI. As such, it conforms to `RandomAccessCollection` allowing it to be used in all the same places, e.g. `List`, `ForEach`, etc...

This greatly simplifies the use of the photos framework library when integrating into a SwiftUI package.

Since the library is also a `dynamic` property, updates occuring in the users library are automatically tracked and reflecting in your SwiftUI views.

## Custom Queries

The property wrapper initializers provide various overrides to ensure you can customize the queries you need to perform. 

In cases where a convenience initializer hasn't been provided, you can simply pass your own `PHFetchOptions` instance:

```swift
private static var options: PHFetchOptions = {
    let options = PHFetchOptions()
    options.predicate = ...
    return options
}()

@FetchAssetCollection(options)
private var custom
```

## Supports API

`PHAssetCollection`

```swift
@FetchAssetCollection(
    album: .smartAlbum,
    filter: NSPredicate(format: "NOT (assetCollectionSubtype IN %@)",
                        [PHAssetCollectionSubtype.smartAlbumUserLibrary.rawValue,
                         PHAssetCollectionSubtype.smartAlbumAllHidden.rawValue,
                         PHAssetCollectionSubtype.smartAlbumFavorites.rawValue,
                        ])
) private var albums
```

`PHCollectionList`

```swift
@FetchCollectionList(
    list: .smartFolder,
    kind: .any
) private var folders
```

`PHAsset`

```swift
// You can instantiate your results during init: 
@FetchAssetList 
private var assets: MediaResults<PHAsset>

// Or, if you already have a set of results from a `PHFetchResult<PHAsset>` instance:
@FetchAssetList(results)
private var assets

// Alternatively, if you have a `PHAssetCollection` instance:
@FetchAssetList(in: collection)
private var assets
```

There are multiple overrides for all of the above to allow for most customizations, alternatively you can pass a `PHFetchOptions` instance yourself as mentioned above.

## Exclusions

The primary purpose of this library is to simplfiy the usage of the `Photos` framework in SwiftUI applications. As such, permission requests and mutations are being intentionally excluded.

Those APIs are not an issue that needs fixing by this library. 

Instead you should continue to use the existing APIs available via the `Photos` framework. Since the use of `Photos` types is required, the library automatically imports `Photos` for you so adding an additional import is redundant.

## Installation

The library is provided as an open-source Swift package. So simply add the dependency to your package list:

`https://github.com/shaps80/Media.git`
