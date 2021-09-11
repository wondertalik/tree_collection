import 'package:flutter_test/flutter_test.dart';
import 'package:vi_collection/vi_collection.dart';

void main() {
  group('ViNode', () {
    test('By default children is empty', () async {
      // act
      final node = ViNode(key: 1);

      // assert
      expect(node.hasChildren, isFalse);
    });
  });
}
