import 'package:e_commerce/constans.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CustomWeve extends StatelessWidget {
  final double size;

  const CustomWeve({@required this.size});

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      duration: 1,
      config: CustomConfig(
        gradients: [
          [Color(0xFF6ACEEB), Color(0xFF6ACEEB)],
          [Color(0xFF0B8899), Color(0xFFFF9592)],
          [Color(0xFF00C990), Color(0xFF00C990)],
          [Color(0xFF83E77C), Color(0xFF83E77C)]
        ],
        durations: [35000, 19440, 10800, 8000],
        heightPercentages: [125, 120, 115, 112],
        blur: MaskFilter.blur(BlurStyle.inner, 5),
        // gradientBegin: Alignment.centerLeft,
        // gradientEnd: Alignment.centerRight,
      ),
      waveAmplitude: 1.0,
      backgroundColor: Color(0xFF83E77C),
      size: Size(double.infinity, size),
    );
  }
}
