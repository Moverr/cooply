import 'dart:math';

import 'package:Cooply/models/dtos/coop.dart';
import 'package:Cooply/models/dtos/coop_response.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/util.dart';
import 'package:latlong2/latlong.dart';

class CoopListTyle extends StatefulWidget {
  final CoopResponse coop;
  final VoidCallback? onTap;
  CoopListTyle({Key? key, required this.coop, this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoopListTyleState();
}

class _CoopListTyleState extends State<CoopListTyle> {
  bool _showMap = false;

  late CoopResponse coop;
  late VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    coop = widget.coop;
    onTap = widget.onTap;

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(
        vertical: Util.scaleWidthFromDesign(context, 8),
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(8), // add padding instead of translate
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0XFFCDB4B4),
            offset: Offset(0, Util.scaleWidthFromDesign(context, 0.5)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar
          Container(
            height: Util.scaleWidthFromDesign(context, 22),
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFE7E0EC).withValues(alpha: 0.8),
                  const Color(0xFFFDF9F9).withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              children: [
                Text(
                  "${coop.name} #${coop.referenceId} ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Util.scaleWidthFromDesign(context, 12),
                    fontFamily: AppConstants.defaultFont,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.penToSquare,
                    size: Util.scaleWidthFromDesign(context, 12),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 6),

          // Info Rows (Area, Capacity, etc.)
          _buildInfoRow(
            context,
            FontAwesomeIcons.borderAll,
            "Area : 200m   Capacity : 12K",
          ),
          _buildProgressRow(context),

          _buildInfoRow(
            context,
            FontAwesomeIcons.lightbulb,
            "Power : Grid(None), Solar (Active)",
          ),
          _buildInfoRow(
            context,
            FontAwesomeIcons.droplet,
            "Water : None",
          ),
          _buildInfoRow(
            context,
            FontAwesomeIcons.twitter,
            "Breed : Local,Mixed   Stage : Grower,Laying",
          ),
          _buildInfoRow(
            context,
            FontAwesomeIcons.check,
            "Status : Active",
          ),
          _buildInfoRow(
            context,
            FontAwesomeIcons.user,
            "Manager : Muyinda Rogers   Team : 3 ",


          ),
        ],
      ),
    );

  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text, { IconData? trailingIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,
            size: Util.scaleWidthFromDesign(context, 12),
            color: Colors.blue,
            shadows: [
              Shadow(blurRadius: 10, color: Colors.greenAccent.withOpacity(0.8)),
              Shadow(blurRadius: 20, color: Colors.greenAccent.withOpacity(0.5)),
            ],
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: Util.scaleWidthFromDesign(context, 11),
                fontFamily: AppConstants.defaultFont,
              ),
            ),
          ),
          if (trailingIcon != null)
            Icon(trailingIcon, size: Util.scaleWidthFromDesign(context, 12), color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildProgressRow(BuildContext context) {
    double progress = 0.9; // 90% occupied

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Occupied : 1K  ${ (progress * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: Util.scaleWidthFromDesign(context, 11),
                  fontFamily: AppConstants.defaultFont,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              minHeight: 5,
              value: progress,
              backgroundColor: Colors.redAccent.shade700,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
            ),
          ),
        ],
      ),
    );
  }



  List<String> images = [
    "assets/chicken1.png",
    "assets/chicken2.png",
    "assets/chicken3.png",
    "assets/chicken4.png",
    "assets/chicken5.png",
    "assets/chicken6.png",
    "assets/chicken7.png",
  ];
  final random = Random();
  Image getRandomImage() {
    int number = random.nextInt(7);
    return Image.asset(images[number]);
  }
}
