<?php
$koneksi = mysqli_connect("localhost", "root", "", "api_perpustakaan");

if (!$koneksi) {
    die("Connection failed: " . mysqli_connect_error());
}

$id_pengunjung = $_POST['id_pengunjung'];
$nama = $_POST['nama'];
$usia = $_POST['usia'];
$tujuan = $_POST['tujuan'];
$date = $_POST['date'];
$range = $_POST['range'];

$sql = "UPDATE tb_pengunjung SET nama='$nama', usia='$usia', tujuan='$tujuan', date='$date', `range`='$range' WHERE id_pengunjung='$id_pengunjung'";
$data = mysqli_query($koneksi, $sql);

if ($data) {
    echo json_encode(array('message' => 'updated!'));
} else {
    echo json_encode(array('message' => 'error!', 'error' => mysqli_error($koneksi)));
}

mysqli_close($koneksi);
?>
