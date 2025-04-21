import 'package:flutter/material.dart';
import 'package:slider_bar/slider_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SliderBar Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SliderBar Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _horizontalValue = 50;
  double _verticalValue = 50;

  final SliderController _horizontalController = SliderController(
    initialValue: 50,
    min: 0,
    max: 100,
  );

  final SliderController _verticalController = SliderController(
    initialValue: 50,
    min: 0,
    max: 100,
  );

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Horizontal Slider',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SliderBar(
              controller: _horizontalController,
              config: SliderConfig(
                min: 0,
                direction: SliderDirection.horizontal,
                max: 100,
                initialValue: 50,
                showLabel: true,
                labelFormat: (value) => value.toInt().toString(),
                trackConfig: TrackConfig(
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey.shade300,
                  height: 8,
                  radius: 4,
                ),
                thumbConfig: const ThumbConfig(
                  color: Colors.blue,
                  width: 24,
                  height: 24,
                  shape: BoxShape.circle,
                  elevation: 2,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _horizontalValue = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Text('Current value: ${_horizontalValue.toInt()}'),

            const SizedBox(height: 32),

            const Text(
              'Vertical Slider',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  child: SliderBar(
                    controller: _verticalController,
                    config: SliderConfig(
                      min: 0,
                      max: 100,
                      initialValue: 50,
                      direction: SliderDirection.vertical,
                      showLabel: true,
                      labelFormat: (value) => value.toInt().toString(),
                      trackConfig: TrackConfig(
                        activeColor: Colors.green,
                        inactiveColor: Colors.grey.shade300,
                        height: 8,
                        radius: 4,
                      ),
                      thumbConfig: const ThumbConfig(
                        color: Colors.green,
                        width: 24,
                        height: 24,
                        shape: BoxShape.rectangle,
                        radius: 8,
                        elevation: 2,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _verticalValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Text('Current value: ${_verticalValue.toInt()}'),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              'Custom Styling Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Custom styled slider 1
            SliderBar(
              config: SliderConfig(
                min: 0,
                max: 100,
                initialValue: 30,
                trackConfig: TrackConfig(
                  activeColor: Colors.purple,
                  inactiveColor: Colors.purple.shade100,
                  height: 12,
                  radius: 6,
                ),
                thumbConfig: const ThumbConfig(
                  color: Colors.deepPurple,
                  width: 28,
                  height: 28,
                  shape: BoxShape.circle,
                  elevation: 3,
                  shadowColor: Colors.purple,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Custom styled slider 2
            SliderBar(
              config: SliderConfig(
                min: 0,
                max: 100,
                initialValue: 70,
                trackConfig: TrackConfig(
                  activeColor: Colors.orange,
                  inactiveColor: Colors.grey.shade200,
                  height: 4,
                  radius: 2,
                ),
                thumbConfig: const ThumbConfig(
                  color: Colors.deepOrange,
                  width: 20,
                  height: 20,
                  shape: BoxShape.rectangle,
                  radius: 4,
                  elevation: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
