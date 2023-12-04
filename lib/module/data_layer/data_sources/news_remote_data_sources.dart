import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import '../../domain_layer/entities/news.dart';
import '../models/news_model.dart';

abstract class BaseNewsLetterRemoteDataSource {
  Stream<List<NewsModel>> getNewsStream();
  Stream<bool> postNewsStream({required NewsModel newsModel});
  Stream<bool> editNewsStream({required NewsModel newsModel});
  Stream<bool> deleteNewsStream({required String id, required List<String> imagesUrl});
}

class NewsLetterRemoteDataSource extends BaseNewsLetterRemoteDataSource {
  final CollectionReference newsCollection =
      FirebaseFirestore.instance.collection("news_letter");

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
      {required String id, required List<String> imagesUrl}) {
    return Stream.fromFuture(
      newsCollection.doc(id).delete().then((_) {
        for(String imageUrl in imagesUrl) {
          String imageName = getImageName(url: imageUrl);
          FirebaseStorage.instance.ref().child("news_letter/$imageName").delete();
        }
        return true;
      }).catchError((error) {
        return false;
      }),
    );
  }

  @override
  Stream<bool> editNewsStream({required NewsModel newsModel}) {
    return Stream.fromFuture(() async {
      if (newsModel.imagesUrlDeleted != null && newsModel.imagesUrlDeleted!.isNotEmpty) {
        print("newsModel.imagesUrlDeleted ${newsModel.imagesUrlDeleted}");
        for (String image in newsModel.imagesUrlDeleted!) {
          deleteImageFromFirebaseStorage(fileName: getImageName(url: image));
        }
      }
      if (newsModel.images != null && newsModel.images!.isNotEmpty) {
        newsModel.imagesUrl = [];
        for (var image in newsModel.images!) {
          await uploadImageToFirebaseStorage(
              filePath: image.imageMemory, fileName: image.imageName).then((downloadUrl){
            newsModel.imagesUrl.add(downloadUrl);
          });
        }
      }
      try {
        await newsCollection.doc(newsModel.id).update(newsModel.toJson());
        return true;
      } catch (error) {
        print('Error Editing news: $error');
        return false;
      }
    }());
  }

  @override
  Stream<bool> postNewsStream({required NewsModel newsModel}) {
    return Stream.fromFuture(() async {
      newsModel.imagesUrl = [];
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
      {required Uint8List filePath,required String fileName}) async {
      Reference storageReference =
          FirebaseStorage.instance.ref().child("news_letter/$fileName");
      await storageReference.putData(filePath);
      return await storageReference.getDownloadURL();
  }

  void deleteImageFromFirebaseStorage({required String fileName}) async {
    FirebaseStorage.instance.ref().child("news_letter/$fileName").delete();
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
