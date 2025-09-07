// lib/models/content_model.dart

import 'package:collection/collection.dart';

// Enums
enum MmLevel {
  institutional,
  country,
}

// Content class
class Content {
  final MmLevel level;
  final List<Domain> domains;

  const Content({
    required this.level,
    this.domains = const [],
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      level: MmLevel.values.firstWhere(
        (e) => e.name == json['level'],
        orElse: () => MmLevel.institutional,
      ),
      domains: (json['domains'] as List<dynamic>?)
              ?.map((e) => Domain.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level.name,
      'domains': domains.map((e) => e.toJson()).toList(),
    };
  }

  Content copyWith({
    MmLevel? level,
    List<Domain>? domains,
  }) {
    return Content(
      level: level ?? this.level,
      domains: domains ?? this.domains,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Content &&
        other.level == level &&
        const ListEquality().equals(other.domains, domains);
  }

  @override
  int get hashCode => Object.hash(level, const ListEquality().hash(domains));
}

// Domain class
class Domain {
  final String title;
  final List<Group> groups;

  const Domain({
    required this.title,
    this.groups = const [],
  });

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(
      title: json['title'] as String,
      groups: (json['groups'] as List<dynamic>?)
              ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'groups': groups.map((e) => e.toJson()).toList(),
    };
  }

  Domain copyWith({
    String? title,
    List<Group>? groups,
  }) {
    return Domain(
      title: title ?? this.title,
      groups: groups ?? this.groups,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Domain &&
        other.title == title &&
        const ListEquality().equals(other.groups, groups);
  }

  @override
  int get hashCode => Object.hash(title, const ListEquality().hash(groups));
}

// Group class
class Group {
  final String title;
  final String subTitle;
  final String level1;
  final String level2;
  final String level3;
  final String level4;
  final String level5;
  final List<Item> items;

  const Group({
    required this.title,
    required this.subTitle,
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.level5,
    this.items = const [],
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      level1: json['level1'] as String,
      level2: json['level2'] as String,
      level3: json['level3'] as String,
      level4: json['level4'] as String,
      level5: json['level5'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subTitle': subTitle,
      'level1': level1,
      'level2': level2,
      'level3': level3,
      'level4': level4,
      'level5': level5,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  Group copyWith({
    String? title,
    String? subTitle,
    String? level1,
    String? level2,
    String? level3,
    String? level4,
    String? level5,
    List<Item>? items,
  }) {
    return Group(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      level1: level1 ?? this.level1,
      level2: level2 ?? this.level2,
      level3: level3 ?? this.level3,
      level4: level4 ?? this.level4,
      level5: level5 ?? this.level5,
      items: items ?? this.items,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Group &&
        other.title == title &&
        other.subTitle == subTitle &&
        other.level1 == level1 &&
        other.level2 == level2 &&
        other.level3 == level3 &&
        other.level4 == level4 &&
        other.level5 == level5 &&
        const ListEquality().equals(other.items, items);
  }

  @override
  int get hashCode => Object.hash(
        title,
        subTitle,
        level1,
        level2,
        level3,
        level4,
        level5,
        const ListEquality().hash(items),
      );
}

// Item abstract class
abstract class Item {
  String get text;

  const Item();

  factory Item.fromJson(Map<String, dynamic> json) {
    final type = json['runtimeType'] as String?;

    switch (type) {
      case 'subGroup':
        return Subgroup.fromJson(json);
      case 'question':
        return Question.fromJson(json);
      default:
        // Try to determine type based on presence of fields
        if (json.containsKey('questions')) {
          return Subgroup.fromJson(json);
        } else if (json.containsKey('level1')) {
          return Question.fromJson(json);
        }
        throw ArgumentError('Invalid Item type in JSON: $json');
    }
  }

  Map<String, dynamic> toJson();
}

// Subgroup class
class Subgroup extends Item {
  @override
  final String text;
  final List<Question> questions;

  const Subgroup({
    required this.text,
    this.questions = const [],
  });

  factory Subgroup.fromJson(Map<String, dynamic> json) {
    return Subgroup(
      text: json['text'] as String,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'questions': questions.map((e) => e.toJson()).toList(),
      'runtimeType': 'subGroup',
    };
  }

  Subgroup copyWith({
    String? text,
    List<Question>? questions,
  }) {
    return Subgroup(
      text: text ?? this.text,
      questions: questions ?? this.questions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Subgroup &&
        other.text == text &&
        const ListEquality().equals(other.questions, questions);
  }

  @override
  int get hashCode => Object.hash(text, const ListEquality().hash(questions));
}

// Question class
class Question extends Item {
  @override
  final String text;
  final String level1;
  final String level2;
  final String level3;
  final String level4;
  final String level5;

  const Question({
    required this.text,
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.level5,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      level1: json['level1'] as String,
      level2: json['level2'] as String,
      level3: json['level3'] as String,
      level4: json['level4'] as String,
      level5: json['level5'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'level1': level1,
      'level2': level2,
      'level3': level3,
      'level4': level4,
      'level5': level5,
      'runtimeType': 'question',
    };
  }

  Question copyWith({
    String? text,
    String? level1,
    String? level2,
    String? level3,
    String? level4,
    String? level5,
  }) {
    return Question(
      text: text ?? this.text,
      level1: level1 ?? this.level1,
      level2: level2 ?? this.level2,
      level3: level3 ?? this.level3,
      level4: level4 ?? this.level4,
      level5: level5 ?? this.level5,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Question &&
        other.text == text &&
        other.level1 == level1 &&
        other.level2 == level2 &&
        other.level3 == level3 &&
        other.level4 == level4 &&
        other.level5 == level5;
  }

  @override
  int get hashCode => Object.hash(text, level1, level2, level3, level4, level5);
}
