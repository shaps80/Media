import XCTest
@testable import Media

final class MediaTests: XCTestCase {

    func testExample() {
        XCTAssertTrue(true)
    }

}

import SwiftUI

struct AlbumsView: View {

    @FetchAssetCollection(album: .album, kind: .albumRegular)
    private var albums

    var body: some View {
        List(albums) { album in
            Text(album.localizedTitle ?? "")
        }
    }

}
