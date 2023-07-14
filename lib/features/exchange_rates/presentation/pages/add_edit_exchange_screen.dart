import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/presentation/bloc/exchange_rates/exchange_rates_bloc.dart';
import 'package:admin/features/bookings/presentation/widgets/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddEditExchangeScreen extends StatefulWidget {
  const AddEditExchangeScreen({super.key, this.rate});

  final ExchangeRate? rate;

  @override
  State<AddEditExchangeScreen> createState() => _AddEditExchangeScreenState();
}

class _AddEditExchangeScreenState extends State<AddEditExchangeScreen> {
  bool isEdit = false;
  TextEditingController currencyController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  bool enable = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.rate != null) {
      isEdit = true;
      currencyController.text = widget.rate!.currency;
      rateController.text = widget.rate!.rate.toString();
      enable = widget.rate!.active;
    }
  }

  @override
  void dispose() {
    currencyController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit
            ? "Edit (${widget.rate!.currency}) rate"
            : "Add Exchange Rate"),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (formKey.currentState?.validate() ?? false) {
            ExchangeRate rate = ExchangeRate(
              currency: currencyController.text,
              rate: double.parse(rateController.text),
              active: enable,
            );
            if (isEdit) {
              context.read<ExchangeRatesBloc>().add(UpdateExchangeRates(rate));
            } else {
              context.read<ExchangeRatesBloc>().add(AddExchangeRates(rate));
            }
            Navigator.pop(context);
          }
        },
        child: Container(
          width: double.maxFinite,
          height: 8.h,
          alignment: Alignment.center,
          margin: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            color: Colors.lightBlueAccent,
          ),
          child: Text(
            "${isEdit ? "Edit" : "Add"} Exchange Rate",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 1.h),
              TextFormField(
                controller: currencyController,
                enabled: !isEdit,
                decoration: CustomInputDecoration.basic('Currency'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "currency should not be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.h),
              TextFormField(
                controller: rateController,
                decoration: CustomInputDecoration.basic('Rate'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (double.tryParse(value ?? "") == null) {
                    return "rate should not be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Text(
                    "Enable Currency: ",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                      value: enable,
                      onChanged: (value) {
                        setState(() {
                          enable = value;
                        });
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
