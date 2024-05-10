import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:momease/src/features/journal/domain/entities/journal_entity.dart';

class NewJournalPage extends StatefulWidget {
  const NewJournalPage({super.key});

  @override
  State<NewJournalPage> createState() => _NewJournalPageState();
}

class _NewJournalPageState extends State<NewJournalPage> {
  bool isTitleFilled = false;
  bool isMoodFilled = false;
  String todayTitle = '';
  late final DateTime todayDate;
  MoodType todayMood = MoodType.Normal;
  String todayJournalText = '';
  bool isFirstJournalTextFilled = false;
  dynamic _responseModel;
  String responseText = '';
  bool isModelResponsed = false;

  @override
  void initState() {
    super.initState();
    todayDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Journal'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Created On:',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                          Text(
                            DateFormat.yMMMd().format(todayDate),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const Text('Title:',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                          !isTitleFilled
                              ? TextButton.icon(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Add Title'),
                                            content: TextField(
                                              onChanged: (String value) {
                                                setState(() {
                                                  todayTitle = value;
                                                });
                                              },
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (todayTitle != '') {
                                                      isTitleFilled = true;
                                                    }
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Save'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: const Text('Add Title',
                                      style: TextStyle(fontSize: 10)))
                              : Text(
                                  todayTitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text('Your Mood',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            iconSize: 36,
                            onPressed: () {
                              // setState(() => showDialog(
                              //   barrierDismissible: false,
                              //   context: context,
                              //  builder: (BuildContext context) => SimpleDialogOption(
                              //     onPressed: () {
                              //       setState(() {
                              //         if (currency != null) {
                              //           setCurrency = currency;
                              //         } else if (type != null) {
                              //           setType = type;
                              //         }
                              //       });
                              //       Navigator.of(context).pop();
                              //     },
                              //     child: Text(.name
                              //           : tariffTypeName[type]!,
                              //       style: const TextStyle(
                              //         color: secondaryTextColor,
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 14,
                              //       ),
                              //     ),
                              //   );
                              // ));
                            },
                            isSelected: isMoodFilled,
                            selectedIcon: todayMood.name == 'Amazing'
                                ? const Icon(Icons.sentiment_very_satisfied)
                                : todayMood.name == 'Good'
                                    ? const Icon(Icons.sentiment_very_satisfied)
                                    : todayMood.name == 'Normal'
                                        ? const Icon(Icons.sentiment_neutral)
                                        : todayMood.name == 'Bad'
                                            ? const Icon(
                                                Icons.sentiment_dissatisfied)
                                            : const Icon(Icons
                                                .sentiment_very_dissatisfied),
                          ),
                          isMoodFilled
                              ? const SizedBox()
                              : const Text('Change',
                                  style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Tell me about your day!',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: !isTitleFilled
                          ? const Text('Add Title to start writing')
                          : isFirstJournalTextFilled
                              ? Text(todayJournalText)
                              : TextField(
                                  onChanged: (String value) {
                                    setState(() {
                                      todayJournalText += value;
                                    });
                                  },
                                  maxLines: 10,
                                  decoration: const InputDecoration(
                                    hintText: 'Write your thoughts here',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                    ),
                    isModelResponsed
                        ? Text(responseText)
                        : TextButton(
                            onPressed: () => responseFunc(todayJournalText),
                            child: const Text('Save')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  responseFunc(String text) async {
    final response =
        await http.post(Uri.parse('https://api.openai.com/v1/completions'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${dotenv.env['token']}'
            },
            body: jsonEncode({
              "model": "text-davinci-003",
              "prompt":
                  "Context: Kamu adalah seorang psikolog yang memiliki spesialisasi di bidang ibu dan anak. \n Task: Tugas kamu adalah menulis respon terhadap seorang ibu yang sedang menulis jurnal terkait hidupnya atau anaknya. Respon yang kamu tulis harus memuat 2 kalimat, yaitu 1 kalimat untuk memahami perasaan penulis dan 1 kalimat tambahan untuk memberikan semangat dan membuat harinya penulis menjadi lebih baik. \n Instruction: Berikan respon kamu dalam 2 kalimat tersebut terhadap diary jurnal yang ditulis berikut '''$text'''",
            }));

    setState(() {
      _responseModel = jsonDecode(response.body);
      responseText = _responseModel.choices[0]['text'];
      isModelResponsed = true;
    });
  }
}

// class ResponseModel {
//   final String response;
//   final List<dynamic> choices;

//   ResponseModel({required this.response, required this.choices});

//   factory ResponseModel.fromJson(Map<String, dynamic> json) {
//     return ResponseModel(
//       response: json['response'],
//       choices: json['choices'],
//     );
//   }
// }
