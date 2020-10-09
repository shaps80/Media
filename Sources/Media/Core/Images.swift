import Photos

public extension PHAssetCollectionSubtype {

    var systemImageName: String {
        switch self {
        case .albumCloudShared: return "rectangle.stack.badge.person.crop"
        case .albumImported: return "square.and.arrow.down"
        case .albumMyPhotoStream: return "heart.text.square"
        case .albumSyncedAlbum: return "rectangle.stack.badge.person.crop"
        case .albumSyncedEvent: return "mappin.and.ellipse"
        case .albumSyncedFaces: return "person.crop.circle"
        case .smartAlbumAllHidden: return "eye.slash"
        case .smartAlbumAnimated: return "square.stack.3d.forward.dottedline"
        case .smartAlbumBursts: return "square.stack.3d.down.right"
        case .smartAlbumDepthEffect, .smartAlbumSelfPortraits: return "cube"
        case .smartAlbumFavorites: return "heart"
        case .smartAlbumLivePhotos: return "livephoto"
        case .smartAlbumLongExposures: return "plusminus.circle"
        case .smartAlbumPanoramas: return "pano"
        case .smartAlbumRecentlyAdded: return "clock"
        case .smartAlbumScreenshots: return "camera.viewfinder"
        case .smartAlbumSlomoVideos: return "slowmo"
        case .smartAlbumTimelapses: return "timelapse"
        case .smartAlbumUnableToUpload: return "icloud.and.arrow.up"
        case .smartAlbumUserLibrary: return "photo.on.rectangle"
        case .smartAlbumVideos: return "video"
        default: return "rectangle.stack"
        }
    }

}

public extension PHCollectionListSubtype {

    var systemImageName: String {
        switch self {
        case .smartFolderEvents: return "mappin.and.ellipse"
        case .smartFolderFaces: return "person.crop.circle"
        default: return "folder"
        }
    }

}
