import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class QuantityPicker extends StatefulWidget {
  final int initialQty;
  final int maxQty;
  final ValueChanged<int> onChanged;

  const QuantityPicker({
    super.key,
    this.initialQty = 1,
    this.maxQty = 999,
    required this.onChanged,
  });

  @override
  State<QuantityPicker> createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {
  late int _qty;

  @override
  void initState() {
    super.initState();
    _qty = widget.initialQty;
  }

  void _increment() {
    if (_qty < widget.maxQty) {
      setState(() => _qty++);
      widget.onChanged(_qty);
    }
  }

  void _decrement() {
    if (_qty > 1) {
      setState(() => _qty--);
      widget.onChanged(_qty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _button(Icons.remove, _decrement),
        Container(
          width: 48,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            color: Colors.white,
          ),
          child: Text('$_qty', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        _button(Icons.add, _increment),
      ],
    );
  }

  Widget _button(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          color: AppColors.primaryBg,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}
