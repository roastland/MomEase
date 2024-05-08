import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/network/network_info.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to NetworkInfoImpl.isConnected',
      () async {
        // arrange
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
        // act
        final result = await networkInfo.isConnected;
        // assert
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, true);
      },
    );
  });
}
