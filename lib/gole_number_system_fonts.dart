/// The GoleStandard fonts for the Gole Number System.
///
/// This package holds the two font files and the constants needed to use
/// them. It has no other logic. To turn a number into the text the font
/// needs, use `gole_core`; for ready-made widgets, use `flutter_gole`.
///
/// ```dart
/// const Text(
///   '0123', // two Gole symbols: 01 and 23
///   style: TextStyle(fontFamily: goleFontFamily, package: goleFontPackage),
/// );
/// ```
library;

/// The name of this package, for the `package:` argument of `TextStyle`.
const String goleFontPackage = 'gole_number_system_fonts';

/// The font family of the Ligature build.
///
/// The text stays as decimal digits and the font joins each pair of digits
/// into one Gole symbol, so `'0123'` is drawn as two symbols. The digit count
/// must be even: pad the whole part with a `0` on the left first.
///
/// Do not apply `letterSpacing` to text in this family; it stops the pairs
/// from joining. Use [goleFontFamilyPua] where letter spacing is needed.
const String goleFontFamily = 'GoleStandard';

/// The font family of the PUA build.
///
/// Each Gole symbol is one Private Use Area character: the symbol for the
/// pair `n` (0 to 99) is the code point [golePuaFirstCodePoint] + `n`.
const String goleFontFamilyPua = 'GoleStandardPUA';

/// The code point of the symbol for 00 in the PUA build, U+E441.
const int golePuaFirstCodePoint = 0xE441;

/// The code point of the symbol for 99 in the PUA build, U+E4A4.
const int golePuaLastCodePoint = 0xE4A4;
