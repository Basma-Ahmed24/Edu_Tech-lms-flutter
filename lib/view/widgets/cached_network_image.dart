import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/constants/app_images.dart';

class MyCustomImage extends StatelessWidget {
  final String image;
  final String? defaultImage;
  final double? width;
  final double? height;
  final bool isNotCircle;
  final BoxFit? fit;

  const MyCustomImage({
    Key? key,
    required this.image,
    this.defaultImage,
    this.width,
    this.height,
    this.isNotCircle = false,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) => Container(
        width: width ?? 70.sp,
        height: height ?? 70.sp,
        decoration: BoxDecoration(
          shape: isNotCircle ? BoxShape.rectangle : BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(
              defaultImage ?? AppImages.placeholder,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: ((context, url) => Container(
            width: width ?? 70.sp,
            height: height ?? 70.sp,
            decoration: BoxDecoration(
              shape: isNotCircle ? BoxShape.rectangle : BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  defaultImage ?? AppImages.placeholder,
                ),
                fit: BoxFit.cover,
              ),
            ),
          )),
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width ?? 70.sp,
          height: height ?? 70.sp,
          decoration: BoxDecoration(
            shape: isNotCircle ? BoxShape.rectangle : BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
