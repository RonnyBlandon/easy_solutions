import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/texts/TextView/View/text_view.dart';
import 'package:flutter/material.dart';

mixin DoubleTextDropdownViewDelegate {
  dropDownTapped({ required bool isExpanded });
}

class DoubleTextDropdownView extends StatefulWidget {
  final String header;
  final String dropdownRightText;

  bool isExpanded = false;
  final DoubleTextDropdownViewDelegate? delegate;

  DoubleTextDropdownView({super.key, 
    required this.header,
    required this.dropdownRightText,
    required this.isExpanded,
    this.delegate
  });

  @override
  State<DoubleTextDropdownView> createState() => _DoubleTextDropdownViewState();
}

class _DoubleTextDropdownViewState extends State<DoubleTextDropdownView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(texto: widget.header,
                fontWeight: FontWeight.w500,
                fontSize: 15.0),
            Transform.translate(
              offset: const Offset(20, 0),
              child: Row(
                children: [
                  Text(widget.dropdownRightText, style: const TextStyle(color: grey)),
                  IconButton(onPressed: () {
                    setState(() {
                      widget.isExpanded = !widget.isExpanded;
                      widget.delegate?.dropDownTapped(isExpanded: widget.isExpanded);
                    });
                  }, icon: Icon(widget.isExpanded
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                      color: grey)),
                ],
              ),
            )
          ],
        ),
        const Divider()
      ],
    );
  }
}