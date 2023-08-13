import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            'Description of product',
            style: GoogleFonts.inter(
              color: const Color(0xFF393F42),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquet arcu id tincidunt tellus arcu rhoncus, turpis nisl sed. Neque viverra ipsum orci, morbi semper. Nulla bibendum purus tempor semper purus. Ut curabitur platea sed blandit. Amet non at proin justo nulla et. A, blandit morbi suspendisse vel malesuada purus massa mi. Faucibus neque a mi hendrerit.\n\nAudio Technology\nApple-designed dynamic driver\nActive Noise Cancellation\nTransparency mode\nAdaptive EQ\nSpatial audio with dynamic head tracking1\n\nSensors\nOptical sensor (each ear cup)\nPosition sensor (each ear cup)\nCase-detect sensor (each ear cup)\nAccelerometer (each ear cup)\nGyroscope (left ear cup)\n\nMicrophones\nNine microphones total:\nEight microphones for Active Noise Cancellation\nThree microphones for voice pickup (two shared with Active Noise Cancellation and one additional microphone)\n\nChip\nApple H1 headphone chip (each ear cup)\n\nControls\nDigital Crown\nTurn for volume control\nPress once to play, pause or answer a phone call\nPress twice to skip forwards\nPress three times to skip back\nPress and hold for Siri\nNoise control button\nPress to switch between Active Noise Cancellation and Transparency mode\n\nSize and Weight2\nAirPods Max, including cushions\nWeight: 384.8g\n\nSmart Case\nWeight: 134.5g\n\nBattery\nAirPods Max\nUp to 20 hours of listening time on a single charge with Active Noise Cancellation or Transparency mode enabled3\nUp to 20 hours of movie playback on a single charge with spatial audio on4\nUp to 20 hours of talk time on a single charge5\n5 minutes of charge time provides around 1.5 hours of listening time6\nAirPods Max with Smart Case\n\nStorage in the Smart Case preserves battery charge in ultra-low-power state\nCharging via Lightning connector\n\nConnectivity\nBluetooth 5.0\n\nIn the Box\nAirPods Max\nSmart Case\nLightning to USB-C Cable\nDocumentation\nAccessibility7\nAccessibility features help people with disabilities get the most out of their new AirPods Max.\n\nFeatures include:\nLive Listen audio\nHeadphone levels\nHeadphone Accommodations\n\nSystem Requirements8\niPhone and iPod touch models with the latest version of iOS\niPad models with the latest version of iPadOS\nApple Watch models with the latest version of watchOS\nMac models with the latest version of macOS\nApple TV models with the latest version of tvOS',
            style: GoogleFonts.inter(
              color: const Color(0xFF393F42),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
          ),
        ),
      ],
    );
  }
}
