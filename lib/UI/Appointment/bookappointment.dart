import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/APIModels/createAppointment.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Constraints/nplanguage.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Extracted%20Widgets/customtextfield.dart';
import 'package:yourwellbeing/Extracted%20Widgets/showdialog.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/Network/NetworkHelper.dart';
import 'package:yourwellbeing/UI/BottomNavigation/bottom_navigation.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';

class BookAppointment extends StatefulWidget {
  final doctorName;

  BookAppointment({this.doctorName});
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  TimeOfDay selectedTime = TimeOfDay.now();
  final selectDate = TextEditingController();
  var selectTime = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController age = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController problem = TextEditingController();

  int currentStep = 0;
  var picked;
  var datechosem;

  List _selectedPaymentT = [];
  List images = [
    'assets/cash.png',
    'assets/esewa.png',
  ];
  List nameList = [
    'Cash',
    'Esewa',
  ];

  int? _value = 0;
  String? gender;

  String? hospital;

  var language;

  var result;

  @override
  void initState() {
    // TODO: implement initState
    language = UserSimplePreferences.getLanguage() ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppointmentAppBar(
        title: 'Book Appointment',
        tap: true,
      ),
      body: Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.light(primary: kStyleBlue)),
        child: Stepper(
          physics: ScrollPhysics(),
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () async {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              result = await Connectivity().checkConnectivity();

              if (result == ConnectivityResult.mobile ||
                  result == ConnectivityResult.wifi) {
                if (name.text.isNotEmpty &&
                    age.text.isNotEmpty &&
                    phone.text.isNotEmpty &&
                    problem.text.isNotEmpty &&
                    selectDate.text.isNotEmpty &&
                    selectTime.text.isNotEmpty &&
                    _value != 0 &&
                    currentType != 'Select Hospital' &&
                    _selectedPaymentT.isNotEmpty) {
                  showDialog(
                    barrierColor: Colors.blueAccent.withOpacity(0.3),
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: <Widget>[
                        FittedBox(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: 12 / 4,
                                  child: Image.asset(
                                    'assets/bookap.png',
                                  ),
                                ),
                                Text(
                                  "Attention",
                                  style: kStyleHomeTitle.copyWith(
                                      fontSize: 20,
                                      decoration: TextDecoration.none),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Are you sure you want to book your appointment?",
                                  textAlign: TextAlign.center,
                                  style: kStyleHomeTitle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none),
                                ),
                                const SizedBox(height: 28),
                                blueButton(
                                  Text(
                                    'Yes',
                                    style: kStyleHomeTitle.copyWith(
                                        decoration: TextDecoration.none,
                                        color: Colors.white),
                                  ),
                                  () async {
                                    late var token = Provider.of<DataProvider>(
                                            context,
                                            listen: false)
                                        .tokenValue;
                                    Navigator.pop(context);
                                    showWaitDialog(context,
                                        language ? 'Please Wait...' : nepWait);

                                    CreateAppointment? appointment =
                                        await NetworkHelper().createAppointment(
                                      name.text,
                                      age.text,
                                      gender ?? 'No gender selected',
                                      phone.text,
                                      datechosem.toString() +
                                          " " +
                                          selectTime.text,
                                      widget.doctorName,
                                      hospital ?? 'No hospital selected',
                                      problem.text,
                                      _selectedPaymentT.contains(0) == true
                                          ? 'Cash '
                                          : "Esewa",
                                      token,
                                    );
                                    //Sending data to server Create Appointmento
                                    print('api called');
                                    if (appointment!.message !=
                                        "Appointment already exist") {
                                      Future.delayed(
                                        const Duration(
                                            seconds:
                                                2), //If there are server error or internet error till 15 sec it will ask to retry
                                        () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const BottomNavigationPage(),
                                            ),
                                          );
                                          showSnackBar(
                                            context,
                                            "Attention",
                                            Colors.green,
                                            Icons.info,
                                            "Appointment created successfully",
                                          );
                                        },
                                      );
                                    } else {
                                      Future.delayed(
                                        const Duration(
                                            seconds:
                                                2), //If there are server error or internet error till 15 sec it will ask to retry
                                        () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          Navigator.pop(context);
                                          showSnackBar(
                                            context,
                                            "Attention",
                                            Colors.red,
                                            Icons.info,
                                            "Appointment already exist",
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 14),
                                whiteButton('No', () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  Navigator.pop(context);
                                }),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  print('failed');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Alert"),
                        content: const Text("Please fill up all the fields"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                }
              } else {
                showSnackBar(
                  context,
                  "Attention",
                  Colors.blue,
                  Icons.info,
                  "You must be connected to the internet.",
                );
              }
            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepCancel: currentStep == 0
              ? null
              : () {
                  setState(() {
                    currentStep -= 1;
                  });
                },
          onStepTapped: (step) => setState(() {
            currentStep = step;
          }),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;

            return Container(
              child: Row(
                children: [
                  if (currentStep != 0)
                    AppointmentButton(
                        text: 'Previous', onPress: details.onStepCancel),
                  currentStep == 0
                      ? SizedBox(
                          width: 0,
                        )
                      : SizedBox(
                          width: 20,
                        ),
                  AppointmentButton(
                      text: isLastStep ? 'Confirm' : 'Next',
                      onPress: details.onStepContinue),
                  /*  TextButton(onPressed:  details.onStepContinue, child: Text(isLastStep ? 'Confirm' : 'Next')),*/
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Personal'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: kStyleHomeTitle.copyWith(color: Color(0xff000000)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldForLoginRegister(
                label: 'Full Name',
                imageName: Icons.account_circle,
                textFieldDesignType: 'both',
                controller: name,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Address',
                style: kStyleHomeTitle.copyWith(color: Color(0xff000000)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldForLoginRegister(
                  label: 'Address',
                  imageName: Icons.location_on,
                  textFieldDesignType: 'both',
                  controller: address),
              SizedBox(
                height: 20,
              ),
              Text(
                'Age',
                style: kStyleHomeTitle.copyWith(color: Color(0xff000000)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldForLoginRegister(
                  label: 'Age',
                  imageName: Icons.calendar_today,
                  textFieldDesignType: 'both',
                  textFieldType: 'phone',
                  controller: age),
              SizedBox(
                height: 20,
              ),
              Text(
                'Gender',
                style: kStyleHomeTitle.copyWith(color: Color(0xff000000)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: kStyleBlue,
                        value: 1,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = 1;
                            gender = 'Male';
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: kStyleHomeTitle,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: kStyleBlue,
                        value: 2,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = 2;
                            gender = 'Female';
                          });
                        },
                      ),
                      Text(
                        'Female',
                        style: kStyleHomeTitle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: kStyleBlue,
                        value: 3,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = 3;
                            gender = 'Others';
                          });
                        },
                      ),
                      Text(
                        'Others',
                        style: kStyleHomeTitle,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Phone',
                style: kStyleHomeTitle.copyWith(color: Color(0xff000000)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldForLoginRegister(
                  label: 'Phone',
                  imageName: Icons.phone,
                  textFieldDesignType: 'top',
                  textFieldType: 'phone',
                  controller: phone),
/*              TextFormFieldForLoginRegister(
                  label: 'Email',
                  imageName: Icons.message,
                  textFieldDesignType: 'bottom',
                  controller: gender),*/
              SizedBox(
                height: 30,
              )
            ],
          )),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Address'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date And Time',
                style: kStyleHomeTitle.copyWith(color: Color(0xff000000)),
              ),
              SizedBox(
                height: 10,
              ),
              DatePickerField(
                imageName: Icons.calendar_today,
                textFieldDesignType: 'top',
                controller: selectDate,
                date: selectDate.text,
                onPress: () async {
                  DateTime? _selectedDateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2040),
                    initialDatePickerMode: DatePickerMode.day,
                  );
                  setState(() {
                    selectDate.text = _selectedDateTime.toString().substring(
                        0, _selectedDateTime.toString().indexOf(' '));
                    String formattedDate1 =
                        DateFormat('yyyy-MM-dd').format(_selectedDateTime!);
                    datechosem = formattedDate1;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DatePickerField(
                imageName: Icons.access_time,
                textFieldDesignType: 'bottom',
                controller: selectTime,
                date: selectTime.text,
                onPress: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    initialEntryMode: TimePickerEntryMode.dial,
                  );
                  if (timeOfDay != null) {
                    setState(() {
                      DateTime parsedTime = DateFormat.jm()
                          .parse(timeOfDay.format(context).toString());
                      print('dsd : $parsedTime');
                      String formattedTime =
                          DateFormat('HH:mm:ss').format(parsedTime);
                      selectTime.text = formattedTime;
                      print("select ${formattedTime}");
                      print(
                          'sect ${datechosem.toString() + " " + selectTime.text}');
                    });
                  }
                },
              ),

              /* TextFormFieldForLoginRegister( label: 'Select your preferable date',
              imageName: 'assets/formIcons/calendar.png', textFieldDesignType: 'top',),
            TextFormFieldForLoginRegister( label: 'Your preferable time',
              imageName: 'assets/formIcons/clock.png', textFieldDesignType: 'bottom',),*/
              SizedBox(
                height: 30,
              ),
              Text(
                'Select Clinic',
                style: kStyleHomeTitle.copyWith(color: Color(0xff000000)),
              ),
              SizedBox(
                height: 10,
              ),
              getDropdownHospital(),
              SizedBox(
                height: 30,
              ),
              Text(
                'Describe your problem',
                style: kStyleHomeTitle.copyWith(color: Color(0xff000000)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldEmpty(
                  maxLines: 5,
                  textFieldDesignType: 'both',
                  controller: problem),
              SizedBox(
                height: 30,
              ),
            ],
          )),
      Step(
          isActive: currentStep >= 2,
          title: Text('Payment'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking Details',
                style: kStyleHomeTitle,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [boxShadow],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    RecheckResult(title: 'Name', name: name.text),
                    RecheckResult(title: 'Address', name: address.text),
                    RecheckResult(title: 'Age', name: age.text),
                    RecheckResult(title: 'Phone', name: phone.text),
                    RecheckResult(title: 'Gender', name: gender ?? ''),
                    RecheckResult(title: 'Date', name: selectDate.text),
                    RecheckResult(title: 'Time', name: selectTime.text),
                    RecheckResult(title: 'Problem', name: problem.text),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Payment Option',
                style: kStyleHomeTitle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 2,
                    itemBuilder: (context, i) {
                      final _isSelected = _selectedPaymentT.contains(i);
                      var _isSelectedPay = nameList[i];
                      return PaymentOptions(
                        icon: images[i],
                        name: nameList[i],
                        onTap: () {
                          setState(
                            () {
                              if (_isSelected) {
                                _selectedPaymentT.remove(i);
                              } else if (_selectedPaymentT.isNotEmpty) {
                                _selectedPaymentT.clear();
                                _selectedPaymentT.add(i);
                              } else {
                                _selectedPaymentT.add(i);
                              }
                            },
                          );

                          if (_selectedPaymentT.contains(1)) {
                            //_initPayment(_isSelectedPay);
                          }
                        },
                        isSelected: _isSelected,
                      );
                    }),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          )),
    ];
  }

  String currentType = 'Select Hospital';
  var types = [
    'Select Hospital',
    'T.U. Teaching Hospital',
    'Bir Hospital',
    'Norvic International Hospital',
    'Patan Hospital',
    'Kathmandu Model Hospital',
  ];
  DropdownButtonFormField<String> getDropdownHospital() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String type in types) {
      var newItem = DropdownMenuItem(
          child: Text(
            '${type[0].toUpperCase()}${type.substring(1)}',
            style: kStyleHomeTitle.copyWith(color: Colors.grey.shade600),
          ),
          value: type);
      dropDownItems.add(newItem);
    }
    return DropdownButtonFormField(
      dropdownColor: Colors.white,
      style: kStyleHomeTitle.copyWith(color: kStyleCoolGrey),
      value: currentType,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          currentType = value!;
          hospital = currentType;
          print(currentType);
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: kBorder.copyWith(color: kStyleBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: kBorder.copyWith(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}

class PaymentOptions extends StatelessWidget {
  PaymentOptions(
      {required this.icon,
      required this.name,
      required this.onTap,
      required this.isSelected});

  final icon;
  final name;
  final onTap;
  final isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [boxShadow],
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 23,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: kStyleHomeTitle,
                  ),
                  Icon(
                    isSelected ? Icons.check_circle : Icons.circle,
                    color: isSelected ? kStyleBlue : Color(0xFFA3A3A3),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecheckResult extends StatelessWidget {
  RecheckResult({this.name, this.title});
  final title;
  final name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title: ',
            style: kStyleHomeTitle.copyWith(
              fontSize: 12.sp,
            ),
          ),
          Text(
            '$name',
            style: kStyleHomeTitle.copyWith(
              fontSize: 10.sp,
              color: kStyleGrey777,
            ),
          ),
        ],
      ),
    );
  }
}
