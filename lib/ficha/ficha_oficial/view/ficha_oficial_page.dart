import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:fem_app/ficha/ficha_oficial/view/ficha_oficial_card.dart';

import '../../../bloc/main_bloc.dart';
import '../../../versiones/model/versiones_model.dart';

class FichaOficialPage extends StatefulWidget {
  const FichaOficialPage({super.key});

  @override
  State<FichaOficialPage> createState() => _FichaOficialPageState();
}

class _FichaOficialPageState extends State<FichaOficialPage> {
  String filter = '';
  int endList = 20;
  bool firstTimeLoading = true;
  final ScrollController _controller = ScrollController();
  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        endList += 20;
      });
    }
  }

  final uSFormat = NumberFormat.currency(
    locale: "en_US",
    symbol: "\$",
    decimalDigits: 0,
  );

  @override
  void initState() {
    _controller.addListener(_onScroll);
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        firstTimeLoading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  return Expanded(
                    flex: 8,
                    child: Text(
                        'Valor Ficha: ${uSFormat.format(state.ficha?.resumen.total ?? 0)}'),
                  );
                },
              ),
              const Gap(3),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  return Expanded(
                    flex: 8,
                    child: RichText(
                      text: TextSpan(
                        text: 'Valor Oficial: ',
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: uSFormat
                                .format(state.ficha?.resumen.totalof ?? 0),
                          ),
                          TextSpan(
                            text:
                                ' (${(100 * state.ficha!.resumen.totalof / state.ficha!.resumen.total).toStringAsFixed(0)}%)',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Gap(3),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    '01',
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
                    '02',
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
                    '03',
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
                    '04',
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
                    '05',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
                    '06',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
                    '07',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
                    '08',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
                    '09',
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
                    '10',
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
                    '11',
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
                    '12',
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
                    'T',
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
        const Gap(5),
        // Text('Ficha Oficial', style: Theme.of(context).textTheme.headline6),
        Expanded(
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              List<VersionesSingle> version = [];
              if (state.ficha == null || firstTimeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              version = state.ficha!.oficial.version;
              if (version.length > endList) {
                version = version.sublist(0, endList);
              }
              print('version.length: ${version.length}');
              return SingleChildScrollView(
                controller: _controller,
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    for (VersionesSingle ver in version)
                      Builder(builder: (context) {
                        return CardOficial(
                          ver: ver,
                          dates: state.fechasFEM!.enableDates(state.year!),
                        );
                      })
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
