<?php
if($_POST){

    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "flight_reservation";
    $table = "Users";

    $conn = new mysqli($servername, $username, $password, $dbname);

    $email = $_POST['email'];
    $password = $_POST['password'];

    $consult = $conn->query("SELECT * FROM $table WHERE email = '".$email."' and password = '".$password."'");

    $result = array();

    while($extractdata = $consult->fetch_assoc()) {
        $result[] = $extractdata;
    }

    echo json_encode($result);
}else{
    echo "hicbir veri post edilmedi";
}
?>