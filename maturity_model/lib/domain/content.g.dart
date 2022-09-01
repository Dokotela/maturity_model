// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Content _$$_ContentFromJson(Map<String, dynamic> json) => _$_Content(
      domains: json['domains'] ?? const <Domain>[],
    );

Map<String, dynamic> _$$_ContentToJson(_$_Content instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('domains', instance.domains);
  return val;
}

_$_Domain _$$_DomainFromJson(Map<String, dynamic> json) => _$_Domain(
      title: json['title'] as String,
      groups: (json['groups'] as List<dynamic>?)
              ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Group>[],
    );

Map<String, dynamic> _$$_DomainToJson(_$_Domain instance) => <String, dynamic>{
      'title': instance.title,
      'groups': instance.groups.map((e) => e.toJson()).toList(),
    };

_$_Group _$$_GroupFromJson(Map<String, dynamic> json) => _$_Group(
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
          const <Item>[],
    );

Map<String, dynamic> _$$_GroupToJson(_$_Group instance) => <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'level1': instance.level1,
      'level2': instance.level2,
      'level3': instance.level3,
      'level4': instance.level4,
      'level5': instance.level5,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

_$Subgroup _$$SubgroupFromJson(Map<String, dynamic> json) => _$Subgroup(
      text: json['text'] as String,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Question>[],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SubgroupToJson(_$Subgroup instance) =>
    <String, dynamic>{
      'text': instance.text,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

_$Question _$$QuestionFromJson(Map<String, dynamic> json) => _$Question(
      text: json['text'] as String,
      level1: json['level1'] as String,
      level2: json['level2'] as String,
      level3: json['level3'] as String,
      level4: json['level4'] as String,
      level5: json['level5'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuestionToJson(_$Question instance) =>
    <String, dynamic>{
      'text': instance.text,
      'level1': instance.level1,
      'level2': instance.level2,
      'level3': instance.level3,
      'level4': instance.level4,
      'level5': instance.level5,
      'runtimeType': instance.$type,
    };
