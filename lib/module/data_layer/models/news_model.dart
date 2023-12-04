import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain_layer/entities/news.dart';

//ignore: must_be_immutable
class NewsModel extends News {
  NewsModel({
    required super.id,
    required super.date,
    required super.description,
    required super.head,
    required super.images,
    required super.imagesUrl,
  });
  static News fromJson(QueryDocumentSnapshot<Object?> json) {
    return News(
      id: json.id,
      date: json['date'],
      description: json['description'],
      head: json['head'],
      imagesUrl: json['images'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "head": head,
      "description": description,
      "images": imagesUrl,
    };
  }
}
