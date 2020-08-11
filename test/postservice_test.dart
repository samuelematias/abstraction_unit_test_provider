import 'package:abstraction_unit_test_provider/services/api/api.dart';
import 'package:abstraction_unit_test_provider/services/post_service.dart';
import 'package:abstraction_unit_test_provider/services/storage/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockStorageService extends Mock implements StorageService {}

class MockApi extends Mock implements Api {}

void main() {
  group('PostService Test | ', () {
    test('Constructing Service should find correct dependencies', () {
      var postService = PostService();
      expect(postService != null, true);
    });
  });

  // After implementing the abstract class (interface)
  test('Given postId 1, should call localStorageService with 1', () async {
    var mockStorageService = MockStorageService();

    var mockApi = MockApi();
    when(mockApi.likePost(1)).thenAnswer((_) => Future.value(true));

    var postService =
        PostService(api: mockApi, storageService: mockStorageService);
    await postService.likePost(1);
    verify(mockStorageService.likePost(1));
  });

  // Before implementing the abstract class (interface)
  // test('Given postId 1, should call localStorageService with 1', () async {
  //   var postService =
  //       PostService(api: Httapi, storageService: LocalStorageService);
  //   await postService.likePost(1);
  //   // expect(localStorageService);

  //   // We can't even check if the function was called!
  //   // expect(postService.likePost(1)) // ???
  // });

  test('Given like fails, should rever localike', () async {
    var mockStorageService = MockStorageService();
    // Like was successful locally
    when(mockStorageService.likePost(1)).thenAnswer((_) => Future.value(true));

    var mockApi = MockApi();
    // Like was successful locally
    when(mockApi.likePost(1)).thenAnswer((_) => Future.value(false));

    var postService =
        PostService(api: mockApi, storageService: mockStorageService);
    await postService.likePost(1);
    // Confirm the sstorage like was called with unlike
    verify(mockStorageService.likePost(1, unlike: true));
  });
}
