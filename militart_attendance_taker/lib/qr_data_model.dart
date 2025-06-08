class QrDataModel {
  String? student_name;
  String? national_id;
  String? serial_number;
  String? student_phone_number;
  String? faculty;
  String? address;
  String? date;
  String? day;
  String? arrival_time;
  String? leave_time;
  DateTime? created_at;

  QrDataModel({
    required this.student_name,
    required this.national_id,
    required this.serial_number,
    required this.student_phone_number,
    required this.faculty,
    required this.address,
    required this.date,
    required this.day,
    required this.arrival_time,
    required this.leave_time,
    required this.created_at,
  });
  @override
  String toString() {
    return "$student_name ||| $national_id ||| $serial_number |||  $student_phone_number |||  $faculty |||  $address |||  $date |||  $day |||  $arrival_time |||  $leave_time";
  }

  Map<String, dynamic> toMap() => {
    'student_name': student_name,
    'national_id': national_id,
    'serial_number': serial_number,
    'student_phone_number': student_phone_number,
    'faculty': faculty,
    'address': address,
    'date': date,
    'day': day,
    'arrival_time': arrival_time,
    'leave_time': leave_time,
    "created_at": created_at,
  };
  static QrDataModel fromJson(Map e) {
    return QrDataModel(
      student_name: e['student_name'],
      national_id: e['national_id'],
      serial_number: e['serial_number'],
      student_phone_number: e['student_phone_number'],
      faculty: e['faculty'],
      address: e['address'],
      date: e['date'],
      day: e['day'],
      arrival_time: e['arrival_time'],
      leave_time: e['leave_time'],
      created_at: e['created_at'],
    );
  }
}
