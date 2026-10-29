import 'dart:math' as math;

import 'package:meta/meta.dart';

enum ByteUnit {
  byte('b', 1),
  kilobyte('kb', kilobyteBytes),
  megabyte('mb', megabyteBytes),
  gigabyte('gb', gigabyteBytes),
  terabyte('tb', terabyteBytes),
  ;

  static const kilobyteBytes = 1024;
  static const megabyteBytes = 1024 * kilobyteBytes;
  static const gigabyteBytes = 1024 * megabyteBytes;
  static const terabyteBytes = 1024 * gigabyteBytes;

  final String abbreviation;
  final int byteSize;

  const ByteUnit(this.abbreviation, this.byteSize);
}

@immutable
class FileSize {
  final int bytes;

  const FileSize.bytes(this.bytes) : assert(bytes >= 0, 'Bytes cannot be negative');
  const FileSize.kilobytes(double kilobytes) : this.bytes((kilobytes * ByteUnit.kilobyteBytes) ~/ 1);
  const FileSize.megabytes(double megabytes) : this.bytes((megabytes * ByteUnit.megabyteBytes) ~/ 1);
  const FileSize.gigabytes(double gigabytes) : this.bytes((gigabytes * ByteUnit.gigabyteBytes) ~/ 1);
  const FileSize.terabytes(double terabytes) : this.bytes((terabytes * ByteUnit.terabyteBytes) ~/ 1);

  @override
  toString({ByteUnit? unit, int decimals = 0}) {
    var value = bytes.toDouble();

    if (unit != null) {
      value = bytes / unit.byteSize;
    } else {
      const units = ByteUnit.values;

      var i = -1;

      while (++i < units.length && value >= 1024) {
        value /= 1024.0;
      }

      unit = units[i];
    }

    if (decimals > 0) {
      final log = math.pow(10, decimals);
      value = (value * log).roundToDouble() / log;
    } else {
      value = value.roundToDouble();
    }

    return '$value${unit.abbreviation}';
  }
}
