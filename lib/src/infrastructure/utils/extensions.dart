import 'dart:ui';

extension ColorExtension on Color {
  static Color? fromJson(String? json) {
    // Assuming the color is stored as a hex string in the format '#RRGGBB'
    return json!=null?Color(int.parse(json.replaceFirst('#', '0xff'))):null;
  }

  static String? toJson(Color? color) {
    return color!=null?'#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}':null;
  }
}

extension ColorListExtension on List<Color?>? {
  List<String?>? toJson() {
    return this?.map((color) {
      return color != null
          ? '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}'
          : null;
    }).toList();
  }

  // Convert a list of hex strings (from JSON) back to a list of Colors
  static List<Color?>? fromJson(List<String?> jsonList) {
    return jsonList.map((hex) {
      return hex != null
          ? Color(int.parse(hex.replaceFirst('#', '0xff')))
          : null;
    }).toList();
  }
}