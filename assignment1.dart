import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(KidsLearningApp());
}

class KidsLearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABCD & 123 Learning',
      theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: LearningHomePage(),
    );
  }
}

class LearningHomePage extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  final List<String> letters = List.generate(26, (i) => String.fromCharCode(65 + i)); // A-Z
  final List<String> numbers = List.generate(10, (i) => (i + 1).toString()); // 1–10

  // Only available A–H sounds
  final List<String> availableSounds = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

  void playSound(String label) {
    // For A-Z
    String fileName;
    if (RegExp(r'^[A-Z]$').hasMatch(label)) {
      int index = label.codeUnitAt(0) - 65; // A=0, B=1, ...
      fileName = availableSounds[index % availableSounds.length];
    }
    // For 1-10
    else if (RegExp(r'^[0-9]+$').hasMatch(label)) {
      int index = int.parse(label) - 1; // 1=0, 2=1, ...
      fileName = availableSounds[index % availableSounds.length];
    } else {
      fileName = 'A'; // Fallback
    }

    player.play(AssetSource('sounds/$fileName.mp3'));
  }

  Widget buildSection(String title, List<String> items) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.purple),
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            String value = items[index];
            return GestureDetector(
              onTap: () => playSound(value),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.primaries[index % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn ABC & 123'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSection("Alphabets (A–Z)", letters),
              buildSection("Numbers (1–10)", numbers),
            ],
          ),
        ),
      ),
    );
  }
}
