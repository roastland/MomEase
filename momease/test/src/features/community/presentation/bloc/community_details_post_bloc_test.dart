import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
import 'package:momease/src/features/community/domain/usecases/create_community_post.dart';
import 'package:momease/src/features/community/domain/usecases/get_community_post_list.dart';
import 'package:momease/src/features/community/presentation/bloc/community_details_post_bloc.dart';

@GenerateNiceMocks(
    [MockSpec<GetCommunityPostList>(), MockSpec<CreateCommunityPost>()])
import 'community_details_post_bloc_test.mocks.dart';

void main() {
  late CommunityDetailsPostBloc bloc;
  late MockGetCommunityPostList mockGetCommunityPostList;
  late MockCreateCommunityPost mockCreateCommunityPost;

  setUp(() {
    mockGetCommunityPostList = MockGetCommunityPostList();
    mockCreateCommunityPost = MockCreateCommunityPost();
    bloc = CommunityDetailsPostBloc(
      getCommunityPostList: mockGetCommunityPostList,
      createCommunityPost: mockCreateCommunityPost,
    );
  });

  final tCommunityPost1 = CommunityPostEntity(
      id: 1,
      topicId: 1,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);
  final tCommunityPost2 = CommunityPostEntity(
      id: 2,
      topicId: 1,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);
  final tCommunityPost3 = CommunityPostEntity(
      id: 3,
      topicId: 2,
      username: 'Gregoria',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);
  final tCommunityPostList = [tCommunityPost1, tCommunityPost2];

  test('initial state should be CommunityDetailsPostInitial', () {
    // assert
    expect(bloc.state, equals(CommunityDetailsPostInitial()));
  });

  group('FetchCommunityPostList', () {
    test('should get community post list from the usecase', () async {
      // arrange
      when(mockGetCommunityPostList(any))
          .thenAnswer((_) async => Right(tCommunityPostList));
      // act
      bloc.add(const FetchCommunityDetailsPost(1));
      await untilCalled(mockGetCommunityPostList(any));
      // assert
      verify(mockGetCommunityPostList(const CommunityPostParams(topicId: 1)));
    });

    test(
        'should emit [CommunityDetailsPostLoading, CommunityDetailsPostLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetCommunityPostList(any))
          .thenAnswer((_) async => Right(tCommunityPostList));
      // assert later
      final expected = [
        CommunityDetailsPostLoading(),
        CommunityDetailsPostLoaded(tCommunityPostList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const FetchCommunityDetailsPost(1));
    });

    test(
        'should emit [CommunityDetailsPostLoading, FailureState] when getting data fails',
        () async {
      // arrange
      when(mockGetCommunityPostList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        CommunityDetailsPostLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const FetchCommunityDetailsPost(1));
    });

    test(
        'should emit [CommunityDetailsPostLoading, FailureState] with proper error message',
        () async {
      // arrange
      when(mockGetCommunityPostList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        CommunityDetailsPostLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const FetchCommunityDetailsPost(1));
    });
  });

  group('CreateCommunityPost', () {
    test('should create community post from the usecase', () async {
      // arrange
      when(mockCreateCommunityPost(any))
          .thenAnswer((_) async => Right(tCommunityPost3.id));
      when(mockGetCommunityPostList(any))
          .thenAnswer((_) async => Right(tCommunityPostList));
      // act
      bloc.add(CreateCommunityDetailsPost(tCommunityPost3));
      bloc.add(const FetchCommunityDetailsPost(1));
      await untilCalled(mockCreateCommunityPost(any));
      await untilCalled(mockGetCommunityPostList(any));
      // assert
      verify(mockCreateCommunityPost(
          CreateCommunityPostParams(communityPost: tCommunityPost3)));
      verify(mockGetCommunityPostList(const CommunityPostParams(topicId: 1)));
    });

    test(
        'should emit [CommunityDetailsPostLoading, CommunityPostCreated] when data is created successfully',
        () async {
      // arrange
      when(mockCreateCommunityPost(any))
          .thenAnswer((_) async => Right(tCommunityPost3.id));
      when(mockGetCommunityPostList(any))
          .thenAnswer((_) async => Right(tCommunityPostList));
      // assert later
      final expected = [
        CommunityDetailsPostLoading(),
        CommunityDetailsPostLoaded(tCommunityPostList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CreateCommunityDetailsPost(tCommunityPost3));
      bloc.add(const FetchCommunityDetailsPost(1));
    });

    test(
        'should emit [CommunityDetailsPostLoading, FailureState] when creating data success but fetching data fails',
        () async {
      // arrange
      when(mockCreateCommunityPost(any))
          .thenAnswer((_) async => Right(tCommunityPost3.id));
      when(mockGetCommunityPostList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        CommunityDetailsPostLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CreateCommunityDetailsPost(tCommunityPost3));
      bloc.add(const FetchCommunityDetailsPost(1));
    });

    test(
        'should emit [CommunityDetailsPostLoading, FailureState] when creating data fails',
        () async {
      // arrange
      when(mockCreateCommunityPost(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      when(mockGetCommunityPostList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        CommunityDetailsPostLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CreateCommunityDetailsPost(tCommunityPost3));
      bloc.add(const FetchCommunityDetailsPost(1));
    });
  });
}
