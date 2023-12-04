import '../../data_layer/models/news_model.dart';
import '../repsitories/base_news_repository.dart';

class PostNewsUseCase {
  final BaseMainRepository baseMainRepository;
  PostNewsUseCase(this.baseMainRepository);
  Stream<bool> post({required NewsModel newsModel}) {
    return baseMainRepository.postNewsStream(newsModel: newsModel);
  }
}