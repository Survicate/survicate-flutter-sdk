class UserTrait {
  String key;
  String value;

  UserTrait.string(this.key, this.value);

  UserTrait.bool(String key, bool value): this.string(key, value.toString());

  UserTrait.dateTime(String key, DateTime value) : this.string(key, _formatDateToTimeZoneIso(value));

  UserTrait.num(String key, num value) : this.string(key, value.toString());

  static String _formatDateToTimeZoneIso(DateTime date) {
    var offset = date.timeZoneOffset.inMinutes;
    var offsetHours = (offset.abs() / 60).floor();
    var offsetMinutes = offset.abs() % 60;
    var offsetSign = date.timeZoneOffset.isNegative ? "-" : "+";
    return "${date.toIso8601String().substring(0, 19)}$offsetSign${offsetHours.toString().padLeft(2, '0')}:${offsetMinutes.toString().padLeft(2, '0')}";
  }
}
