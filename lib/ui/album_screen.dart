import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../networking/bloc/get_data_bloc.dart';
import '../networking/models/album_response_model.dart';
import '../networking/models/photos_response_model.dart';
import '../networking/response.dart';
import '../utils/common_image_widget.dart';
import '../utils/constants.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late GetDataBloc getDataBloc;
  List<AlbumResponseModel>? albumData = [];
  List<PhotosResponseModel>? photosData = [];

  bool isNetworkConnected = true;


  @override
  void initState() {
    getDataBloc = GetDataBloc();

    ///init storage :)
    getStorage();

    ///check network then call api to get data.
   loadData();


    /// brand data response handler
    getDataBloc.albumDataStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:

          getDataBloc.getPhotos();

          setState(() {
            albumData = event.data;
          });

          ///to store data in local storage.
          storage!.write("album", albumResponseModelToJson(albumData!).toString());

          break;
        case Status.ERROR:
          break;
      }
    });

    getDataBloc.photosDataStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:

          setState(() {
            photosData = event.data;
          });

          ///to store data in local storage.
          storage!.write("photos", photosResponseModelToJson(photosData!).toString());
          break;
        case Status.ERROR:
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.refresh),
        onPressed: (){
          ///reload data
          loadData();
        },
      ),
      body: Visibility(
        visible: isNetworkConnected || albumData!.isNotEmpty,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: albumData!.isNotEmpty ? albumData!.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return getAlbumItem(data: albumData![index]);
          },
        ),
        replacement: const Center(
          child: Text("Please check your internet connection!"),
        ),
      ),
    );
  }

  Widget _horizontalList() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: photosData!.isNotEmpty ? photosData!.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return getImageItem(imageUrl: photosData![index].thumbnailUrl!);
        });
  }

  getAlbumItem({required AlbumResponseModel data}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///title text
        Padding(
          padding: EdgeInsets.all(2.w),
          child: Text(data.title!),
        ),

        SizedBox(
          height: 20.h,
          child: _horizontalList(),
        ),

        const Divider(
          color: Colors.black,
        )
      ],
    );
  }

  getImageItem({required String imageUrl}) {
    return showImage(imgUrl: imageUrl, width: 40.w, height: 40.h);
  }

  void loadData() {

    hasNetwork().then((value) {
      if(value){
        getDataBloc.getAlbums();
      }else{
        ///get data form local
        if(storage!.read("album")!=null && storage!.read("photos")!=null) {
          setState(() {
            albumData = albumResponseModelFromJson(json.decode(storage!.read("album")));
            photosData = photosResponseModelFromJson(json.decode(storage!.read("photos")));
          });
        }
      }
      setState(() {
        isNetworkConnected = value;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
