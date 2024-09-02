import 'color_value.model.dart';

class ColorPalette {
  late String name;
  late ColorValue primaryColor;
  late ColorValue secondaryColor;
  late ColorValue tertiaryColor;
  late ColorValue primaryColorBackground;
  late ColorValue secondaryColorBackground;
  late ColorValue tertiaryColorBackground;
  // Text Colors
  late ColorValue primaryTextColor;
  late ColorValue secondaryTextColor;
  late ColorValue tertiaryTextColor;
  late ColorValue quaternaryTextColor;
  late ColorValue quinaryTextColor;
  //color palette for scaffold elements
  late ColorValue appBarBackgroundColor;
  late ColorValue bodyBackgroundColor;
  late ColorValue fabBackgroundColor;
  late ColorValue fabIconColor;
  late ColorValue btmAppBarBackgroundColor;
  // color palette for text fields
  late ColorValue inputFillColor;
  late ColorValue inputBorderColor;
  late ColorValue inputTextColor;
  late ColorValue inputLabelColor;
  late ColorValue inputHintColor;

  ColorPalette(
      {required this.name,
      required this.primaryColor,
      required this.secondaryColor,
      required this.tertiaryColor,
      required this.primaryColorBackground,
      required this.secondaryColorBackground,
      required this.tertiaryColorBackground,
      required this.primaryTextColor,
      required this.secondaryTextColor,
      required this.tertiaryTextColor,
      required this.appBarBackgroundColor,
      required this.fabBackgroundColor,
      required this.fabIconColor,
      required this.btmAppBarBackgroundColor,
      required this.inputFillColor,
      required this.inputBorderColor,
      required this.inputTextColor,
      required this.inputLabelColor,
      required this.inputHintColor,
      required this.quaternaryTextColor,
      required this.quinaryTextColor,
      required this.bodyBackgroundColor});
  ColorPalette copyWith({
    String? name,
    ColorValue? primaryColor,
    ColorValue? secondaryColor,
    ColorValue? tertiaryColor,
    ColorValue? primaryColorBackground,
    ColorValue? secondaryColorBackground,
    ColorValue? tertiaryColorBackground,
    ColorValue? primaryTextColor,
    ColorValue? secondaryTextColor,
    ColorValue? tertiaryTextColor,
    ColorValue? appBarBackgroundColor,
    ColorValue? fabBackgroundColor,
    ColorValue? fabIconColor,
    ColorValue? btmAppBarBackgroundColor,
    ColorValue? inputFillColor,
    ColorValue? inputBorderColor,
    ColorValue? inputTextColor,
    ColorValue? inputLabelColor,
    ColorValue? inputHintColor,
    ColorValue? quaternaryTextColor,
    ColorValue? quinaryTextColor,
    ColorValue? bodyBackgroundColor,
  }) {
    return ColorPalette(
      name: name ?? this.name,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      tertiaryColor: tertiaryColor ?? this.tertiaryColor,
      primaryColorBackground:
          primaryColorBackground ?? this.primaryColorBackground,
      secondaryColorBackground:
          secondaryColorBackground ?? this.secondaryColorBackground,
      tertiaryColorBackground:
          tertiaryColorBackground ?? this.tertiaryColorBackground,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      tertiaryTextColor: tertiaryTextColor ?? this.tertiaryTextColor,
      appBarBackgroundColor:
          appBarBackgroundColor ?? this.appBarBackgroundColor,
      fabBackgroundColor: fabBackgroundColor ?? this.fabBackgroundColor,
      fabIconColor: fabIconColor ?? this.fabIconColor,
      btmAppBarBackgroundColor:
          btmAppBarBackgroundColor ?? this.btmAppBarBackgroundColor,
      inputFillColor: inputFillColor ?? this.inputFillColor,
      inputBorderColor: inputBorderColor ?? this.inputBorderColor,
      inputTextColor: inputTextColor ?? this.inputTextColor,
      inputLabelColor: inputLabelColor ?? this.inputLabelColor,
      inputHintColor: inputHintColor ?? this.inputHintColor,
      quaternaryTextColor: quaternaryTextColor ?? this.quaternaryTextColor,
      quinaryTextColor: quinaryTextColor ?? this.quinaryTextColor,
      bodyBackgroundColor: bodyBackgroundColor ?? this.bodyBackgroundColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorPalette &&
        other.name == name &&
        other.primaryColor == primaryColor &&
        other.secondaryColor == secondaryColor &&
        other.tertiaryColor == tertiaryColor &&
        other.primaryColorBackground == primaryColorBackground &&
        other.secondaryColorBackground == secondaryColorBackground &&
        other.tertiaryColorBackground == tertiaryColorBackground &&
        other.primaryTextColor == primaryTextColor &&
        other.secondaryTextColor == secondaryTextColor &&
        other.tertiaryTextColor == tertiaryTextColor &&
        other.appBarBackgroundColor == appBarBackgroundColor &&
        other.fabBackgroundColor == fabBackgroundColor &&
        other.fabIconColor == fabIconColor &&
        other.btmAppBarBackgroundColor == btmAppBarBackgroundColor &&
        other.inputFillColor == inputFillColor &&
        other.inputBorderColor == inputBorderColor &&
        other.inputTextColor == inputTextColor &&
        other.inputLabelColor == inputLabelColor &&
        other.inputHintColor == inputHintColor &&
        other.quinaryTextColor == quinaryTextColor;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        primaryColor.hashCode ^
        secondaryColor.hashCode ^
        tertiaryColor.hashCode ^
        primaryColorBackground.hashCode ^
        secondaryColorBackground.hashCode ^
        tertiaryColorBackground.hashCode ^
        primaryTextColor.hashCode ^
        secondaryTextColor.hashCode ^
        tertiaryTextColor.hashCode ^
        appBarBackgroundColor.hashCode ^
        fabBackgroundColor.hashCode ^
        fabIconColor.hashCode ^
        btmAppBarBackgroundColor.hashCode ^
        inputFillColor.hashCode ^
        inputBorderColor.hashCode ^
        inputTextColor.hashCode ^
        inputLabelColor.hashCode ^
        inputHintColor.hashCode;
  }

  @override
  String toString() {
    return 'ColorPalette(name: $name, primaryColor: $primaryColor, secondaryColor: $secondaryColor, tertiaryColor: $tertiaryColor, primaryColorBackground: $primaryColorBackground, secondaryColorBackground: $secondaryColorBackground, tertiaryColorBackground: $tertiaryColorBackground, primaryColorBackgroundText: $primaryTextColor, secondaryColorBackgroundText: $secondaryTextColor, tertiaryColorBackgroundText: $tertiaryTextColor)';
  }
}
