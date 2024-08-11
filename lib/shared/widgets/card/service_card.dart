import 'package:app/shared/constants/spaces.dart';
import 'package:app/shared/constants/values.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {super.key,
      this.label,
      required this.text,
      required this.img,
      required this.onTap});
  final String? label;
  final String text;
  final String img;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: Color(0xffeeeeee),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CachedNetworkImage(
                  height: 30,
                  imageUrl: '${api}file/$img',
                  progressIndicatorBuilder: (context, url, dp) =>
                      CircularProgressIndicator(
                    value: dp.progress,
                  ),
                ),
                space2,
                Text(text),
              ],
            ),
          ),
          if (label != null)
            Positioned(
                top: 0,
                // left: 0.01,
                // right: 0.01,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xff3b864e)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    label ?? '',
                    style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ))
        ],
      ),
    );
  }
}
