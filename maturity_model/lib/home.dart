import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:maturity_model/content/content.dart';
import 'package:maturity_model/providers.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _focusNode = FocusNode();

    // Request focus after building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final currentOffset = _scrollController.offset;
    const smallScroll = 100.0;
    final largeScroll = MediaQuery.of(context).size.height * 0.8;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowDown:
        _scrollController.jumpTo(
          (currentOffset + smallScroll).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
        );
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowUp:
        _scrollController.jumpTo(
          (currentOffset - smallScroll).clamp(0.0, double.infinity),
        );
        return KeyEventResult.handled;
      case LogicalKeyboardKey.pageDown:
        _scrollController.jumpTo(
          (currentOffset + largeScroll).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
        );
        return KeyEventResult.handled;
      case LogicalKeyboardKey.pageUp:
        _scrollController.jumpTo(
          (currentOffset - largeScroll).clamp(0.0, double.infinity),
        );
        return KeyEventResult.handled;
      case LogicalKeyboardKey.home:
        _scrollController.jumpTo(0);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.end:
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        return KeyEventResult.handled;
      default:
        return KeyEventResult.ignored;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget editInfo(StateProvider<String> provider, String hintText) =>
        TextFormField(
          initialValue: ref.read(provider),
          decoration: InputDecoration(
              hintText: hintText, border: const OutlineInputBorder()),
          onChanged: (value) => ref.read(provider.notifier).state = value,
        );

    final level = ref.watch(mmLevelProvider);

    return Scaffold(
      body: Focus(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Pane (Logo)
                  SizedBox(
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset('assets/chop_logo.jpeg'),
                    ),
                  ),

                  // Right Pane (Main Content)
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome to the Information Systems for Health (IS4H) Maturity Assessment',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Gap(32),

                            // Level Selection Radio Buttons
                            const Text("Select Assessment Level:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            const Gap(8),
                            Row(
                              children: [
                                Flexible(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('Institutional'),
                                    leading: Radio<MmLevel>(
                                      value: MmLevel.institutional,
                                      groupValue: level,
                                      onChanged: (v) => ref
                                          .read(mmLevelProvider.notifier)
                                          .state = v!,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('Country'),
                                    leading: Radio<MmLevel>(
                                      value: MmLevel.country,
                                      groupValue: level,
                                      onChanged: (v) => ref
                                          .read(mmLevelProvider.notifier)
                                          .state = v!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(32),

                            // Instructions Section
                            const Text(
                              'Instructions for Using the IS4H Maturity Assessment Tool',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const Gap(16),
                            const Text(
                                '1. Fill in the Organizational Information Below',
                                style: TextStyle(fontSize: 16)),
                            const Gap(10),
                            const Text(
                              '2. Respond to each question for each of the 4 categories by selecting the number that best describes your organization at present from the "Select Ranking" column.',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Gap(10),
                            const Text(
                                '3. Review results in the Organizational Results tab',
                                style: TextStyle(fontSize: 16)),
                            const Gap(32),

                            // Information Entry Section
                            const Text("Organizational Information:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            const Gap(16),
                            editInfo(nameProvider, 'Name(s)'),
                            const Gap(12),
                            TextFormField(
                              controller: TextEditingController(
                                  text: ref
                                      .watch(dateProvider)
                                      .toIso8601String()
                                      .substring(0, 10)),
                              decoration: const InputDecoration(
                                  hintText: 'Date',
                                  border: OutlineInputBorder()),
                              readOnly: true,
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: ref.read(dateProvider),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                );
                                if (picked != null) {
                                  ref.read(dateProvider.notifier).state =
                                      picked;
                                }
                              },
                            ),
                            const Gap(12),
                            editInfo(locationProvider, 'Location'),
                            const Gap(12),
                            editInfo(organizationProvider, 'Organization'),
                            const Gap(12),
                            editInfo(additionalInformationProvider,
                                'Additional Information'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
