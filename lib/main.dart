import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColorPaletteGenerator(),
    );
  }
}

class ColorPaletteGenerator extends StatefulWidget {
  @override
  _ColorPaletteGeneratorState createState() => _ColorPaletteGeneratorState();
}

class _ColorPaletteGeneratorState extends State<ColorPaletteGenerator> {
  List<Color> colors = [];

  // Random Color Generating Function
  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0, // In RGBO, O means Opaacity
    );
  }

  // we need 5 colors
  void generateRandomPalette() {
    List<Color> newPalette = [];
    for (int i = 0; i < 5; i++) {
      newPalette.add(getRandomColor());
    }
    // Updating RGB values
    setState(() {
      colors = newPalette;
    });
  }

  // RGB values
  String GetRGBvalues(Color color) {
    return 'RGB: (${color.red}, ${color.green}, ${color.blue})';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Palette Generator'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //Creates grid layouts with a fixed number of tiles in the cross axis.
                  crossAxisCount: 2, // 2 columns
                  childAspectRatio: 1.8, // Aspect ratio for square cells
                  mainAxisSpacing: 4, // spacing between rows
                  crossAxisSpacing: 8, // spacing between columns
                ),
                itemCount: colors.length * 2, // 2 cells per color
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    // color at odd cells
                    final color = colors[index ~/ 2];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        top: 8,
                        bottom: 8,
                      ), // Add padding to top, bottom and left
                      child: Container(
                        color: color,
                      ),
                    );
                  } else {
                    // RGV values at even cells
                    final rgbString = GetRGBvalues(colors[index ~/ 2]);
                    return Center(child: Text(rgbString));
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: generateRandomPalette,
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                ),
                child: Text('Generate'),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
