
import '../entities/news.dart';
import '../repsitories/base_news_repository.dart';

class GetNewsUseCase {
  final BaseMainRepository baseMainRepository;
  GetNewsUseCase(this.baseMainRepository);
  Stream<List<News>> get() {
    return baseMainRepository.getNewsStream();
  }
}
