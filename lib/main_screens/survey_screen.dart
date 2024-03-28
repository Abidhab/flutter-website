import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class SurveyPage extends StatefulWidget {
  final String projectName;
  final String clientName;
  final String eventName;

  SurveyPage({
    required this.projectName,
    required this.clientName,
    required this.eventName,
  });

  @override
  SurveyPageState createState() => SurveyPageState();
}

class SurveyPageState extends State<SurveyPage> {
  late String surveyId;
  Map<String, String?> answers = {};

  @override
  void initState() {
    super.initState();
    surveyId = Uuid().v4();
  }

  String generateSurveyLink() {
    return 'https://example.com/survey?id=$surveyId';
  }

  bool validate() {
    // Check if all questions are answered
    return answers.length == 5; // Assuming 5 questions in the survey
  }

  void submitSurvey() async {
    try {
      if (!validate()) {
        // Show error dialog
        return;
      }

      final surveyData = {
        'surveyId' : surveyId,
        'projectName': widget.projectName,
        'clientName': widget.clientName,
        'eventName': widget.eventName,
        ...answers,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection('surveys').doc(surveyId).set(surveyData);

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Survey Submitted'),
            content: Text('Thank you for completing the survey.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      setState(() {
        answers.clear();
      });
    } catch (e) {
      print('Error submitting survey: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while submitting the survey.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Survey link copied to clipboard')),
    );
  }

  Widget _buildSingleChoiceQuestion(
      String question, List<String> options, String questionId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        Column(
          children: options.map((option) {
            return RadioListTile(
              title: Text(option),
              value: option,
              groupValue: answers[questionId],
              onChanged: (value) {
                setState(() {
                  answers[questionId] = value.toString();
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOpenEndedQuestion(String question, String questionId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        TextField(
          onChanged: (value) {
            setState(() {
              answers[questionId] = value;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Project Name: ${widget.projectName}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'Client Name: ${widget.clientName}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'Event Name: ${widget.eventName}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildSingleChoiceQuestion(
                  'How satisfied are you with the overall outcome of the project? Did we meet your expectations in terms of quality and deliverables?',
                  [
                    'Very satisfied',
                    'Satisfied',
                    'Neutral',
                    'Dissatisfied',
                    'Very dissatisfied',
                  ],
                  'q1',
                ),
                _buildSingleChoiceQuestion(
                  'How would you rate our communication throughout the project?',
                  [
                    'Excellent',
                    'Good',
                    'Average',
                    'Poor',
                    'Very poor',
                  ],
                  'q2',
                ),
                _buildSingleChoiceQuestion(
                  'Were you satisfied with the level of support on & off-site and guidance provided during the project?',
                  [
                    'Very effectively',
                    'Effectively',
                    'Moderately effectively',
                    'Ineffectively',
                    'Very ineffectively',
                  ],
                  'q3',
                ),
                _buildSingleChoiceQuestion(
                  'How likely are you to recommend our services to others based on your experience with this project?',
                  [
                    'Very likely',
                    'Likely',
                    'Neutral',
                    'Unlikely',
                    'Very unlikely',
                  ],
                  'q4',
                ),
                _buildOpenEndedQuestion(
                  'Is there any additional feedback or suggestions you would like to provide to help us improve our services in the future?',
                  'q5',
                ),
                ElevatedButton(
                  onPressed: () {
                    String surveyLink = generateSurveyLink();
                    copyToClipboard(surveyLink);
                    // Send surveyLink to the person
                  },
                  child: Text('Generate Survey Link'),
                ),
                ElevatedButton(
                  onPressed: submitSurvey,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
