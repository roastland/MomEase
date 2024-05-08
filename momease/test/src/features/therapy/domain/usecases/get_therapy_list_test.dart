import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/therapy/domain/entities/therapy_entity.dart';
import 'package:momease/src/features/therapy/domain/repositories/therapy_repository.dart';
import 'package:momease/src/features/therapy/domain/usecases/get_therapy_list.dart';

@GenerateNiceMocks([MockSpec<TherapyRepository>()])
import 'get_therapy_list_test.mocks.dart';

void main() {
  late GetTherapyList usecase;
  late MockTherapyRepository mockTherapyRepository;

  setUp(() {
    mockTherapyRepository = MockTherapyRepository();
    usecase = GetTherapyList(mockTherapyRepository);
  });

  const tTherapyEntity1 = TherapyEntity(
    id: 1,
    title: 'Music Therapy',
    imageUrl: 'imageUrl',
    description: 'description',
  );
  const tTherapyEntity2 = TherapyEntity(
    id: 2,
    title: 'Art Therapy',
    imageUrl: 'imageUrl',
    description: 'description',
  );
  final tTherapyList = [tTherapyEntity1, tTherapyEntity2];

  test('should get therapy list from the repository', () async {
    // arrange
    when(mockTherapyRepository.getTherapyList())
        .thenAnswer((_) async => Right(tTherapyList));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tTherapyList));
    verify(mockTherapyRepository.getTherapyList());
    verifyNoMoreInteractions(mockTherapyRepository);
  });
}
