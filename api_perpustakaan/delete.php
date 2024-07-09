<?php
$koneksi = mysqli_connect ("localhost","root","","api_perpustakaan");
$id_pengunjung = $_POST['id_pengunjung'];
$data = mysqli_query($koneksi, "delete from tb_pengunjung where id_pengunjung='$id_pengunjung'");
if($data){
    echo json_encode(array('message' => 'deleted!'));
}else{
    echo json_encode(array('message' => 'error!'));
}
?>