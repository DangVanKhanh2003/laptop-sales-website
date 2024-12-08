import 'package:admin/model/customer_info.dart';
import 'package:admin/repository/customer_repository.dart';
import 'package:admin/screen/exception/exception_page.dart';
import 'package:admin/screen/user/add_user.dart';
import 'package:admin/screen/user/edit_user.dart';
import 'package:admin/service/getit_helper.dart';
import 'package:admin/service/toast_helper.dart';
import 'package:flutter/material.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  late List<CustomerAccount> data;

  @override
  void initState() {
    super.initState();
  }

  void _showToast({
    required String message,
    required bool isSuccess,
  }) {
    ToastHelper.showToast(
      context: context,
      message: message,
      color: isSuccess ? Colors.green : Colors.red,
    );
  }

  void _onDelete({
    required int customerId,
    required String guid,
  }) async {
    try {
      final state = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Xóa người dùng'),
          content: Text('Bạn có chắc chắn muốn xóa người dùng mã $customerId?'),
          actions: [
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Đồng ý',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
      if (state) {
        await GetItHelper.get<CustomerRepository>().deleteCustomer(
          guid: guid,
        );
        _showToast(message: 'Xóa người dùng thành công', isSuccess: true);
        setState(() {});
      }
    } catch (e) {
      _showToast(message: 'Lỗi xảy ra: ${e.toString()}', isSuccess: false);
    }
  }

  void _onEdit(String email) async {
    try {
      final user = <String, String>{'password': ''};
      final state = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Sửa người dùng'),
          content: EditUser(user: user),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Hoàn tất'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Hủy'),
            ),
          ],
        ),
      );
      if (state) {
        await GetItHelper.get<CustomerRepository>().updateCustomerPassword(
          email: email,
          password: user['password']!,
        );
        _showToast(message: 'Sửa người dùng thành công', isSuccess: true);
        setState(() {});
      }
    } catch (e) {
      _showToast(message: 'Lỗi xảy ra: ${e.toString()}', isSuccess: false);
    }
  }

  Widget _buildTable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 40,
              headingRowHeight: 50,
              columns: _buildColumns(),
              rows: _buildRows(data),
            ),
          ),
        );
      },
    );
  }

  List<DataColumn> _buildColumns() {
    return const [
      DataColumn(
        label: Text(
          'Mã người dùng',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Tên người dùng',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Icon người dùng',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Thao tác',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  List<DataRow> _buildRows(List<CustomerAccount> users) {
    return users.map((user) {
      return DataRow(
        cells: [
          DataCell(Text(user.customerId.toString())),
          DataCell(Text('${user.accCustomerId}')),
          DataCell(Text('${user.email}')),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  color: Colors.blue,
                  onPressed: () => _onEdit(user.email!),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                  onPressed: () => _onDelete(
                    customerId: user.customerId!,
                    guid: user.accCustomerId!,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  void _onAdd() async {
    try {
      final user = <String, String>{
        'email': '',
        'password': '',
      };
      final state = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Thêm người dùng'),
          content: AddUser(
            user: user,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Thêm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Hủy'),
            ),
          ],
        ),
      );
      if (state) {
        await GetItHelper.get<CustomerRepository>().register(
          email: user['email']!,
          password: user['password']!,
        );
        _showToast(message: 'Thêm người dùng thành công', isSuccess: true);
        setState(() {});
      }
    } catch (e) {
      _showToast(message: 'Lỗi xảy ra: ${e.toString()}', isSuccess: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetItHelper.get<CustomerRepository>().getAllCustomer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: ExceptionPage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          data = snapshot.data!;
          data.sort((a, b) => a.customerId! - b.customerId!);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                        ),
                        onPressed: _onAdd,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          child: Text(
                            'Thêm',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _buildTable(),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Không có người dùng để load'),
          );
        }
      },
    );
  }
}
