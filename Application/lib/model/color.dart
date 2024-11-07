class Color {
  int? colorId;
  String? colorName;

  Color({
    this.colorId,
    this.colorName,
  });

  Color.fromJson(Map<String, dynamic> json) {
    colorId = json['colorId'];
    colorName = json['colorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['colorId'] = colorId;
    data['colorName'] = colorName;
    return data;
  }
}

class ColorList {
  List<Color>? colorList;

  ColorList({
    this.colorList,
  });

  ColorList.fromJson(List<dynamic> json) {
    colorList = json.map((e) => Color.fromJson(e)).toList();
  }

  List<dynamic> toJson() {
    final List<dynamic> result = [];
    for (var e in colorList!) {
      result.add(e);
    }
    return result;
  }
}
