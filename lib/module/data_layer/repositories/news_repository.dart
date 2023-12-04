
import 'package:admin_news_letter/module/data_layer/models/news_model.dart';

import '../../domain_layer/entities/news.dart';
import '../../domain_layer/repsitories/base_news_repository.dart';
import '../data_sources/news_remote_data_sources.dart';

class MainRepository extends BaseMainRepository {
  BaseMainRemoteDataSource baseMainRemoteDataSource;
  MainRepository(this.baseMainRemoteDataSource);

  @override
  Stream<List<NewsModel>> getNewsStream() {
    return baseMainRemoteDataSource.getNewsStream();
  }
  @override
  Stream<bool> postNewsStream({required NewsModel newsModel}) {
    return baseMainRemoteDataSource.postNewsStream(newsModel: newsModel);
  }
  @override
  Stream<bool> editNewsStream({required NewsModel newsModel}) {
    return baseMainRemoteDataSource.editNewsStream(newsModel: newsModel);
  }
  @override
  Stream<bool> deleteNewsStream({required String id,required String imageUrl}) {
    return baseMainRemoteDataSource.deleteNewsStream(id: id,imageUrl: imageUrl);
  }
}
