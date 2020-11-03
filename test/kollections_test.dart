import 'package:kollections/kollections.dart';
import 'package:test/test.dart';

void main() {
  group('A grouping tests', () {
    test('Windowed test', () {
      final source = List.generate(10, (index) => index);
      expect(source.windowed(3, step: 2, partialWindows: true), [
        [0, 1, 2],
        [2, 3, 4],
        [4, 5, 6],
        [6, 7, 8],
        [8, 9]
      ]);

      expect(source.windowed(1, step: 3, partialWindows: true), [
        [0],
        [3],
        [6],
        [9]
      ]);
    });

    test('Chunked test', () {
      final source = List.generate(10, (index) => index);
      expect(source.chunked(5), [
        [0, 1, 2, 3, 4],
        [5, 6, 7, 8, 9]
      ]);
    });

    test('For each indexed test', () {
      final source = List.generate(10, (index) => index);
      source.forEachIndexed((index, element) {
        expect(index, element);
      });
    });

    test('Group by to test', () {
      final source = List.generate(10, (index) => index);
      expect(source.groupByTo(<bool, List<int>>{}, (element) => element > 5), {
        false: [0, 1, 2, 3, 4, 5],
        true: [6, 7, 8, 9]
      });
    });

    test('Group by to test', () {
      final source = List.generate(10, (index) => index);
      expect(source.groupBy((element) => element > 5), {
        false: [0, 1, 2, 3, 4, 5],
        true: [6, 7, 8, 9]
      });
    });

    test('Associate test', () {
      final source = List.generate(10, (index) => index);
      print(source.associateWith((key) => key * 5));
    });
  });
}
