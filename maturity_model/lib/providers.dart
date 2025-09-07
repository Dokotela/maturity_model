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

// Optimized family providers with autoDispose to prevent memory leaks
final groupProvider = Provider.family<int, (MmLevel, String)>((ref, params) {
  final (mmLevel, name) = params;

  // Get the number of items first
  final numberOfItems = ref.watch(numberItemsProvider((mmLevel, name)));
  if (numberOfItems == 0) return 0;

  // Only calculate sum for valid items
  var sum = 0;
  for (var i = 0; i < numberOfItems; i++) {
    final itemValue = ref.watch(itemProvider((mmLevel, '$name/$i')));
    sum += itemValue;
  }
  return sum;
});

final itemProvider = StateProvider.family<int, (MmLevel, String)>(
  (ref, params) => 0,
);

final numberItemsProvider = StateProvider.family<int, (MmLevel, String)>(
  (ref, params) => 0,
);
