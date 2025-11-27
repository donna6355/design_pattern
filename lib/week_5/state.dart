import 'package:flutter/material.dart';

abstract class DocumentState {
  void publish(Document context);
  void reject(Document context);
  String get name;
}

class Document {
  DocumentState _state = DraftState();

  DocumentState get state => _state;
  set state(DocumentState newState) {
    _state = newState;
    print("Document is now in state: ${_state.name}");
  }

  void publish() => _state.publish(this);
  void reject() => _state.reject(this);
}

class DraftState implements DocumentState {
  @override
  void publish(Document context) {
    context.state = ModerationState();
  }

  @override
  void reject(Document context) {
    // Can't reject draft → do nothing
  }

  @override
  String get name => "Draft";
}

class ModerationState implements DocumentState {
  @override
  void publish(Document context) {
    context.state = PublishedState();
  }

  @override
  void reject(Document context) {
    context.state = DraftState();
  }

  @override
  String get name => "Moderation";
}

class PublishedState implements DocumentState {
  @override
  void publish(Document context) {
    // Already published → do nothing
  }

  @override
  void reject(Document context) {
    context.state = DraftState();
  }

  @override
  String get name => "Published";
}

class StatePage extends StatefulWidget {
  const StatePage({super.key});

  @override
  State<StatePage> createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  final Document document = Document();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("State Pattern")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '- behavioral software design pattern\n- allows an object to alter its behavior when its internal state changes',
            ),
            Divider(height: 20, thickness: 1),
            Text(
              "Current State: ${document.state.name}",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() => document.publish());
              },
              child: Text("Publish"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => document.reject());
              },
              child: Text("Reject"),
            ),
          ],
        ),
      ),
    );
  }
}
