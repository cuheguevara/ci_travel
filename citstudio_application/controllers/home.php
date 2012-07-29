<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Home extends CI_Controller {
    
    function __construct(){ parent::__construct();
    
    
    
    }

    public function index(){
        /* mendeklarasikan, meng-inisialisasi variable usernip sebagai penampun session nip */
        $usernip = $this->session->userdata('nip');
        /* pengecekan, apakah sudah ada yang login atau belum */
        if (($usernip == '') || (!isset ($usernip))) 
        {
            /* jika belum login, halaman akan terlempar ke halaman login */
            $this->load->view('login_form');
        }
        else
        {
            /* jika sudah login, maka akan terlempar ke halaman admin*/
            redirect('dashboard');
        }
    }
}