
extension DurationExtensions on Duration {
  String toDebugString() {
    assert(!isNegative, 'Negative duration passed to toDebugString');

    final parts = <String>[];
    var remaining = inMilliseconds.abs();
    if (remaining == 0) {
      return '0ms';
    }

    const units = _DurationUnit.values;

    for (var i = 0;;) {
      final _DurationUnit(:unit, :step) = units[i];
      final value = (remaining % step).truncate();
      if (value != 0) {
        parts.insert(0, '$value$unit');
      }

      if (++i == units.length || (remaining ~/= step) == 0) {
        break;
      }
    }

    return parts.join(' ');
  }
}

enum _DurationUnit {
  milliseconds('ms', 1000),
  seconds('s', 60),
  minutes('m', 60),
  hours('h', double.infinity);

  final String unit;
  final double step;

  const _DurationUnit(this.unit, [this.step = 0]);
}
