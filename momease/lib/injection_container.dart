import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/core/navigation_bar/cubit/custom_navigation_bar_cubit.dart';
import 'package:momease/src/core/network/network_info.dart';
import 'package:momease/src/features/articles/data/datasources/article_local_data_source.dart';
import 'package:momease/src/features/articles/data/repositories/article_repository_impl.dart';
import 'package:momease/src/features/articles/domain/repositories/article_repository.dart';
import 'package:momease/src/features/articles/domain/usecases/get_article_list.dart';
import 'package:momease/src/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:momease/src/features/community/data/datasources/community_local_data_source.dart';
import 'package:momease/src/features/community/data/datasources/community_post_local_data_source.dart';
import 'package:momease/src/features/community/data/repositories/community_post_repository_impl.dart';
import 'package:momease/src/features/community/data/repositories/community_repository_impl.dart';
import 'package:momease/src/features/community/domain/repositories/community_post_repository.dart';
import 'package:momease/src/features/community/domain/repositories/community_repository.dart';
import 'package:momease/src/features/community/domain/usecases/create_community_post.dart';
import 'package:momease/src/features/community/domain/usecases/get_community_list.dart';
import 'package:momease/src/features/community/domain/usecases/get_community_post_list.dart';
import 'package:momease/src/features/community/presentation/bloc/community_bloc.dart';
import 'package:momease/src/features/community/presentation/bloc/community_details_post_bloc.dart';
import 'package:momease/src/features/exercise/data/datasources/exercise_local_data_source.dart';
import 'package:momease/src/features/exercise/data/repositories/exercise_repository_impl.dart';
import 'package:momease/src/features/exercise/domain/repositories/exercise_repository.dart';
import 'package:momease/src/features/exercise/domain/usecases/get_exercise_list.dart';
import 'package:momease/src/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:momease/src/features/journal/data/datasources/journal_local_data_source.dart';
import 'package:momease/src/features/journal/data/repositories/journal_repository_impl.dart';
import 'package:momease/src/features/journal/domain/repositories/journal_repository.dart';
import 'package:momease/src/features/journal/domain/usecases/get_journal_entries.dart';
import 'package:momease/src/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:momease/src/features/therapy/data/datasources/therapy_local_data_source.dart';
import 'package:momease/src/features/therapy/data/repositories/therapy_repository_impl.dart';
import 'package:momease/src/features/therapy/domain/repositories/therapy_repository.dart';
import 'package:momease/src/features/therapy/domain/usecases/get_therapy_list.dart';
import 'package:momease/src/features/therapy/presentation/bloc/therapy_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  sl.registerFactory(() => TherapyBloc(getTherapyList: sl()));
  sl.registerFactory(() => ExerciseBloc(getExerciseList: sl()));
  sl.registerFactory(() => ArticlesBloc(getArticleList: sl()));
  sl.registerFactory(() => CommunityBloc(getCommunityList: sl()));
  sl.registerFactory(() => CommunityDetailsPostBloc(
      getCommunityPostList: sl(), createCommunityPost: sl()));
  sl.registerFactory(() => JournalBloc(getJournalList: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTherapyList(sl()));
  sl.registerLazySingleton(() => GetExerciseList(sl()));
  sl.registerLazySingleton(() => GetArticleList(sl()));
  sl.registerLazySingleton(() => GetCommunityList(sl()));
  sl.registerLazySingleton(() => GetCommunityPostList(sl()));
  sl.registerLazySingleton(() => CreateCommunityPost(sl()));
  sl.registerLazySingleton(() => GetJournalEntries(sl()));

  // Repository
  sl.registerLazySingleton<TherapyRepository>(
      () => TherapyRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<ExerciseRepository>(
      () => ExerciseRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<CommunityRepository>(
      () => CommunityRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<CommunityPostRepository>(
      () => CommunityPostRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<JournalRepository>(
      () => JournalRepositoryImpl(localDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<TherapyLocalDataSource>(
      () => TherapyLocalDataSourceImpl(database: sl()));
  sl.registerLazySingleton<ExerciseLocalDataSource>(
      () => ExerciseLocalDataSourceImpl(database: sl()));
  sl.registerLazySingleton<ArticleLocalDataSource>(
      () => ArticleLocalDataSourceImpl(database: sl()));
  sl.registerLazySingleton<CommunityLocalDataSource>(
      () => CommunityLocalDataSourceImpl(database: sl()));
  sl.registerLazySingleton<CommunityPostLocalDataSource>(
      () => CommunityPostLocalDataSourceImpl(database: sl()));
  sl.registerLazySingleton<JournalLocalDataSource>(
      () => JournalLocalDataSourceImpl(database: sl()));

  // Core
  sl.registerFactory(() => CustomNavigationBarCubit());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final database = AppDatabase.instance;
  sl.registerLazySingleton(() => database);
}
