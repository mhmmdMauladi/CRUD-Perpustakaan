<?php
$koneksi = mysqli_connect ("localhost","root","","api_perpustakaan");
$query = mysqli_query($koneksi, "select * from tb_pengunjung");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);
?>