import 'dart:async';
import '../models/album_response_model.dart';
import '../models/photos_response_model.dart';
import '../repository/repositories.dart';
import '../response.dart';

class GetDataBloc {
  late GetAlbumRepository getAlbumRepository;

  ///albums
  late StreamController<Response<List<AlbumResponseModel>>> getAlbumBlocController;
  StreamSink<Response<List<AlbumResponseModel>>> get albumDataSink => getAlbumBlocController.sink;
  Stream<Response<List<AlbumResponseModel>>> get albumDataStream => getAlbumBlocController.stream;

  ///photos
  late StreamController<Response<List<PhotosResponseModel>>> getPhotosBlocController;
  StreamSink<Response<List<PhotosResponseModel>>> get photosDataSink => getPhotosBlocController.sink;
  Stream<Response<List<PhotosResponseModel>>> get photosDataStream => getPhotosBlocController.stream;

  GetDataBloc() {
    getAlbumRepository = GetAlbumRepository();
    getPhotosBlocController = StreamController<Response<List<PhotosResponseModel>>>();
    getAlbumBlocController = StreamController<Response<List<AlbumResponseModel>>>();
  }

  getAlbums() async {
    albumDataSink.add(Response.loading("getting albums list..."));
    try {
      List<AlbumResponseModel> brandsResponseModel = await getAlbumRepository.getAlbums();
      albumDataSink.add(Response.completed(brandsResponseModel));
    } catch (e) {
      albumDataSink.add(Response.error(e.toString()));
    }
    return null;
  }

  getPhotos() async {
    photosDataSink.add(Response.loading("getting photos list..."));
    try {
      List<PhotosResponseModel> responseModel = await getAlbumRepository.getPhotos();
      photosDataSink.add(Response.completed(responseModel));
    } catch (e) {
      photosDataSink.add(Response.error(e.toString()));
    }
    return null;
  }

  dispose() {
    getAlbumBlocController.close();
    getPhotosBlocController.close();
  }
}