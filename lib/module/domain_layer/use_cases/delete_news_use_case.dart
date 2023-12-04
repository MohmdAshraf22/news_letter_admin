import '../../data_layer/models/news_model.dart';
import '../repsitories/base_news_repository.dart';

class DeleteNewsUseCase {
  final BaseMainRepository baseMainRepository;
  DeleteNewsUseCase(this.baseMainRepository);
  Stream<bool> delete({required String id,required String imageUrl}) {
    return baseMainRepository.deleteNewsStream(id: id,imageUrl: imageUrl);
  }
}