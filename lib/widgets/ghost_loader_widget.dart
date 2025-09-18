/*
 * Copyright (c) 2025. This is a product of Khoodilabs
 */


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GhostLoaderWidget extends StatelessWidget
{

  final int nums;
  GhostLoaderWidget({ required this.nums});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: List.generate(
        this.nums,
            (index) => Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 16,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}