import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_demo/util/duration_extensions.dart';
import 'package:flutter_demo/util/file_size.dart';

void main() {
  group('FileSize Unit Tests', () {
    test('FileSize.bytes formatting', () {
      expect(const FileSize.bytes(500).toString(), '500.0b');
      expect(const FileSize.bytes(1024).toString(), '1.0kb');
      expect(const FileSize.bytes(1048576).toString(), '1.0mb');
    });

    test('FileSize constructors and unit conversions', () {
      expect(const FileSize.kilobytes(1).bytes, 1024);
      expect(const FileSize.megabytes(1).bytes, 1024 * 1024);
      expect(const FileSize.gigabytes(1).bytes, 1024 * 1024 * 1024);
    });

    test('FileSize formatting with decimals', () {
      const size = FileSize.bytes(1500);
      expect(size.toString(decimals: 2), '1.46kb');
    });
  });

  group('DurationExtensions Unit Tests', () {
    test('toDebugString formatting', () {
      expect(const Duration(milliseconds: 0).toDebugString(), '0ms');
      expect(const Duration(milliseconds: 500).toDebugString(), '500ms');
      expect(const Duration(seconds: 2, milliseconds: 300).toDebugString(), '2s 300ms');
      expect(
        const Duration(minutes: 5, seconds: 12, milliseconds: 100).toDebugString(),
        '5m 12s 100ms',
      );
    });
  });
}
