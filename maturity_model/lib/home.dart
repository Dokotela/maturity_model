import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maturity_model/content/content.dart';
import 'package:maturity_model/creators.dart';
import 'package:maturity_model/doubles_for_screen_size.dart';

class HomeView extends StatelessWidget {
  const HomeView(this._tabController, {Key? key}) : super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    TextButton linkButton(String text, int value) => TextButton(
          onPressed: () {
            _tabController.index = value;
          },
          child: Text(text, style: const TextStyle(fontSize: 16)),
        );

    Widget contentList = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/chop_logo.jpeg',
          height: doubleByHeight(context, 200),
          width: doubleByWidth(context, 400),
        ),
        const Gap(8),
        linkButton('Home', 0),
        const Gap(8),
        linkButton('Organizational Results', 1),
        const Gap(8),
        linkButton('Data Management and Information Technology', 2),
        const Gap(8),
        linkButton('Management and Governance', 3),
        const Gap(8),
        linkButton('Knowledge Management and Sharing', 4),
        const Gap(8),
        linkButton('Innovation', 5),
        const Gap(8),
        linkButton('Glossary', 6),
      ],
    );

    Widget instructions() => Row(
          children: [
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Instructions for Using the IS4H Maturity Assessment Tool',
                  style: TextStyle(fontSize: 16),
                ),
                const Gap(16),
                Row(
                  children: [
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '1. Fill in the Organizational Information Below',
                          style: TextStyle(fontSize: 16),
                        ),
                        Gap(10),
                        SizedBox(
                          width: 800,
                          child: Text(
                            '2. Respond to each question for each of the 4 categories by selecting the number that best describes your organization at present from the "Select Ranking" column.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Gap(10),
                        Text(
                          '3. Save data when complete',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );

    Widget editInfo(Creator creator, String hintText) => Watcher(
          ((context, ref, child) => SizedBox(
                height: 30,
                width: 700,
                child: TextFormField(
                  initialValue: ref.read(creator) as String,
                  decoration: InputDecoration(hintText: hintText),
                  onChanged: ((value) => ref.update(creator, (p0) => value)),
                ),
              )),
        );

    Widget infoEntry() => Row(
          children: [
            const Gap(16),
            Watcher(
              ((context, ref, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      editInfo(nameCreator, 'Name(s)'),
                      const Gap(12),
                      SizedBox(
                        height: 30,
                        width: 700,
                        child: TextFormField(
                            controller: TextEditingController(
                                text: ref
                                    .watch(dateCreator)
                                    .toIso8601String()
                                    .substring(0, 10)),
                            decoration: const InputDecoration(hintText: 'Date'),
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );
                              ref.update(dateCreator, (p0) => picked);
                            }),
                      ),
                      const Gap(12),
                      editInfo(locationCreator, 'Location'),
                      const Gap(12),
                      editInfo(organizationCreator, 'Organization'),
                      const Gap(12),
                      editInfo(additionalInformationCreator,
                          'Additional Information'),
                    ],
                  )),
            ),
          ],
        );

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: doubleByWidth(context, 400),
            child: contentList,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to the Information Systems for Health (IS4H) Maturity Assessment',
                  style: TextStyle(fontSize: 24),
                ),
                const Gap(32),
                Watcher(
                  ((context, ref, child) {
                    final level = ref.watch(mmLevelCreator);
                    return Column(
                      children: [
                        ListTile(
                          title: const Text('Institutional'),
                          leading: Radio<MmLevel>(
                            value: MmLevel.institutional,
                            groupValue: level,
                            onChanged: (MmLevel? value) {
                              if (value != null) {
                                ref.update(mmLevelCreator, (p0) => value);
                              }
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Country'),
                          leading: Radio<MmLevel>(
                            value: MmLevel.country,
                            groupValue: level,
                            onChanged: (MmLevel? value) {
                              if (value != null) {
                                ref.update(mmLevelCreator, (p0) => value);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const Gap(32),
                instructions(),
                const Gap(32),
                Row(
                  children: [
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoEntry(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
