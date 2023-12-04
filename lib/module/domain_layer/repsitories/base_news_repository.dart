import '../../data_layer/models/news_model.dart';
import '../entities/news.dart';

abstract class BaseMainRepository {
  Stream<List<NewsModel>> getNewsStream();
  Stream<bool> editNewsStream({required NewsModel newsModel});
  Stream<bool> postNewsStream({required NewsModel newsModel});
  Stream<bool> deleteNewsStream({required String id,required String imageUrl});
}
