import 'package:axons/provider/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePin extends ConsumerStatefulWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  CreatePinState createState() => CreatePinState();
}

class CreatePinState extends ConsumerState<CreatePin> {
  String _input = "";
  String _pin = "";

  Widget _buildInputWidget() {
    final List<Widget> circles = List.generate(4, (index) {
      if (index < _input.length) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Icon(
            Icons.circle,
            size: 24,
            color: Colors.indigo,
          ),
        );
      } else {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Icon(
            Icons.circle,
            size: 24,
            color: Colors.grey,
          ),
        );
      }
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: circles,
    );
  }

  void _onDigitButtonPressed(String digit) {
    if (digit == 'backspace') {
      if (_input.isNotEmpty) {
        setState(() {
          _input = _input.substring(0, _input.length - 1);
        });
      }
    } else {
      if (_input.length < 4) {
        setState(() {
          _input += digit;
        });
        if (_input.length == 4) {
          if (_pin.isEmpty) {
            _pin = _input;
            _input = "";
          } else if (_pin == _input) {
            ref.read(pinProvider.notifier).state = _pin;
            Navigator.pop(context);
          }
        }
      }
    }
  }

  Widget _buildDigitButton(String digit) {
    return ElevatedButton(
      onPressed: () => _onDigitButtonPressed(digit),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        minimumSize: const Size(110, 45),
        elevation: 0,
      ),
      child: digit == 'backspace'
          ? const Icon(Icons.backspace_outlined)
          : Text(
              digit,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
    );
  }

  Widget _buildErrorMessage() {
    if (_input.length == 4) {
      if (_input != _pin) {
        return const Text(
          'Pincode ไม่ตรงกัน',
          style: TextStyle(color: Colors.red),
        );
      }
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.key,
              size: 200,
              color: Colors.indigo,
            ),
            Text(
              _pin.isEmpty ? 'สร้างรหัส Pincode 4' : "ยืนยันรหัส Pincode 4 อีกครั้ง",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "เพื่อรักษาข้อมูลข้องคุณให้ปลอดภัย",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 35),
            _buildInputWidget(),
            const SizedBox(height: 10),
            _buildErrorMessage(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDigitButton('1'),
                _buildDigitButton('2'),
                _buildDigitButton('3'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDigitButton('4'),
                _buildDigitButton('5'),
                _buildDigitButton('6'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDigitButton('7'),
                _buildDigitButton('8'),
                _buildDigitButton('9'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDigitButton(''),
                _buildDigitButton('0'),
                _buildDigitButton('backspace'),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
