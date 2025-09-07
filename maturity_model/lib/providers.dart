import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'content/content.dart';
import 'content/country_content.dart';
import 'content/institutional_content.dart';

// Simple state providers for basic values
final mmLevelProvider = StateProvider<MmLevel>((ref) => MmLevel.institutional);

final countryContentProvider = Provider<Content>((ref) => countryContent);

final institutionalContentProvider =
    Provider<Content>((ref) => institutionalContent);

final nameProvider = StateProvider<String>((ref) => '');

final dateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final locationProvider = StateProvider<String>((ref) => '');

final organizationProvider = StateProvider<String>((ref) => '');

final additionalInformationProvider = StateProvider<String>((ref) => '');

// Family providers for parameterized state
final groupProvider = Provider.family<int, (MmLevel, String)>((ref, params) {
  final (mmLevel, name) = params;
  var sum = 0;
  final numberOfItems = ref.watch(numberItemsProvider((mmLevel, name)));
  for (var i = 0; i < numberOfItems; i++) {
    sum += ref.watch(itemProvider((mmLevel, '$name/$i')));
  }
  return sum;
});

final itemProvider = StateProvider.family<int, (MmLevel, String)>(
  (ref, params) => 0,
);

final numberItemsProvider = StateProvider.family<int, (MmLevel, String)>(
  (ref, params) => 0,
);
