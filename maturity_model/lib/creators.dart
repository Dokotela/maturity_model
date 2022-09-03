import 'package:creator/creator.dart';

final nameCreator = Creator.value('');

final dateCreator = Creator.value(DateTime.now());

final locationCreator = Creator.value('');

final organizationCreator = Creator.value('');

final additionalInformationCreator = Creator.value('');

final groupCreator = Creator.arg1<int, String>((ref, name) {
  var sum = 0;
  final numberOfItems = ref.watch(numberItemsCreator(name));
  for (var i = 0; i < numberOfItems; i++) {
    sum += ref.watch(itemCreator('$name/$i'));
  }
  return sum;
}, keepAlive: true);

final itemCreator =
    Creator.arg1<int, String>((ref, itemId) => 0, keepAlive: true);

final numberItemsCreator =
    Creator.arg1<int, String>((ref, itemId) => 0, keepAlive: true);
