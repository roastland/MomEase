import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
import 'package:momease/src/features/community/domain/repositories/community_post_repository.dart';
import 'package:momease/src/features/community/domain/usecases/get_community_post_list.dart';

@GenerateNiceMocks([MockSpec<CommunityPostRepository>()])
import 'get_community_post_list_test.mocks.dart';

void main() {
  late GetCommunityPostList usecase;
  late MockCommunityPostRepository mockCommunityPostRepository;

  setUp(() {
    mockCommunityPostRepository = MockCommunityPostRepository();
    usecase = GetCommunityPostList(mockCommunityPostRepository);
  });

  final tCommunityPostEntity1 = CommunityPostEntity(
      id: 1,
      topicId: 1,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12, 0, 0),
      countComments: 12,
      countViews: 200);
  final tCommunityPostEntity2 = CommunityPostEntity(
      id: 2,
      topicId: 1,
      username: 'Jennie C.',
      text:
          'My baby has a bad latch - breastfeeding is painful! What can I do?',
      timestamp: DateTime(2024, 5, 1, 12, 0, 0),
      countComments: 10,
      countViews: 100);

  final tCommunityPostList = [tCommunityPostEntity1, tCommunityPostEntity2];

  test('should get community post list from the repository', () async {
    // arrange
    when(mockCommunityPostRepository.getCommunityPostList(1))
        .thenAnswer((_) async => Right(tCommunityPostList));
    // act
    final result = await usecase(const CommunityPostParams(topicId: 1));
    // assert
    expect(result, Right(tCommunityPostList));
    verify(mockCommunityPostRepository.getCommunityPostList(1));
    verifyNoMoreInteractions(mockCommunityPostRepository);
  });
}
