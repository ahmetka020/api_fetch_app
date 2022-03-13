import 'package:api_fetch_app/models/dog_model.dart';
import 'package:api_fetch_app/resources/api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'unit_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchDogs', () {
    test('returns dog list if the call completes successfully', () async {
      final client = MockClient();
      when(client.get(Uri.parse('https://dog.ceo/api/breeds/list/all'))).thenAnswer((_) async => http.Response('', 200));
      expect(await ApiProvider().fetchDogList(), isA<List<DogModel>>());
    });
  });
}
