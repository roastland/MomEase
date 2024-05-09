import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
import 'package:momease/src/features/community/domain/repositories/community_post_repository.dart';
import 'package:momease/src/features/community/domain/usecases/create_community_post.dart';

@GenerateNiceMocks([MockSpec<CommunityPostRepository>()])
import 'create_community_post_test.mocks.dart';

void main() {
  late CreateCommunityPost usecase;
  late MockCommunityPostRepository mockCommunityPostRepository;

  setUp(() {
    mockCommunityPostRepository = MockCommunityPostRepository();
    usecase = CreateCommunityPost(mockCommunityPostRepository);
  });

  final tCommunityPost = CommunityPostEntity(
      id: 3,
      topicId: 1,
      username: 'Georgia D.',
      text:
          'I feel it too! I found that using a nipple shield helped a lot. It\'s a bit of a pain to use, but it made a huge difference for me.',
      timestamp: DateTime(2024, 5, 1, 12, 0, 0),
      countComments: 12,
      countViews: 200);
  final tParams = CreateCommunityPostParams(communityPost: tCommunityPost);

  test('should create a community post from the repository', () async {
    // arrange
    when(mockCommunityPostRepository.createCommunityPost(tCommunityPost))
        .thenAnswer((_) async => Right(tParams.communityPost.id));
    // act
    final result = await usecase(tParams);
    // assert
    expect(result, Right(tParams.communityPost.id));
    verify(mockCommunityPostRepository.createCommunityPost(tCommunityPost));
    verifyNoMoreInteractions(mockCommunityPostRepository);
  });
}
