import 'package:vi_collection/vi_collection.dart';
import 'package:test/test.dart';

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
