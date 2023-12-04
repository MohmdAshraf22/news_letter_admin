import 'package:admin_news_letter/module/domain_layer/entities/image_data.dart';
import 'package:equatable/equatable.dart';
//ignore: must_be_immutable
class News extends Equatable {
  String id;
  String head;
  String description;
  String date;
  List<ImageData>? images;
  List<String> imagesUrl;
  List<String>? imagesUrlDeleted;
  News({
    required this.id,
    required this.date,
    required this.description,
    required this.head,
    this.images,
    this.imagesUrlDeleted,
    required this.imagesUrl,
  });
  @override
  List<Object?> get props => [id, head];
}
