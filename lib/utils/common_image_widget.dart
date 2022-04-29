import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

showImage({
  String imgUrl = "",
  double width = 0,
  double height = 0,
}) {
  return Padding(
    padding: EdgeInsets.all(2.w),
    child: CachedNetworkImage(
      imageUrl: imgUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
          width: 8.w,
          height: 8.w,
          color: Colors.white,
          child: Center(
            child: SizedBox(
              width: 5.w,
              height: 5.w,
               child: const CircularProgressIndicator(color: Colors.black,),
            ),
          )),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/ic_product_thumb.png',
      ),
    ),
  );
}
