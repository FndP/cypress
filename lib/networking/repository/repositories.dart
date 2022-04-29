import '../../utils/constants.dart';
import '../apiprovider.dart';
import '../models/album_response_model.dart';
import '../models/photos_response_model.dart';

class GetAlbumRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<AlbumResponseModel>> getAlbums() async {
    final response = await _apiProvider.get(getAlbumsUrl);
    return albumResponseModelFromJson(response);
  }

  Future<List<PhotosResponseModel>> getPhotos() async {
    final response = await _apiProvider.get(getPhotosUrl);
    return photosResponseModelFromJson(response);
  }
}
