/// Represents a complete set of fonts used by the SDK.
///
/// [regular] Standard font for normal body text.
/// [regularItalic] Standard font with italic slant.
/// [bold] Bold style font for emphasized content.
/// [boldItalic] Bold style font with italic slant.
/// ```
class SurvicateFontSystem {

  final String regular;
  final String regularItalic;
  final String bold;
  final String boldItalic;

  const SurvicateFontSystem({
    required this.regular,
    required this.regularItalic,
    required this.bold,
    required this.boldItalic,
  });

  Map<String, String> toMap() => {
        'regular': regular,
        'regularItalic': regularItalic,
        'bold': bold,
        'boldItalic': boldItalic,
      };
}
