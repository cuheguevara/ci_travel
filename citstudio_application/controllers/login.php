<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Login extends CI_Controller {
    function __construct() 
    {
            parent::__construct();
            $this->load->helper(array('form', 'url'));
            $this->load->library('upload');
    }
    
    public function index(){ $this->load->view('view_home'); }
    
    public function proses_login(){
        /* menampung variable textbox dari view login */
        $username = $_REQUEST["username"];
        $password = $_REQUEST["password"];
        
        /* pemanggilan stored procedure  */
        $sql       = "call sp_GetUserByUserNameAndPassword(?,?)";
        $result    = $this->db->query($sql, array(mysql_escape_string($username),mysql_escape_string($password)),TRUE)->result();
        
        /* jika hasil eksekusi memberikan jumlah record minimal 1, maka extract data, dan masukan kedalam session*/
        if (count($result) > 0){
            /* definisi dan inisialisasi array */
            $sessionUserData = array();
            /* extract data */
            foreach($result as $row){
                $sessionUserData = array(
                    'uname' => $row->username
                    , 'nip' => $row->nip
                );
            }
            $this->session->set_userdata($sessionUserData);
            redirect('dashboard', 'refresh');
                         
        }else{
            redirect('home', 'refresh');
        }
    }
}