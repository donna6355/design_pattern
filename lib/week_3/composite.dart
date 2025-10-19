import 'package:flutter/material.dart';
/*
Composite Pattern
- structural software design pattern
- a group of objects that are treated the same way as a single instance of the same type of object
 */

// Component
abstract class MirComment {
  Widget render();
}

class MirCommentLeaf extends MirComment {
  final String author;
  final String content;

  MirCommentLeaf({required this.author, required this.content});

  @override
  Widget render() {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(author, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(content),
    );
  }
}

class MirCommentComposite extends MirComment {
  final String author;
  final String content;
  final List<MirComment> replies = [];

  MirCommentComposite({required this.author, required this.content});

  void addReply(MirComment reply) {
    replies.add(reply);
  }

  @override
  Widget render() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // main comment
          Row(
            children: [
              const Icon(Icons.person),
              const SizedBox(width: 8),
              Text(author, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 4),
            child: Text(content),
          ),
          const SizedBox(height: 8),

          // replies
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: replies.map((r) => r.render()).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CompositePage extends StatelessWidget {
  const CompositePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Root comment
    final mainComment = MirCommentComposite(
      author: 'Isaac',
      content: 'This is a great post!',
    );

    // Replies
    final reply1 = MirCommentLeaf(
      author: 'Moomin',
      content: 'I agree with Alice!',
    );
    final reply2 = MirCommentComposite(
      author: 'Kkomi',
      content: 'Thanks, everyone!',
    );
    reply2.addReply(MirCommentLeaf(author: 'Donna', content: 'No problem!'));

    // Build the tree
    mainComment.addReply(reply1);
    mainComment.addReply(reply2);

    return Scaffold(
      appBar: AppBar(title: const Text('Composite Pattern')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              '- structural software design pattern\n- a group of objects that are treated the same way as a single instance of the same type of object ',
            ),
            Divider(height: 20, thickness: 1),
            Text('댓글과 대댓글 화면 구현\n#일대다 #자동갱신'),
            Divider(height: 20, thickness: 1),
            mainComment.render(),
          ],
        ),
      ),
    );
  }
}
