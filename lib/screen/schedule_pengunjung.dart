import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perpustakaan/constant.dart';
import 'package:perpustakaan/model/create_model.dart';
import 'package:perpustakaan/model/delete_model.dart';
import 'package:perpustakaan/model/read_model.dart';
import 'package:perpustakaan/model/update_model.dart';

class SchedulePengunjung extends StatefulWidget {
  const SchedulePengunjung({super.key});

  @override
  State<SchedulePengunjung> createState() => _SchedulePengunjung();
}

class _SchedulePengunjung extends State<SchedulePengunjung> {
  String statusActive = 'Upcoming Visitors';
  late Future<List<ModelPengunjung>> futurePengunjung;

  @override
  void initState() {
    super.initState();
    futurePengunjung = fetchPengunjung();
  }

  Future<void> _refreshData() async {
    setState(() {
      futurePengunjung = fetchPengunjung();
    });
  }

  void _showModal(BuildContext context, {ModelPengunjung? pengunjung}) {
    final isEdit = pengunjung != null;
    final nameController =
        TextEditingController(text: isEdit ? pengunjung.name : '');
    final usiaController =
        TextEditingController(text: isEdit ? pengunjung.usia.toString() : '');
    final tujuanController =
        TextEditingController(text: isEdit ? pengunjung.tujuan : '');
    final dateController =
        TextEditingController(text: isEdit ? pengunjung.date : '');
    final rangeController =
        TextEditingController(text: isEdit ? pengunjung.range : '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: usiaController,
                  decoration: InputDecoration(labelText: 'Usia'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: tujuanController,
                  decoration: InputDecoration(labelText: 'Tujuan'),
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: rangeController,
                  decoration: InputDecoration(labelText: 'Range'),
                ),
                const Gap(20),
                ElevatedButton(
                  onPressed: () async {
                    if (isEdit) {
                      await updatePengunjung(
                        pengunjung.id,
                        nameController.text,
                        usiaController.text,
                        tujuanController.text,
                        dateController.text,
                        rangeController.text,
                      );
                    } else {
                      await addPengunjung(
                        nameController.text,
                        usiaController.text,
                        tujuanController.text,
                        dateController.text,
                        rangeController.text,
                      );
                    }
                    _refreshData();
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Text(
                    isEdit ? 'Update' : 'Add',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              const Gap(64),
              buildListStatus(),
              const Gap(20),
              Expanded(
                child: FutureBuilder<List<ModelPengunjung>>(
                  future: futurePengunjung,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data found'));
                    } else {
                      List<ModelPengunjung> listPengunjung = snapshot.data!;
                      return buildListPengunjung(listPengunjung);
                    }
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                _showModal(context);
              },
              backgroundColor: Colors.blue, // Ubah warna latar belakang
              foregroundColor: Colors.white,
              child: const Icon(Icons.group_add_sharp), // Ubah icon
            ),
          ),
        ],
      ),
    );
  }

  ListView buildListPengunjung(List<ModelPengunjung> listPengunjung) {
    return ListView.builder(
      itemCount: listPengunjung.length,
      padding: const EdgeInsets.only(bottom: 60),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        ModelPengunjung item = listPengunjung[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          margin: EdgeInsets.fromLTRB(
            24,
            index == 0 ? 0 : 8,
            24,
            index == listPengunjung.length - 1 ? 24 : 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: const Offset(2, 12),
                color: const Color(0xff5A75A7).withOpacity(0.1),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/${item.image}',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color(0xff0D1B34),
                            height: 1,
                          ),
                        ),
                        const Gap(8),
                        Row(
                          mainAxisSize: MainAxisSize
                              .min, // Menjaga Row agar sesuai dengan ukuran kontennya
                          children: [
                            const Icon(
                              Icons
                                  .cake, // Ganti dengan ikon yang Anda inginkan
                              color: Color(0xff8696BB),
                              size: 16, // Sesuaikan ukuran sesuai kebutuhan
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${item.usia} tahun',
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: const Color(0xff8696BB),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const Gap(8),
                        Text(
                          'Tujuan : ${item.tujuan}',
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: const Color(0xff8696BB),
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(20),
              const Divider(
                color: Color(0xffF5F5F5),
                height: 1,
                thickness: 1,
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const ImageIcon(
                          AssetImage(
                            'assets/ic_calendar.png',
                          ),
                          size: 16,
                          color: Color(0xff8696BB),
                        ),
                        const Gap(8),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            DateFormat('EEEE, d MMMM')
                                .format(DateTime.parse(item.date)),
                            style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: const Color(0xff8696BB),
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const ImageIcon(
                          AssetImage(
                            'assets/ic_clock.png',
                          ),
                          size: 16,
                          color: Color(0xff8696BB),
                        ),
                        const Gap(8),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${item.range} WITA',
                            style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: const Color(0xff8696BB),
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showModal(context, pengunjung: item);
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xff63B4FF)),
                      minimumSize: WidgetStatePropertyAll(Size(150, 40)),
                    ),
                    child: Text(
                      'Edit',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, item);
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 254, 72, 72)),
                      minimumSize: WidgetStatePropertyAll(Size(150, 40)),
                    ),
                    child: Text(
                      'Hapus',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, ModelPengunjung pengunjung) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                await deletePengunjung(pengunjung.id);
                _refreshData();
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  Widget buildListStatus() {
    final list = [
      'Deleted Visitors',
      'Upcoming Visitors',
      'Completed Visitors',
    ];
    return SizedBox(
      height: 50,
      child: PageView.builder(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.6,
        ),
        onPageChanged: (currentIndex) {
          statusActive = list[currentIndex];
          setState(() {});
        },
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          bool isActive = statusActive == list[index];
          return UnconstrainedBox(
            child: Container(
              decoration: BoxDecoration(
                color:
                    isActive ? const Color(0xff63B4FF).withOpacity(0.1) : null,
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              alignment: Alignment.center,
              child: Text(
                list[index],
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(isActive ? 0xff4894FE : 0xff8696BB),
                  height: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
