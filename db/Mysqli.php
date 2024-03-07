<?php
class Mysql
{
    public static function mysqliConn()
    {
        $mysqli = new mysqli("localhost", "root", "", "m7_prac_uf3");

        if ($mysqli->connect_error)
        {
            return null;
        }

        return $mysqli;
    }
}