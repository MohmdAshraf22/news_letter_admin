import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import '../../domain_layer/entities/news.dart';
import '../models/news_model.dart';

abstract class BaseMainRemoteDataSource {
  Stream<List<NewsModel>> getNewsStream();
  Stream<bool> postNewsStream({required NewsModel newsModel});
  Stream<bool> editNewsStream({required NewsModel newsModel});
  Stream<bool> deleteNewsStream({required String id, required String imageUrl});
}

class MainRemoteDataSource extends BaseMainRemoteDataSource {
  final CollectionReference newsCollection =
      FirebaseFirestore.instance.collection("news");

  @override
  Stream<List<NewsModel>> getNewsStream() {
    return newsCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return NewsModel.fromJson(doc);
      }).toList();
    });
  }

  @override
  Stream<bool> deleteNewsStream(
      {required String id, required String imageUrl}) {
    return Stream.fromFuture(
      newsCollection.doc(id).delete().then((_) {
        String imageName = getImageName(url: imageUrl);
        FirebaseStorage.instance.ref().child("news/$imageName").delete();
        return true;
      }).catchError((error) {
        return false;
      }),
    );
  }

  @override
  Stream<bool> editNewsStream({required NewsModel newsModel}) {
    return Stream.fromFuture(() async {
      if (newsModel.imagesUrlDeleted != null) {
        print("object");
        print(newsModel.imagesUrlDeleted );
        for (String image in newsModel.imagesUrlDeleted!) {
          print(image);
          deleteImageFromFirebaseStorage(getImageName(url: image));
          print("deleted");
        }
      }
      if (newsModel.images != null) {
        for (var image in newsModel.images!) {
          String downloadUrl = await uploadImageToFirebaseStorage(
              filePath: image.imageMemory, fileName: image.imageName);
          newsModel.imagesUrl.add(downloadUrl);
        }
      }
      try {
        await newsCollection.doc(newsModel.id).update(newsModel.toJson());
        return true;
      } catch (error) {
        print('Error posting news: $error');
        return false;
      }
    }());
  }

  @override
  Stream<bool> postNewsStream({required NewsModel newsModel}) {
    return Stream.fromFuture(() async {
      for (var image in newsModel.images!) {
        String downloadUrl = await uploadImageToFirebaseStorage(
            filePath: image.imageMemory, fileName: image.imageName);
        newsModel.imagesUrl.add(downloadUrl);
      }
      try {
        await newsCollection.doc(newsModel.id).set(newsModel.toJson());
        return true;
      } catch (error) {
        print('Error posting news: $error');
        return false;
      }
    }());
  }

  Future<String> uploadImageToFirebaseStorage(
      {Uint8List? filePath, String? fileName}) async {
    if (filePath != null && fileName != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child("news/$fileName");
      await storageReference.putData(filePath);
      return await storageReference.getDownloadURL();
    }
    return "";
  }

  void deleteImageFromFirebaseStorage(String fileName) async {
    FirebaseStorage.instance.ref().child("news/$fileName}").delete();
  }

  String getImageName({required String url}) {
    Uri uri = Uri.parse(url);
    String decodedPath = Uri.decodeComponent(uri.path);
    List<String> pathSegments = decodedPath.split('/');
    String imageName = pathSegments.last;
    print(imageName);
    return imageName;
  }
}
