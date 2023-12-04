import 'package:get_it/get_it.dart';

import '../../module/data_layer/data_sources/news_remote_data_sources.dart';
import '../../module/data_layer/repositories/news_repository.dart';
import '../../module/domain_layer/repsitories/base_news_repository.dart';
import '../../module/presentation_layer/bloc/main_bloc.dart';


final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    /// main

    BaseNewsLetterRemoteDataSource baseNewsLetterRemoteDataSource = NewsLetterRemoteDataSource();
    sl.registerLazySingleton(() => baseNewsLetterRemoteDataSource);

    BaseMainRepository baseMainRepository = MainRepository(sl());
    sl.registerLazySingleton(() => baseMainRepository);

    /// blocs
    NewsLetterBloc newsLetterBloc = NewsLetterBloc(NewsLetterInitial());
    sl.registerLazySingleton(() => newsLetterBloc);

  }
}
