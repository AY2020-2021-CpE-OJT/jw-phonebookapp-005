import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'create_confirmed.dart';

class ContactData {
  final String lastName;
  final String firstName;
  final List<String> phoneNumbers;

  ContactData(this.lastName, this.firstName, this.phoneNumbers);
}

class CreateNewContact extends StatefulWidget {
  @override
  _CreateNewContactState createState() => _CreateNewContactState();
}

class _CreateNewContactState extends State<CreateNewContact> {
  int checkAdd = 0, listNumber = 1, _count = 1;
  String val = '';
  RegExp digitValidator = RegExp("[0-9]+");

  bool isANumber = true;
  String fname = '', lname = '';

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();

  List<TextEditingController> pnumControllers = <TextEditingController>[TextEditingController()];

  FocusNode fnameFocus = FocusNode();
  FocusNode lnameFocus = FocusNode();

  List<ContactData> contactsAppend = <ContactData>[];

  void saveContact() {
    List<String> pnums = <String>[];
    for (int i = 0; i < _count; i++) {
      pnums.add(pnumControllers[i].text);
    }
    List<String> reversedpnums = pnums.reversed.toList();
    setState(() {
      contactsAppend.insert(0, ContactData(lnameController.text, fnameController.text, reversedpnums));
    });
    print('Status Append Contacts [Success]');
  }

  @override
  void initState() {
    super.initState();
    _count = 1;
    fnameFocus = FocusNode();
    lnameFocus = FocusNode();
  }

  @override
  void dispose() {
    fnameFocus.dispose();
    lnameFocus.dispose();

    fnameController.dispose();
    lnameController.dispose();
    for (int i = 0; i < _count; i++) {
      pnumControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create New", style: TextStyle(color: Color(0xFF5B3415))),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                checkAdd = 0;
                listNumber = 1;
                _count = 1;
                fnameController.clear();
                lnameController.clear();
                pnumControllers.clear();
                pnumControllers = <TextEditingController>[TextEditingController()];
              });
            },
          )
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "New Contact",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5B3415)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: fnameController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                focusNode: fnameFocus,
                onTap: _requestFocusFname,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, fnameFocus, lnameFocus);
                },
                decoration: new InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                  ),
                  disabledBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  labelText: 'First name',
                  labelStyle: TextStyle(
                    color: fnameFocus.hasFocus ? Color(0xFF5B3415) : Colors.grey,
                  ),
                  prefixIcon: Icon(Icons.account_box_rounded, color: Theme.of(context).primaryColor),
                  suffixIcon: IconButton(
                    onPressed: fnameController.clear,
                    icon: Icon(Icons.cancel, color: Theme.of(context).primaryColor.withOpacity(0.4)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lnameController,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                focusNode: lnameFocus,
                onTap: _requestFocusLname,
                decoration: new InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                  ),
                  disabledBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  labelText: 'Last Name',
                  labelStyle: TextStyle(
                    color: lnameFocus.hasFocus ? Color(0xFF5B3415) : Colors.grey,
                  ),
                  prefixIcon: Icon(Icons.account_box_rounded, color: Theme.of(context).primaryColor),
                  suffixIcon: IconButton(
                    onPressed: lnameController.clear,
                    icon: Icon(Icons.cancel, color: Theme.of(context).primaryColor.withOpacity(0.4)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Contact Number/s: $listNumber", style: TextStyle(color: Color(0xFF5B3415))),
              SizedBox(height: 20),
              Flexible(
                child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: _count,
                    itemBuilder: (context, index) {
                      return _row(index, context);
                    }),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: const Text("Confirm",
                            style: TextStyle(
                              color: Color(0xFF5B3415),
                              fontWeight: FontWeight.bold,
                            )),
                        content: const Text("Confirm creating this contact"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text("CANCEL", style: TextStyle(color: Colors.redAccent))),
                          TextButton(
                            onPressed: () {
                              saveContact();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => CreateConfirmed(todo: contactsAppend)),
                                  (_) => false);
                            },
                            child: const Text("CONFIRM", style: TextStyle(color: Color(0xFFFCC13A))),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.save),
                label: Text("Save"),
                foregroundColor: Color(0xFFFCC13A),
                backgroundColor: Color(0xFF5B3415),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _row(int key, context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            controller: pnumControllers[key],
            textCapitalization: TextCapitalization.sentences,
            onTap: () {
              setState(() {
                lnameFocus.hasFocus ? Color(0xFF5B3415) : Colors.grey;
                fnameFocus.hasFocus ? Color(0xFF5B3415) : Colors.grey;
              });
            },
            maxLength: 13,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            decoration: new InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
              ),
              disabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.redAccent,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.redAccent,
                ),
              ),
              errorText: isANumber ? null : "Please enter a number",
              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              labelText: 'Phone number',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              prefixIcon: Icon(Icons.phone_android_rounded, color: Theme.of(context).primaryColor),
              suffixIcon: IconButton(
                onPressed: pnumControllers[key].clear,
                icon: Icon(Icons.cancel, color: Theme.of(context).primaryColor.withOpacity(0.4)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: 24,
            height: 24,
            child: _addRemoveButton(key == checkAdd, key),
          ),
        ),
      ],
    );
  }

  void setValidator(valid) {
    setState(() {
      isANumber = valid;
    });
  }

  Widget _addRemoveButton(bool isTrue, int index) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (isTrue) {
          setState(() {
            _count++;
            checkAdd++;
            listNumber++;
            pnumControllers.insert(0, TextEditingController());
          });
        } else {
          setState(() {
            _count--;
            checkAdd--;
            listNumber--;
            pnumControllers.removeAt(index);
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: (isTrue) ? Color(0xFFFCC13A) : Colors.redAccent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Icon(
          (isTrue) ? Icons.add : Icons.remove,
          color: Colors.white70,
        ),
      ),
    );
  }

  void _requestFocusFname() {
    setState(() {
      FocusScope.of(context).requestFocus(fnameFocus);
    });
  }

  void _requestFocusLname() {
    setState(() {
      FocusScope.of(context).requestFocus(lnameFocus);
    });
  }
}

_fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
