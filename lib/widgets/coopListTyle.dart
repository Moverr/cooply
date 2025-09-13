
import 'package:Cooply/models/dtos/coop_response.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/util.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFE7ECAB).withValues(alpha: 0.8),
                  const Color(0xFFFDF9F9).withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              children: [
                if(coop.name.isNotEmpty)
                Text(
                  "${coop.name}  - ${coop.coopId} ",
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


          if(coop.area != null)
          _buildInfoRow(
            context,
            FontAwesomeIcons.borderAll,
            "Area : ${coop.area ?? "n/a"}   Capacity : ${Util.formatCount(coop.capacity ?? 0)} ",
          ),
          if(coop.area != null)
          _buildProgressRow(context, coop),

          if (coop.power != null && coop.power!.isNotEmpty)
            _buildInfoRow(
            context,
            FontAwesomeIcons.lightbulb,
            "Power : ${coop.power != null
            ? coop.power!.map((p) => "${p.powerType} : ${p.status}").join(", ").toLowerCase()
                : ""}"
            )

    ,
          if (coop.water != null && coop.water!.isNotEmpty)
            _buildInfoRow(
                context,
                FontAwesomeIcons.droplet,
                "Water : ${coop.water != null
                        ? coop.water!.map((p) => "${p.source} : ${p.status}").join(", ").toLowerCase()
                        : ""}"
            )

          ,
          // if(coop.breed!.length > 0)

        if (coop.breed != null && coop.breed!.isNotEmpty)
          _buildInfoRow(
            context,
            FontAwesomeIcons.twitter,
              "Breed : ${coop.breed != null
                  ? coop.breed!.map((p) => "${p} ").join(", ").toLowerCase()
                  : ""}"
          ),

          _buildInfoRow(
          context,
          FontAwesomeIcons.check,
          "Status : ${coop.status.toLowerCase()}",
        ),

//todo: employee issing : employee, capacity, occupied..
          if(coop.employee != null)
          _buildInfoRow(
            context,
            FontAwesomeIcons.user,
            "Manager : Muyinda Rogers   Team : 3 ",
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text,
      {IconData? trailingIcon}) {



    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: Util.scaleWidthFromDesign(context, 12),
            color: Colors.blue,
            shadows: [
              Shadow(
                  blurRadius: 10, color: Colors.greenAccent.withOpacity(0.8)),
              Shadow(
                  blurRadius: 20, color: Colors.greenAccent.withOpacity(0.5)),
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
            Icon(trailingIcon,
                size: Util.scaleWidthFromDesign(context, 12),
                color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildProgressRow(BuildContext context, CoopResponse coop) {
    double progress =
        Util.percentOccupied(coop.occupied ?? 0, coop.capacity ?? 0);
    //0.9; // 90% occupied
    //progress = current stock. o

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Occupied : ${Util.formatCount(coop.occupied ?? 0)}  ${(progress * 100).toStringAsFixed(0)}%",
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
              backgroundColor: Color(0XFFE17A7AFF),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF70B173FF)),
            ),
          ),
        ],
      ),
    );
  }
}
