class Condition {
  final String text;
  String icon;

  Condition({required this.text, required this.icon});

  factory Condition.fromJson(Map<String, dynamic> json) {
    var iconUrl = json['icon'] as String;
    if (iconUrl.startsWith('https:https:')) {
      iconUrl = iconUrl.replaceFirst('https:https:', 'https:');
    } else if (!iconUrl.startsWith('https:')) {
      iconUrl = 'https:$iconUrl';
    }

    return Condition(
      text: json['text'],
      icon: iconUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
    };
  }
}
