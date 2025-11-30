import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../nuevo/model/nuevo_model.dart';
import '../../../versiones/model/versiones_model.dart';
import 'ficha_oficial_card_number.dart';

class CardOficial extends StatefulWidget {
  final VersionesSingle ver;
  final Map<String, EnableDate> dates;
  const CardOficial({
    required this.ver,
    required this.dates,
    super.key,
  });

  @override
  State<CardOficial> createState() => _CardOficialState();
}

class _CardOficialState extends State<CardOficial> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 25,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.ver.pm,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Gap(1),
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.ver.e4e,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(1),
                  Expanded(
                    flex: 4,
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.ver.descripcion,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m01,
                    estadoPed: widget.dates['01']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m02,
                    estadoPed: widget.dates['02']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m03,
                    estadoPed: widget.dates['03']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m04,
                    estadoPed: widget.dates['04']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m05,
                    estadoPed: widget.dates['05']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m06,
                    estadoPed: widget.dates['06']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m07,
                    estadoPed: widget.dates['07']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m08,
                    estadoPed: widget.dates['08']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m09,
                    estadoPed: widget.dates['09']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m10,
                    estadoPed: widget.dates['10']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m11,
                    estadoPed: widget.dates['11']!,
                  ),
                  const Gap(1),
                  FichaOficialNumber(
                    number: widget.ver.m12,
                    estadoPed: widget.dates['12']!,
                  ),
                  const Gap(1),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.ver.total.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.ver.total == 0
                                ? Colors.grey
                                : Theme.of(context).colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
