import 'package:flutter/material.dart';

class GenerateView extends StatefulWidget {
  const GenerateView({super.key});

  @override
  State<GenerateView> createState() => _GenerateViewState();
}

class _GenerateViewState extends State<GenerateView>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Karten generieren"),
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  "Text",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  "Datei",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
          controller: _controller,
        ),
      ),
      body: Center(
        child: TabBarView(
          controller: _controller,
          children: [TextGenerateTab(), Text("data")],
        ),
      ),
    );
  }
}

class TextGenerateTab extends StatefulWidget {
  const TextGenerateTab({super.key});

  @override
  State<TextGenerateTab> createState() => _TextGenerateTabState();
}

class _TextGenerateTabState extends State<TextGenerateTab> {
  double _currentFlashCardCount = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: TextField(
            maxLines: 5,
            minLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Gebe eine Beschreibung an"),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Anzahl Karteikarten"),
              Slider(
                value: _currentFlashCardCount,
                min: 3,
                max: 15,
                divisions: 12,
                onChanged: (value) {
                  setState(() {
                    _currentFlashCardCount = value;
                  });
                },
                label: _currentFlashCardCount.round().toString(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [AiGenerateButton(onPressed: () {})],
          ),
        ),
      ],
    );
  }
}

class FileGenerateTab extends StatefulWidget {
  const FileGenerateTab({super.key});

  @override
  State<FileGenerateTab> createState() => _FileGenerateTabState();
}

class _FileGenerateTabState extends State<FileGenerateTab> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AiGenerateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AiGenerateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3), // Randdicke
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.purple,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome),
            SizedBox(width: 8),
            Text("Generiere"),
          ],
        ),
      ),
    );
  }
}
