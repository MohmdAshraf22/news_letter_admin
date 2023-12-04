
import '../../data_layer/models/news_model.dart';
import '../repsitories/base_news_repository.dart';

class GetNewsUseCase {
  final BaseMainRepository baseMainRepository;
  GetNewsUseCase(this.baseMainRepository);
  Stream<List<NewsModel>> get() {
    return baseMainRepository.getNewsStream();
  }
}
