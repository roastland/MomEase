import 'package:flutter_test/flutter_test.dart';
import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/features/articles/data/models/article_model.dart';
import 'package:momease/src/features/community/data/models/community_model.dart';
import 'package:momease/src/features/community/data/models/community_post_model.dart';
import 'package:momease/src/features/exercise/data/models/exercise_model.dart';
import 'package:momease/src/features/therapy/data/models/therapy_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });

  const tTherapy1 = TherapyModel(
    id: 1,
    title: 'Music Therapy',
    imageUrl: 'imageUrl',
    description: 'description',
  );
  const tTherapy2 = TherapyModel(
    id: 2,
    title: 'Art Therapy',
    imageUrl: 'imageUrl',
    description: 'description',
  );

  Future<void> insertAllTherapy() async {
    await AppDatabase.instance.createTherapy(tTherapy1);
    await AppDatabase.instance.createTherapy(tTherapy2);
  }

  group("therapy", () {
    test(
      'should return empty list when there is no therapy data in the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        final result = await AppDatabase.instance.readAllTherapy();
        // assert
        expect(result, []);
      },
    );

    test(
      'should return all therapy data from the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        await insertAllTherapy();
        final result = await AppDatabase.instance.readAllTherapy();
        // assert
        expect(result, [tTherapy1, tTherapy2]);
      },
    );
  });

  const tExercise1 = ExerciseModel(
    id: 1,
    title: 'Exercise 1',
    imageUrl: 'imageUrl',
    description: 'description',
  );
  const tExercise2 = ExerciseModel(
    id: 2,
    title: 'Exercise 2',
    imageUrl: 'imageUrl',
    description: 'description',
  );

  Future<void> insertAllExercise() async {
    await AppDatabase.instance.createExercise(tExercise1);
    await AppDatabase.instance.createExercise(tExercise2);
  }

  group("exercise", () {
    test(
      'should return empty list when there is no exercise data in the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        final result = await AppDatabase.instance.readAllExercise();
        // assert
        expect(result, []);
      },
    );

    test(
      'should return all exercise data from the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        await insertAllExercise();
        final result = await AppDatabase.instance.readAllExercise();
        // assert
        expect(result, [tExercise1, tExercise2]);
      },
    );
  });

  final tArticle1 = ArticleModel(
    id: 1,
    title: 'Understanding the Postpartum Blues: When Joy is Met with Tears',
    imageUrl: 'imageUrl',
    description: '',
    readingTime: 3,
    author: 'Dr. Cresya N.',
    publishedOn: DateTime(2024, 2, 22),
  );
  final tArticle2 = ArticleModel(
    id: 2,
    title: 'Building a Happy Haven: Nurturing Joy for Mom and Baby',
    imageUrl: 'imageUrl',
    description: '',
    readingTime: 5,
    author: 'Dr. Cresya N.',
    publishedOn: DateTime(2024, 2, 22),
  );

  Future<void> insertAllArticle() async {
    await AppDatabase.instance.createArticle(tArticle1);
    await AppDatabase.instance.createArticle(tArticle2);
  }

  group("article", () {
    test(
      'should return empty list when there is no article data in the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        final result = await AppDatabase.instance.readAllArticle();
        // assert
        expect(result, []);
      },
    );

    test(
      'should return all article data from the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        await insertAllArticle();
        final result = await AppDatabase.instance.readAllArticle();
        // assert
        expect(result, [tArticle1, tArticle2]);
      },
    );
  });

  const tCommunity1 = CommunityModel(
    id: 1,
    topic: 'topic',
    imageUrl: 'imageUrl',
    description: 'description',
    countPost: 10000,
  );
  const tCommunity2 = CommunityModel(
    id: 2,
    topic: 'topic',
    imageUrl: 'imageUrl',
    description: 'description',
    countPost: 10000,
  );

  Future<void> insertAllCommunity() async {
    await AppDatabase.instance.createCommunity(tCommunity1);
    await AppDatabase.instance.createCommunity(tCommunity2);
  }

  group("community", () {
    test(
      'should return empty list when there is no community data in the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        final result = await AppDatabase.instance.readAllCommunity();
        // assert
        expect(result, []);
      },
    );

    test(
      'should return all community data from the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        await insertAllCommunity();
        final result = await AppDatabase.instance.readAllCommunity();
        // assert
        expect(result, [tCommunity1, tCommunity2]);
      },
    );
  });

  final tCommunityPost1 = CommunityPostModel(
      id: 1,
      topicId: 1,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);
  final tCommunityPost2 = CommunityPostModel(
      id: 2,
      topicId: 1,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);
  final tCommunityPost3 = CommunityPostModel(
      id: 3,
      topicId: 2,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);

  Future<void> insertAllCommunityPost() async {
    await AppDatabase.instance.createCommunityPost(tCommunityPost1);
    await AppDatabase.instance.createCommunityPost(tCommunityPost2);
    await AppDatabase.instance.createCommunityPost(tCommunityPost3);
  }

  group("community post", () {
    test(
      'should return empty list when there is no community post data in the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        final result =
            await AppDatabase.instance.readCommunityPostCertainTopic(1);
        // assert
        expect(result, []);
      },
    );

    test(
      'should return all community post data from the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        await insertAllCommunityPost();
        final result = await AppDatabase.instance.readAllCommunityPost();
        // assert
        expect(result, [tCommunityPost1, tCommunityPost2, tCommunityPost3]);
      },
    );

    test(
      'should return all community post data from the database with certain topic',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        await insertAllCommunityPost();
        final result =
            await AppDatabase.instance.readCommunityPostCertainTopic(1);
        // assert
        expect(result, [tCommunityPost1, tCommunityPost2]);
      },
    );
  });
}
