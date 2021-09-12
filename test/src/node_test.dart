import 'package:tree_collection/tree_collection.dart';
import 'package:test/test.dart';

void main() {
  group('Node', () {
    test('By default children is empty', () async {
      // act
      final node = Node(key: 1);

      // assert
      expect(node.hasChildren, isFalse);
    });
  });
}
