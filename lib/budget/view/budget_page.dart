// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:fem_app/budget/model/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({
    super.key,
  });

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  String filter = '';
  int endList = 70;
  bool firstTimeLoading = true;
  final ScrollController _controller = ScrollController();
  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        endList += 70;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        firstTimeLoading = false;
      });
    });
    _controller.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
      ),
      floatingActionButton: BlocSelector<MainBloc, MainState, Budget?>(
        selector: (state) => state.budget,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahora(
                datos: state.budgetList,
                nombre: 'Budget',
              ),
              child: const Icon(Icons.download),
            );
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Búsqueda',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(5),
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              List<ToCelda> titles = state.budget!.titles;
              return Row(
                children: [
                  for (ToCelda celda in titles)
                    Expanded(
                      flex: celda.flex,
                      child: Text(
                        celda.valor,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const Gap(5),
          Expanded(
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state.budget == null || firstTimeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<BudgetSingle> budgetList = state.budget!.budgetList;
                budgetList = budgetList
                    .where(
                      (e) => e.toList().any(
                            (el) => el.toLowerCase().contains(
                                  filter.toLowerCase(),
                                ),
                          ),
                    )
                    .toList();
                if (budgetList.length > endList) {
                  budgetList = budgetList.sublist(0, endList);
                }
                return SingleChildScrollView(
                  controller: _controller,
                  child: SelectableRegion(
                    focusNode: FocusNode(),
                    selectionControls: emptyTextSelectionControls,
                    child: Column(
                      children: [
                        for (BudgetSingle budget in budgetList)
                          Builder(builder: (context) {
                            return Row(
                              children: [
                                for (ToCelda celda in budget.celdas)
                                  Expanded(
                                    flex: celda.flex,
                                    child: Text(
                                      celda.valor,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
