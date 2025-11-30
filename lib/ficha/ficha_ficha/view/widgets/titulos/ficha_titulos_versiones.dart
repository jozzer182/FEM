import 'package:fem_app/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../resources/numero_precio.dart';
import '../../../../ficha_resumen/model/ficha__resumen_model.dart';

class FichaTitulosVersiones extends StatelessWidget {
  const FichaTitulosVersiones({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              FResumen resumen = state.ficha!.resumen;
              String budgetMaterial = uSFormat.format(resumen.budgetMaterial);
              return Expanded(
                flex: 8,
                child: Text('Budget Material: $budgetMaterial'),
              );
            },
          ),
          const Gap(2),
          Expanded(
            flex: 12,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Text(
                      'V1',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Gap(4),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Text(
                      'V2',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Gap(4),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Text(
                      'V3',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Gap(1),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
