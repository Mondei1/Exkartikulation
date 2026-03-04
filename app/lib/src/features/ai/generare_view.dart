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
            children: [AiGenerateButton()],
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

class AiGenerateButton extends StatefulWidget {
  const AiGenerateButton({super.key});

  @override
  State<AiGenerateButton> createState() => _AiGenerateButtonState();
}

class _AiGenerateButtonState extends State<AiGenerateButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: false);

    _animation = Tween<double>(
      begin: 0,
      end: 6.28319,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: SweepGradient(
              transform: GradientRotation(_animation.value),
              colors: const [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.purple,

                // Fade-Out (Purple → Transparent)
                Color(0xCC800080),
                Color(0x99800080),
                Color(0x66800080),
                Color(0x33800080),
                Color(0x1A800080),
                Color(0x00800080),
                Color(0x00800080),
                Color(0x00800080),
                Color(0x00800080),
                Color(0x00800080), // transparent
                Color(0x00800080),
                // Fade-In (Transparent → Rot)
                Color(0x1AFF0000),
                Color(0x33FF0000),
                Color(0x66FF0000),
                Color(0x99FF0000),
                Color(0xCCFF0000),
                Colors.red,
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
      },
    );
  }
}
