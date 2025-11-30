import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TableAn extends StatefulWidget {
  final String title;
  final List<Widget> titles;
  final List<Widget> children;
  final void Function() onEndList;
  final int endList;

  const TableAn({
    required this.title,
    required this.titles,
    required this.children,
    required this.onEndList,
    required this.endList,
    super.key,
  });

  @override
  State<TableAn> createState() => _TableAnState();
}

class _TableAnState extends State<TableAn> {
  final ScrollController _controller = ScrollController();

  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // print('endList: ${widget.endList}');
      // print('children: ${widget.children.length}');
      // print(
      //     'widget.children.length > widget.endList: ${widget.children.length > widget.endList}');
      if (widget.children.length < widget.endList) {
        widget.onEndList();
      }
    }
  }

  @override
  void initState() {
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
    return Expanded(
      child: Column(
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(5),
          Row(
            children: widget.titles,
          ),
          const Gap(5),
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: SelectableRegion(
                focusNode: FocusNode(),
                selectionControls: desktopTextSelectionControls,
                child: Column(
                  children: widget.children,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
