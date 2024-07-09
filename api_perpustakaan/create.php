<?php
$koneksi = mysqli_connect("localhost", "root", "", "api_perpustakaan");

if (!$koneksi) {
    die("Connection failed: " . mysqli_connect_error());
}

$nama = $_POST['nama'];
$usia = $_POST['usia'];
$tujuan = $_POST['tujuan'];
$date = $_POST['date'];
$range = $_POST['range'];

$sql = "INSERT INTO tb_pengunjung (nama, usia, tujuan, date, `range`) VALUES ('$nama', '$usia', '$tujuan', '$date', '$range')";
$data = mysqli_query($koneksi, $sql);

if ($data) {
    echo json_encode(array('message' => 'created!'));
} else {
    echo json_encode(array('message' => 'error!', 'error' => mysqli_error($koneksi)));
}

mysqli_close($koneksi);
?>
