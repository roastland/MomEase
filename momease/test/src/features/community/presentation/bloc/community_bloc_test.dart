import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/community/domain/entities/community_entity.dart';
import 'package:momease/src/features/community/domain/usecases/get_community_list.dart';
import 'package:momease/src/features/community/presentation/bloc/community_bloc.dart';

@GenerateNiceMocks([MockSpec<GetCommunityList>()])
import 'community_bloc_test.mocks.dart';

void main() {
  late CommunityBloc bloc;
  late MockGetCommunityList mockGetCommunityList;

  setUp(() {
    mockGetCommunityList = MockGetCommunityList();
    bloc = CommunityBloc(getCommunityList: mockGetCommunityList);
  });

  test('initial state should be CommunityInitial', () {
    // assert
    expect(bloc.state, equals(CommunityInitial()));
  });

  group('FetchCommunityList', () {
    const tCommunity1 = CommunityEntity(
      id: 1,
      topic: 'Breastfeeding',
      imageUrl: 'imageUrl',
      description: 'description',
      countPost: 10000,
    );
    const tCommunity2 = CommunityEntity(
      id: 2,
      topic: 'Milk Pumping',
      imageUrl: 'imageUrl',
      description: 'description',
      countPost: 10000,
    );
    final tCommunityList = [tCommunity1, tCommunity2];

    test('should get community list from the usecase', () async {
      // arrange
      when(mockGetCommunityList(any))
          .thenAnswer((_) async => Right(tCommunityList));
      // act
      bloc.add(FetchCommunityList());
      await untilCalled(mockGetCommunityList(any));
      // assert
      verify(mockGetCommunityList(NoParams()));
    });

    test(
        'should emit [CommunityLoading, CommunityLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetCommunityList(any))
          .thenAnswer((_) async => Right(tCommunityList));
      // assert later
      final expected = [
        CommunityLoading(),
        CommunityLoaded(tCommunityList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchCommunityList());
    });

    test('should emit [CommunityLoading, FailureState] when getting data fails',
        () async {
      // arrange
      when(mockGetCommunityList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        CommunityLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchCommunityList());
    });

    test(
        'should emit [CommunityLoading, FailureState] with proper error message',
        () async {
      // arrange
      when(mockGetCommunityList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        CommunityLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchCommunityList());
    });
  });
}
