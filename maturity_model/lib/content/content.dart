import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@freezed
class Content with _$Content {
  factory Content({
    @Default(<Domain>[]) List<Domain> domains,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}

@freezed
class Domain with _$Domain {
  factory Domain({
    required String title,
    @Default(<Group>[]) List<Group> groups,
  }) = _Domain;

  factory Domain.fromJson(Map<String, dynamic> json) => _$DomainFromJson(json);
}

@freezed
class Group with _$Group {
  factory Group({
    required String title,
    required String subTitle,
    required String level1,
    required String level2,
    required String level3,
    required String level4,
    required String level5,
    @Default(<Item>[]) List<Item> items,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}

@freezed
class Item with _$Item {
  factory Item.subGroup({
    required String text,
    @Default(<Question>[]) List<Question> questions,
  }) = Subgroup;

  factory Item.question({
    required String text,
    required String level1,
    required String level2,
    required String level3,
    required String level4,
    required String level5,
  }) = Question;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
