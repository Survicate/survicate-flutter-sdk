/// Represents a user related trait.
///
/// [key] is the trait key used to identify the trait.
/// [value] is the trait value.
class UserTrait {
  String key;
  String value;

  /// Creates a string trait.
  UserTrait.string(this.key, this.value);

  /// Creates a boolean trait.
  UserTrait.bool(String key, bool value) : this.string(key, value.toString());

  /// Creates a date time trait.
  UserTrait.dateTime(String key, DateTime value)
      : this.string(key, _formatDateToTimeZoneIso(value));

  /// Creates a number trait.
  UserTrait.num(String key, num value) : this.string(key, value.toString());

  static String _formatDateToTimeZoneIso(DateTime date) {
    var offset = date.timeZoneOffset.inMinutes;
    var offsetHours = (offset.abs() / 60).floor();
    var offsetMinutes = offset.abs() % 60;
    var offsetSign = date.timeZoneOffset.isNegative ? "-" : "+";
    return "${date.toIso8601String().substring(0, 19)}$offsetSign${offsetHours.toString().padLeft(2, '0')}:${offsetMinutes.toString().padLeft(2, '0')}";
  }
}
