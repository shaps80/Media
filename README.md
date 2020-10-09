# Media

> WIP: This library is __not__ yet completed, as such no specific versioning will be included until documentation and such have been included.
>
> That said, you're free to try the library as its quite functional and a v1.0.0 will be released soon. 

A SwiftUI dynamic property wrapper for fetching media from your photo library.

> The wrapper is designed similarly to `FetchRequest` to provide a more discoverable and familiar API.

## Example

Fetch all asset collections of a given type and subtype:

```swift
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

## Installation

The library is provided as an open-source Swift package. So simply add the dependency to your package list:

`https://github.com/shaps80/Media.git`
