import '../../data_layer/models/news_model.dart';
import '../repsitories/base_news_repository.dart';

class EditNewsUseCase {
  final BaseMainRepository baseMainRepository;
  EditNewsUseCase(this.baseMainRepository);
  Stream<bool> edit({required NewsModel newsModel}) {
    return baseMainRepository.editNewsStream(newsModel: newsModel);
  }
}