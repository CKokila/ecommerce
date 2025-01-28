import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/const/string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget cacheProfileImage(url, {BoxFit? fit, double? width, double? height}) {
  if (url != null && url != '' && url.contains("http") && !url.contains(".None")) {
    if (!kIsWeb) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: url,
            fit: fit ?? BoxFit.cover,
            placeholder: (ctx, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: const Card(),
                ),
            errorWidget: (ctx, url, error) => Image.asset(
                  Images.emptyProfile,
                  width: width,
                  height: height,
                  fit: BoxFit.contain,
                )),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image.network(url,
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,
            loadingBuilder:
                (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) =>
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const Card(),
                    ),
            errorBuilder: (ctx, url, error) => Image.asset(
                  Images.emptyProfile,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                )),
      );
    }
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.asset(
        Images.emptyProfile,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

Widget cacheImage(url,
    {text,
    double? width,
    double? height,
    BoxFit? fit,
    double? borderRadius,
    Alignment? alignment,
    String? emptyImage}) {
  try {
    if (url != null && url != '' && url.contains("http") && !url.contains(".None")) {
      if (!kIsWeb) {
        return ClipRRect(
          borderRadius:
              borderRadius != null ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CachedNetworkImage(
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            alignment: alignment ?? Alignment.center,
            imageUrl: url ?? '',
            placeholder: (ctx, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300] ?? Colors.grey,
              highlightColor: Colors.grey[100] ?? Colors.white,
              child: const Card(),
            ),
            errorWidget: (ctx, url, error) {
              return (text != null && text != '')
                  ? Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    )
                  : const Icon(Icons.broken_image_outlined, color: Colors.black12);
            },
          ),
        );
      } else {
        return ClipRRect(
          borderRadius:
              borderRadius != null ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            url,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            alignment: alignment ?? Alignment.center,
            loadingBuilder: (ctx, child, s) => child,
            errorBuilder: (ctx, url, error) {
              return (text != null && text != '')
                  ? Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    )
                  : SizedBox(
                      width: width,
                      height: height,
                      child: const Center(
                          child: Icon(Icons.broken_image_outlined, color: Colors.black12)));
            },
          ),
        );
      }
    } else {
      return ClipRRect(
        borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image.asset(
          emptyImage ?? Images.notFound,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
        ),
      );
    }
  } catch (e) {
    return ClipRRect(
      borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        emptyImage ?? Images.notFound,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}

Alignment fractionAlign =
    FractionalOffset.fromOffsetAndRect(const Offset(0, 10), const Rect.fromLTWH(10, 10, 10, 10));

Future<Uint8List> getCanvasImage(String str) async {
  var builder = ParagraphBuilder(ParagraphStyle(fontStyle: FontStyle.normal));
  builder.addText(str);
  Paragraph paragraph = builder.build();
  paragraph.layout(const ParagraphConstraints(width: 100));

  final recorder = PictureRecorder();
  var newCanvas = Canvas(recorder);

  newCanvas.drawParagraph(paragraph, Offset.zero);

  final picture = recorder.endRecording();
  var res = await picture.toImage(100, 100);
  ByteData? data = await res.toByteData(format: ImageByteFormat.png);

  // if (data != null) {
  //   img = Image.memory(Uint8List.view(data.buffer));
  // }
  return Uint8List.view(data!.buffer);
}
