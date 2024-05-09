import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/community/domain/entities/community_entity.dart';
import 'package:momease/src/features/community/domain/repositories/community_repository.dart';
import 'package:momease/src/features/community/domain/usecases/get_community_list.dart';

@GenerateNiceMocks([MockSpec<CommunityRepository>()])
import 'get_community_list_test.mocks.dart';

void main() {
  late GetCommunityList usecase;
  late MockCommunityRepository mockCommunityRepository;

  setUp(() {
    mockCommunityRepository = MockCommunityRepository();
    usecase = GetCommunityList(mockCommunityRepository);
  });

  const tCommunityEntity1 = CommunityEntity(
      id: 1,
      topic: 'Breastfeeding',
      imageUrl: 'imageUrl',
      description: 'description',
      countPost: 10000);
  const tCommunityEntity2 = CommunityEntity(
      id: 2,
      topic: 'Milk Pumping',
      imageUrl: 'imageUrl',
      description: 'description',
      countPost: 10000);
  final tCommunityList = [tCommunityEntity1, tCommunityEntity2];

  test('should get community list from the repository', () async {
    // arrange
    when(mockCommunityRepository.getCommunityList())
        .thenAnswer((_) async => Right(tCommunityList));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tCommunityList));
    verify(mockCommunityRepository.getCommunityList());
    verifyNoMoreInteractions(mockCommunityRepository);
  });
}
