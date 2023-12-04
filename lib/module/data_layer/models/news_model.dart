import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain_layer/entities/news.dart';

//ignore: must_be_immutable
class NewsModel extends News {
  NewsModel({
    required super.id,
    required super.date,
    required super.description,
    required super.head,
    super.images,
    super.imagesUrlDeleted,
    required super.imagesUrl,
  });
  factory NewsModel.fromJson(QueryDocumentSnapshot<Object?> json) {
    return NewsModel(
      id: json.id,
      date: json['date'],
      description: json['description'],
      head: json['head'],
      imagesUrl: List<String>.from(json['images']).toList(),
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
