import 'package:chatiques/common/services/api_service.dart';
import 'package:chatiques/common/services/storage_service.dart';
import 'package:chatiques/repositories/openai/openai_repositoty_impl.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<ApiService>(ApiService());
  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<OpenAIRepositoryImpl>(
      () => OpenAIRepositoryImpl());
  await locator.allReady();
}
