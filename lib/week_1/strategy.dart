/*
Strategy Pattern
- behavioral software design pattern
- enables selecting an algorithm at runtime 
 */
import 'package:flutter/material.dart';

abstract class MirFilter {
  String get getLabel;
}

enum Location implements MirFilter {
  indoor('실내', true),
  outdoor('실외', false);

  final String label;
  final bool isIndoor;
  const Location(this.label, this.isIndoor);

  @override
  String get getLabel => label;
}

enum OpStatus implements MirFilter {
  inPrep('준비중', 0, Colors.yellow),
  available('사용 가능', 1, Colors.green),
  broken('고장', 2, Colors.red);

  final String label;
  final int code;
  final Color color;
  const OpStatus(this.label, this.code, this.color);

  @override
  String get getLabel => label;
}

enum Periode implements MirFilter {
  today('오늘', 0),
  thisWeek('1주', 7),
  thisMonth('1개월', 30);

  final String label;
  final int days;
  const Periode(this.label, this.days);

  @override
  String get getLabel => label;
}

class MirDropDown<T extends MirFilter> extends StatelessWidget {
  final String hint;
  final List<T> values;
  final Function(T) onSelected;
  const MirDropDown({
    required this.values,
    required this.hint,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: DropdownMenu<T>(
        leadingIcon: const Icon(Icons.filter_list_sharp),
        trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        width: 200,
        label: Text(hint, style: TextStyle(color: Colors.black54)),
        dropdownMenuEntries: values
            .map(
              (item) => DropdownMenuEntry<T>(label: item.getLabel, value: item),
            )
            .toList(),
        onSelected: (val) {
          if (val == null) return;
          onSelected(val);
        },
      ),
    );
  }
}

class StrategyPage extends StatefulWidget {
  const StrategyPage({super.key});

  @override
  State<StrategyPage> createState() => _StrategyPageState();
}

class _StrategyPageState extends State<StrategyPage> {
  String? _call;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Strategy Pattern')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '- behavioral software design pattern\n- enables selecting an algorithm at runtime',
            ),
            Divider(height: 20, thickness: 1),
            Text(
              '위치, 상태, 기간의 필터에 맞는 데이터를 화면에 구현\n디자인과 같은 드롭다운 메뉴를 화면에 구현하고 사용자가 원하는 필터를 선택\n상세 페이지에서는 상태 별로 다른 색깔을 적용\n#추상화 #캡슐화 #재사용 #상속보다구성',
            ),
            Divider(height: 20, thickness: 1),

            if (_call != null)
              Text(
                _call!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            MirDropDown<Location>(
              values: Location.values,
              hint: '위치',
              onSelected: (val) => setState(
                () => _call = 'API 호출합니다! isIndoor = ${val.isIndoor}',
              ),
            ),
            MirDropDown<OpStatus>(
              values: OpStatus.values,
              hint: '상태',
              onSelected: (val) =>
                  setState(() => _call = 'API 호출합니다! status = ${val.code}'),
            ),
            MirDropDown<Periode>(
              values: Periode.values,
              hint: '기간',
              onSelected: (val) =>
                  setState(() => _call = 'API 호출합니다! periode = ${val.days}'),
            ),

            Text('상태값은 다른 상세페이지에서 이렇게도 사용되요!'),
            Row(
              spacing: 16,
              children: OpStatus.values
                  .map((e) => ColoredBox(color: e.color, child: Text(e.label)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
