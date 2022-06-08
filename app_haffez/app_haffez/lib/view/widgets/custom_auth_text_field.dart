import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class CustomAuthTextField extends StatefulWidget {
  const CustomAuthTextField({
    Key? key,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isPassword = false,
    this.isEdit = false,
    this.isReadOnly = false,
    this.value = "",
    this.onTap,
    this.initialValue = "",
    required this.onSaved,
  }) : super(key: key);

  final String hintText;
  final String initialValue;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isPassword;
  final bool isEdit;
  final bool isReadOnly;
  final String? value;
  final Function(String?) onSaved;
  final VoidCallback? onTap;

  @override
  State<CustomAuthTextField> createState() => _CustomAuthTextFieldState();
}

class _CustomAuthTextFieldState extends State<CustomAuthTextField> {
  var isShowPassword = false;
  var isReadOnly = false;

  @override
  void initState() {
    super.initState();
    isReadOnly = widget.isEdit;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.r, 0, 5.r, 0.r),
      height: 45.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffe8e8e8)),
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.value != ""
                  ? TextEditingController(text: widget.value)
                  : null,
              initialValue: widget.initialValue,
              readOnly: (widget.isReadOnly || isReadOnly),
              onSaved: (value) => widget.onSaved(value),
              onTap: widget.onTap,
              textInputAction: widget.textInputAction,
              keyboardType: widget.textInputType,
              obscureText: widget.isPassword && !isShowPassword,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          Column(
            children: [
              Visibility(
                visible: widget.isPassword,
                child: SizedBox(
                  width: 40.w,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    child: CustomText(
                      text: isShowPassword ? "إخفاء" : "إظهار",
                      textColor: Theme.of(context).primaryColor,
                      lineHeight: 1.5,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.isEdit,
                child: SizedBox(
                  width: 40.w,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isReadOnly = !isReadOnly;
                      });
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
