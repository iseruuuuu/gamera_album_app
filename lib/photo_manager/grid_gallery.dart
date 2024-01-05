import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera_album_app/photo_manager/photo_detail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:photo_manager/photo_manager.dart';

import 'dart:io' as io;
import 'package:flutter/src/widgets/image.dart' as ui;

class GridGallery extends StatefulWidget {
  final ScrollController? scrollCtr;

  const GridGallery({
    Key? key,
    this.scrollCtr,
  }) : super(key: key);

  @override
  _GridGalleryState createState() => _GridGalleryState();
}

class _GridGalleryState extends State<GridGallery> {
  final List<Widget> mediaList = [];
  final List<Uint8List> imagePath = [];
  final List<String> image = [];
  final List<List<AssetPathEntity>> imageList = [];
  int currentPage = 0;
  int? lastPage;

  @override
  void initState() {
    _fetchNewMedia();
    super.initState();
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(size: 60, page: currentPage);
      List<Widget> temp = [];
      DateTime today = DateTime.now();
      DateTime yesterday = today.add(const Duration(days: -1));
      for (var asset in media) {
        // if (asset.createDateTime.difference(yesterday).inHours >= 0 &&
        //     asset.longitude != 0 &&
        //     asset.latitude != 0) {
          // print(media.length);
          // imageList.add(media[]);

          // imageList.add(media);

          imageList.add(albums);

          // print(media.length);

          temp.add(
            FutureBuilder(
              future: asset.thumbnailDataWithSize(
                const ThumbnailSize(200, 200),
              ),
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GestureDetector(
                    onTap: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PhotoDetail(
                      //       image: snapshot.data!,
                      //     ),
                      //   ),
                      // );

                      // print(io.File.fromRawPath(snapshot.data!));

                      // var result = io.File.fromRawPath(snapshot.data!);
                      // print(result);

                      // var result = createFileFromBytes(snapshot.data!);
                      // print(snapshot.data!);

                      // var result = String.fromCharCodes(snapshot.data!);
                      // print(result); //ÿØÿà

                      var result = String.fromCharCodes(snapshot.data!);

                      print(result);

                      // var result = utf8.decode(snapshot.data!);
                      // print(result);

                      // var result2 = utf8.decode(snapshot.data!); error : FormatException: Invalid UTF-8 byte (at offset 0
                      // print(result2);

                      // var result2 = utf8.decode(result);
                      // var list = utf8.encode(result);
                      // Uint8List bytes = Uint8List.fromList(list);//
                      // var outcome = utf8.decode(bytes);
                      // print(outcome);

                      // final tempDir = await getTemporaryDirectory();
                      // io.File file = await io.File('${tempDir.path}/image.png').create();
                      // file.writeAsBytesSync(snapshot.data!);
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          );
        }


      setState(() {
        mediaList.addAll(temp);
        currentPage++;
      });
    } else {}
  }

  io.File createFileFromBytes(Uint8List bytes) => io.File.fromRawPath(bytes);

  Future<String> get getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<io.File> convertByteDataToFile(ByteData data) async {
    final path = await getLocalPath;
    final imagePath = '$path/image.png';
    io.File imageFile = io.File(imagePath);

    final buffer = data.buffer;
    final localFile = await imageFile.writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return localFile;
  }

  // Future<ui.Image> loadImage(Uint8List img) async {
  //   final Completer<ui.Image> completer = Completer();
  //   ui.decodeImageFromList(img, (ui.Image img) {
  //     return completer.complete(img);
  //   });
  //   return completer.future;
  // }

  // Future<void> loadImage() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final pathOfImage = await File('${directory.path}/legendary.png').create();
  //   final Uint8List bytes = stuff.buffer.asUint8List();
  //   await pathOfImage.writeAsBytes(bytes);
  // }

  Future<void> loadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        controller: widget.scrollCtr,
        itemCount: mediaList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // print(imagePath.length);
              // print(imageList.length);
              // print(imageList[0][index].id);
              // print(index);
            },
            child: mediaList[index],
          );
        },
      ),
    );
  }
}
