/// Represents an attribute that can be attached to a survey response.
///
/// [name] is the attribute name used to identify the attribute.
/// [value] is the attribute value.
/// [provider] is an optional provider name for the attribute.
class ResponseAttribute {
  String name;
  String value;
  String? provider;

  /// Creates a string attribute.
  ResponseAttribute.string(this.name, this.value, {this.provider});

  /// Creates a boolean attribute.
  ResponseAttribute.bool(String name, bool value, {String? provider})
      : this.string(name, value.toString(), provider: provider);

  /// Creates a date time attribute.
  ResponseAttribute.dateTime(String name, DateTime value, {String? provider})
      : this.string(name, _formatDateToTimeZoneIso(value), provider: provider);

  /// Creates a number attribute.
  ResponseAttribute.num(String name, num value, {String? provider})
      : this.string(name, value.toString(), provider: provider);

  static String _formatDateToTimeZoneIso(DateTime date) {
    var offset = date.timeZoneOffset.inMinutes;
    var offsetHours = (offset.abs() / 60).floor();
    var offsetMinutes = offset.abs() % 60;
    var offsetSign = date.timeZoneOffset.isNegative ? "-" : "+";
    return "${date.toIso8601String().substring(0, 19)}$offsetSign${offsetHours.toString().padLeft(2, '0')}:${offsetMinutes.toString().padLeft(2, '0')}";
  }
}
