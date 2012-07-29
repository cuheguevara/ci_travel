<?php  if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 * @author      : Suhendra yohana putra
 * @company     : CITSTUDIO
 * @email       : suhendra@citstudio.com
 * @URL         : http://citstudio.com
 * @License     : Totally Free 
 * @Donation    : We are very grateful if you can donate by paypal to yohanamxs@gmail.com, 
 *                  or via bank transfer for the development of this project
 * @doc         : Database Operations
 * @version     : 0.01
 * @Date        : 20 Feb 2012
 * @Engine      : Code Igniter 2.10
 * @Dependency  : CI_Model
 * @Content     : Select, Insert, Update, Delete, getting field value, generating formatted autonumber
 * @use         : 
 *      - Place this file in a libraries folder under application folder's
 *      - load this automatically or manually
 *      - Create new Instance for citDBase's Class
 *      - Call one function in a class
 * @example     : 
 *      $this->load->library('citDBase');
 *      $CIT = new citDBase();
 *      $result = $CIT->method(param);
 *      echo $result;
 */

class citfunctionset extends CI_Model{
    
    function __construct(){
        parent::__construct();
    }
    function getFirstLetter($string,$delimiter){
        $tStr = explode($delimiter, $string);
        $count = count($tStr);
        $str = "";
        $x = "";
        //echo $tStr[0];
        for($x=0;$x<$count;$x++){
            $str = $str.substr($tStr[$x], 0,1);
        }
        return strtoupper($str);
    }
}
?>