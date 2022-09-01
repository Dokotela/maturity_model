// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Content _$ContentFromJson(Map<String, dynamic> json) {
  return _Content.fromJson(json);
}

/// @nodoc
mixin _$Content {
  dynamic get domains => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContentCopyWith<Content> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentCopyWith<$Res> {
  factory $ContentCopyWith(Content value, $Res Function(Content) then) =
      _$ContentCopyWithImpl<$Res>;
  $Res call({dynamic domains});
}

/// @nodoc
class _$ContentCopyWithImpl<$Res> implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._value, this._then);

  final Content _value;
  // ignore: unused_field
  final $Res Function(Content) _then;

  @override
  $Res call({
    Object? domains = freezed,
  }) {
    return _then(_value.copyWith(
      domains: domains == freezed
          ? _value.domains
          : domains // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_ContentCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory _$$_ContentCopyWith(
          _$_Content value, $Res Function(_$_Content) then) =
      __$$_ContentCopyWithImpl<$Res>;
  @override
  $Res call({dynamic domains});
}

/// @nodoc
class __$$_ContentCopyWithImpl<$Res> extends _$ContentCopyWithImpl<$Res>
    implements _$$_ContentCopyWith<$Res> {
  __$$_ContentCopyWithImpl(_$_Content _value, $Res Function(_$_Content) _then)
      : super(_value, (v) => _then(v as _$_Content));

  @override
  _$_Content get _value => super._value as _$_Content;

  @override
  $Res call({
    Object? domains = freezed,
  }) {
    return _then(_$_Content(
      domains: domains == freezed ? _value.domains : domains,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Content implements _Content {
  _$_Content({this.domains = const <Domain>[]});

  factory _$_Content.fromJson(Map<String, dynamic> json) =>
      _$$_ContentFromJson(json);

  @override
  @JsonKey()
  final dynamic domains;

  @override
  String toString() {
    return 'Content(domains: $domains)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Content &&
            const DeepCollectionEquality().equals(other.domains, domains));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(domains));

  @JsonKey(ignore: true)
  @override
  _$$_ContentCopyWith<_$_Content> get copyWith =>
      __$$_ContentCopyWithImpl<_$_Content>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ContentToJson(
      this,
    );
  }
}

abstract class _Content implements Content {
  factory _Content({final dynamic domains}) = _$_Content;

  factory _Content.fromJson(Map<String, dynamic> json) = _$_Content.fromJson;

  @override
  dynamic get domains;
  @override
  @JsonKey(ignore: true)
  _$$_ContentCopyWith<_$_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

Domain _$DomainFromJson(Map<String, dynamic> json) {
  return _Domain.fromJson(json);
}

/// @nodoc
mixin _$Domain {
  String get title => throw _privateConstructorUsedError;
  List<Group> get groups => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DomainCopyWith<Domain> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DomainCopyWith<$Res> {
  factory $DomainCopyWith(Domain value, $Res Function(Domain) then) =
      _$DomainCopyWithImpl<$Res>;
  $Res call({String title, List<Group> groups});
}

/// @nodoc
class _$DomainCopyWithImpl<$Res> implements $DomainCopyWith<$Res> {
  _$DomainCopyWithImpl(this._value, this._then);

  final Domain _value;
  // ignore: unused_field
  final $Res Function(Domain) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? groups = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<Group>,
    ));
  }
}

/// @nodoc
abstract class _$$_DomainCopyWith<$Res> implements $DomainCopyWith<$Res> {
  factory _$$_DomainCopyWith(_$_Domain value, $Res Function(_$_Domain) then) =
      __$$_DomainCopyWithImpl<$Res>;
  @override
  $Res call({String title, List<Group> groups});
}

/// @nodoc
class __$$_DomainCopyWithImpl<$Res> extends _$DomainCopyWithImpl<$Res>
    implements _$$_DomainCopyWith<$Res> {
  __$$_DomainCopyWithImpl(_$_Domain _value, $Res Function(_$_Domain) _then)
      : super(_value, (v) => _then(v as _$_Domain));

  @override
  _$_Domain get _value => super._value as _$_Domain;

  @override
  $Res call({
    Object? title = freezed,
    Object? groups = freezed,
  }) {
    return _then(_$_Domain(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      groups: groups == freezed
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<Group>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Domain implements _Domain {
  _$_Domain({required this.title, final List<Group> groups = const <Group>[]})
      : _groups = groups;

  factory _$_Domain.fromJson(Map<String, dynamic> json) =>
      _$$_DomainFromJson(json);

  @override
  final String title;
  final List<Group> _groups;
  @override
  @JsonKey()
  List<Group> get groups {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  String toString() {
    return 'Domain(title: $title, groups: $groups)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Domain &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(_groups));

  @JsonKey(ignore: true)
  @override
  _$$_DomainCopyWith<_$_Domain> get copyWith =>
      __$$_DomainCopyWithImpl<_$_Domain>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DomainToJson(
      this,
    );
  }
}

abstract class _Domain implements Domain {
  factory _Domain({required final String title, final List<Group> groups}) =
      _$_Domain;

  factory _Domain.fromJson(Map<String, dynamic> json) = _$_Domain.fromJson;

  @override
  String get title;
  @override
  List<Group> get groups;
  @override
  @JsonKey(ignore: true)
  _$$_DomainCopyWith<_$_Domain> get copyWith =>
      throw _privateConstructorUsedError;
}

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  String get title => throw _privateConstructorUsedError;
  String get subTitle => throw _privateConstructorUsedError;
  String get level1 => throw _privateConstructorUsedError;
  String get level2 => throw _privateConstructorUsedError;
  String get level3 => throw _privateConstructorUsedError;
  String get level4 => throw _privateConstructorUsedError;
  String get level5 => throw _privateConstructorUsedError;
  List<Item> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String subTitle,
      String level1,
      String level2,
      String level3,
      String level4,
      String level5,
      List<Item> items});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res> implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  final Group _value;
  // ignore: unused_field
  final $Res Function(Group) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? subTitle = freezed,
    Object? level1 = freezed,
    Object? level2 = freezed,
    Object? level3 = freezed,
    Object? level4 = freezed,
    Object? level5 = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: subTitle == freezed
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      level1: level1 == freezed
          ? _value.level1
          : level1 // ignore: cast_nullable_to_non_nullable
              as String,
      level2: level2 == freezed
          ? _value.level2
          : level2 // ignore: cast_nullable_to_non_nullable
              as String,
      level3: level3 == freezed
          ? _value.level3
          : level3 // ignore: cast_nullable_to_non_nullable
              as String,
      level4: level4 == freezed
          ? _value.level4
          : level4 // ignore: cast_nullable_to_non_nullable
              as String,
      level5: level5 == freezed
          ? _value.level5
          : level5 // ignore: cast_nullable_to_non_nullable
              as String,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

/// @nodoc
abstract class _$$_GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$_GroupCopyWith(_$_Group value, $Res Function(_$_Group) then) =
      __$$_GroupCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String subTitle,
      String level1,
      String level2,
      String level3,
      String level4,
      String level5,
      List<Item> items});
}

/// @nodoc
class __$$_GroupCopyWithImpl<$Res> extends _$GroupCopyWithImpl<$Res>
    implements _$$_GroupCopyWith<$Res> {
  __$$_GroupCopyWithImpl(_$_Group _value, $Res Function(_$_Group) _then)
      : super(_value, (v) => _then(v as _$_Group));

  @override
  _$_Group get _value => super._value as _$_Group;

  @override
  $Res call({
    Object? title = freezed,
    Object? subTitle = freezed,
    Object? level1 = freezed,
    Object? level2 = freezed,
    Object? level3 = freezed,
    Object? level4 = freezed,
    Object? level5 = freezed,
    Object? items = freezed,
  }) {
    return _then(_$_Group(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: subTitle == freezed
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      level1: level1 == freezed
          ? _value.level1
          : level1 // ignore: cast_nullable_to_non_nullable
              as String,
      level2: level2 == freezed
          ? _value.level2
          : level2 // ignore: cast_nullable_to_non_nullable
              as String,
      level3: level3 == freezed
          ? _value.level3
          : level3 // ignore: cast_nullable_to_non_nullable
              as String,
      level4: level4 == freezed
          ? _value.level4
          : level4 // ignore: cast_nullable_to_non_nullable
              as String,
      level5: level5 == freezed
          ? _value.level5
          : level5 // ignore: cast_nullable_to_non_nullable
              as String,
      items: items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Group implements _Group {
  _$_Group(
      {required this.title,
      required this.subTitle,
      required this.level1,
      required this.level2,
      required this.level3,
      required this.level4,
      required this.level5,
      final List<Item> items = const <Item>[]})
      : _items = items;

  factory _$_Group.fromJson(Map<String, dynamic> json) =>
      _$$_GroupFromJson(json);

  @override
  final String title;
  @override
  final String subTitle;
  @override
  final String level1;
  @override
  final String level2;
  @override
  final String level3;
  @override
  final String level4;
  @override
  final String level5;
  final List<Item> _items;
  @override
  @JsonKey()
  List<Item> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'Group(title: $title, subTitle: $subTitle, level1: $level1, level2: $level2, level3: $level3, level4: $level4, level5: $level5, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Group &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.subTitle, subTitle) &&
            const DeepCollectionEquality().equals(other.level1, level1) &&
            const DeepCollectionEquality().equals(other.level2, level2) &&
            const DeepCollectionEquality().equals(other.level3, level3) &&
            const DeepCollectionEquality().equals(other.level4, level4) &&
            const DeepCollectionEquality().equals(other.level5, level5) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(subTitle),
      const DeepCollectionEquality().hash(level1),
      const DeepCollectionEquality().hash(level2),
      const DeepCollectionEquality().hash(level3),
      const DeepCollectionEquality().hash(level4),
      const DeepCollectionEquality().hash(level5),
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      __$$_GroupCopyWithImpl<_$_Group>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupToJson(
      this,
    );
  }
}

abstract class _Group implements Group {
  factory _Group(
      {required final String title,
      required final String subTitle,
      required final String level1,
      required final String level2,
      required final String level3,
      required final String level4,
      required final String level5,
      final List<Item> items}) = _$_Group;

  factory _Group.fromJson(Map<String, dynamic> json) = _$_Group.fromJson;

  @override
  String get title;
  @override
  String get subTitle;
  @override
  String get level1;
  @override
  String get level2;
  @override
  String get level3;
  @override
  String get level4;
  @override
  String get level5;
  @override
  List<Item> get items;
  @override
  @JsonKey(ignore: true)
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      throw _privateConstructorUsedError;
}

Item _$ItemFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'subGroup':
      return Subgroup.fromJson(json);
    case 'question':
      return Question.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Item',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Item {
  String get text => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text, List<Question> questions) subGroup,
    required TResult Function(String text, String level1, String level2,
            String level3, String level4, String level5)
        question,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String text, List<Question> questions)? subGroup,
    TResult Function(String text, String level1, String level2, String level3,
            String level4, String level5)?
        question,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, List<Question> questions)? subGroup,
    TResult Function(String text, String level1, String level2, String level3,
            String level4, String level5)?
        question,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Subgroup value) subGroup,
    required TResult Function(Question value) question,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Subgroup value)? subGroup,
    TResult Function(Question value)? question,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Subgroup value)? subGroup,
    TResult Function(Question value)? question,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res>;
  $Res call({String text});
}

/// @nodoc
class _$ItemCopyWithImpl<$Res> implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  final Item _value;
  // ignore: unused_field
  final $Res Function(Item) _then;

  @override
  $Res call({
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$SubgroupCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$SubgroupCopyWith(
          _$Subgroup value, $Res Function(_$Subgroup) then) =
      __$$SubgroupCopyWithImpl<$Res>;
  @override
  $Res call({String text, List<Question> questions});
}

/// @nodoc
class __$$SubgroupCopyWithImpl<$Res> extends _$ItemCopyWithImpl<$Res>
    implements _$$SubgroupCopyWith<$Res> {
  __$$SubgroupCopyWithImpl(_$Subgroup _value, $Res Function(_$Subgroup) _then)
      : super(_value, (v) => _then(v as _$Subgroup));

  @override
  _$Subgroup get _value => super._value as _$Subgroup;

  @override
  $Res call({
    Object? text = freezed,
    Object? questions = freezed,
  }) {
    return _then(_$Subgroup(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      questions: questions == freezed
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Subgroup implements Subgroup {
  _$Subgroup(
      {required this.text,
      final List<Question> questions = const <Question>[],
      final String? $type})
      : _questions = questions,
        $type = $type ?? 'subGroup';

  factory _$Subgroup.fromJson(Map<String, dynamic> json) =>
      _$$SubgroupFromJson(json);

  @override
  final String text;
  final List<Question> _questions;
  @override
  @JsonKey()
  List<Question> get questions {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Item.subGroup(text: $text, questions: $questions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Subgroup &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(_questions));

  @JsonKey(ignore: true)
  @override
  _$$SubgroupCopyWith<_$Subgroup> get copyWith =>
      __$$SubgroupCopyWithImpl<_$Subgroup>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text, List<Question> questions) subGroup,
    required TResult Function(String text, String level1, String level2,
            String level3, String level4, String level5)
        question,
  }) {
    return subGroup(text, questions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String text, List<Question> questions)? subGroup,
    TResult Function(String text, String level1, String level2, String level3,
            String level4, String level5)?
        question,
  }) {
    return subGroup?.call(text, questions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, List<Question> questions)? subGroup,
    TResult Function(String text, String level1, String level2, String level3,
            String level4, String level5)?
        question,
    required TResult orElse(),
  }) {
    if (subGroup != null) {
      return subGroup(text, questions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Subgroup value) subGroup,
    required TResult Function(Question value) question,
  }) {
    return subGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Subgroup value)? subGroup,
    TResult Function(Question value)? question,
  }) {
    return subGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Subgroup value)? subGroup,
    TResult Function(Question value)? question,
    required TResult orElse(),
  }) {
    if (subGroup != null) {
      return subGroup(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SubgroupToJson(
      this,
    );
  }
}

abstract class Subgroup implements Item {
  factory Subgroup(
      {required final String text,
      final List<Question> questions}) = _$Subgroup;

  factory Subgroup.fromJson(Map<String, dynamic> json) = _$Subgroup.fromJson;

  @override
  String get text;
  List<Question> get questions;
  @override
  @JsonKey(ignore: true)
  _$$SubgroupCopyWith<_$Subgroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuestionCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$QuestionCopyWith(
          _$Question value, $Res Function(_$Question) then) =
      __$$QuestionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String text,
      String level1,
      String level2,
      String level3,
      String level4,
      String level5});
}

/// @nodoc
class __$$QuestionCopyWithImpl<$Res> extends _$ItemCopyWithImpl<$Res>
    implements _$$QuestionCopyWith<$Res> {
  __$$QuestionCopyWithImpl(_$Question _value, $Res Function(_$Question) _then)
      : super(_value, (v) => _then(v as _$Question));

  @override
  _$Question get _value => super._value as _$Question;

  @override
  $Res call({
    Object? text = freezed,
    Object? level1 = freezed,
    Object? level2 = freezed,
    Object? level3 = freezed,
    Object? level4 = freezed,
    Object? level5 = freezed,
  }) {
    return _then(_$Question(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      level1: level1 == freezed
          ? _value.level1
          : level1 // ignore: cast_nullable_to_non_nullable
              as String,
      level2: level2 == freezed
          ? _value.level2
          : level2 // ignore: cast_nullable_to_non_nullable
              as String,
      level3: level3 == freezed
          ? _value.level3
          : level3 // ignore: cast_nullable_to_non_nullable
              as String,
      level4: level4 == freezed
          ? _value.level4
          : level4 // ignore: cast_nullable_to_non_nullable
              as String,
      level5: level5 == freezed
          ? _value.level5
          : level5 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Question implements Question {
  _$Question(
      {required this.text,
      required this.level1,
      required this.level2,
      required this.level3,
      required this.level4,
      required this.level5,
      final String? $type})
      : $type = $type ?? 'question';

  factory _$Question.fromJson(Map<String, dynamic> json) =>
      _$$QuestionFromJson(json);

  @override
  final String text;
  @override
  final String level1;
  @override
  final String level2;
  @override
  final String level3;
  @override
  final String level4;
  @override
  final String level5;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Item.question(text: $text, level1: $level1, level2: $level2, level3: $level3, level4: $level4, level5: $level5)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Question &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.level1, level1) &&
            const DeepCollectionEquality().equals(other.level2, level2) &&
            const DeepCollectionEquality().equals(other.level3, level3) &&
            const DeepCollectionEquality().equals(other.level4, level4) &&
            const DeepCollectionEquality().equals(other.level5, level5));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(level1),
      const DeepCollectionEquality().hash(level2),
      const DeepCollectionEquality().hash(level3),
      const DeepCollectionEquality().hash(level4),
      const DeepCollectionEquality().hash(level5));

  @JsonKey(ignore: true)
  @override
  _$$QuestionCopyWith<_$Question> get copyWith =>
      __$$QuestionCopyWithImpl<_$Question>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text, List<Question> questions) subGroup,
    required TResult Function(String text, String level1, String level2,
            String level3, String level4, String level5)
        question,
  }) {
    return question(text, level1, level2, level3, level4, level5);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String text, List<Question> questions)? subGroup,
    TResult Function(String text, String level1, String level2, String level3,
            String level4, String level5)?
        question,
  }) {
    return question?.call(text, level1, level2, level3, level4, level5);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, List<Question> questions)? subGroup,
    TResult Function(String text, String level1, String level2, String level3,
            String level4, String level5)?
        question,
    required TResult orElse(),
  }) {
    if (question != null) {
      return question(text, level1, level2, level3, level4, level5);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Subgroup value) subGroup,
    required TResult Function(Question value) question,
  }) {
    return question(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Subgroup value)? subGroup,
    TResult Function(Question value)? question,
  }) {
    return question?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Subgroup value)? subGroup,
    TResult Function(Question value)? question,
    required TResult orElse(),
  }) {
    if (question != null) {
      return question(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionToJson(
      this,
    );
  }
}

abstract class Question implements Item {
  factory Question(
      {required final String text,
      required final String level1,
      required final String level2,
      required final String level3,
      required final String level4,
      required final String level5}) = _$Question;

  factory Question.fromJson(Map<String, dynamic> json) = _$Question.fromJson;

  @override
  String get text;
  String get level1;
  String get level2;
  String get level3;
  String get level4;
  String get level5;
  @override
  @JsonKey(ignore: true)
  _$$QuestionCopyWith<_$Question> get copyWith =>
      throw _privateConstructorUsedError;
}
