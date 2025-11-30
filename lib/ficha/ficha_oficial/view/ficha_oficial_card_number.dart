import 'package:flutter/material.dart';

import '../../../nuevo/model/nuevo_model.dart';

class FichaOficialNumber extends StatefulWidget {
  final String number;
  final EnableDate estadoPed;
  const FichaOficialNumber({
    required this.number,
    required this.estadoPed,
    super.key,
  });

  @override
  State<FichaOficialNumber> createState() => _FichaOficialNumberState();
}

class _FichaOficialNumberState extends State<FichaOficialNumber> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.estadoPed.versionActivaq2
              ? Theme.of(context).colorScheme.background
              : Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.number.isEmpty ? '0' : widget.number,
          style: TextStyle(
            fontSize: 10,
            color: widget.number.isEmpty || widget.number == '0'
                ? Colors.grey
                : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
