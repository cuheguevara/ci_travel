<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Dashboard extends CI_Controller {

    function __construct()
    {
        parent::__construct();
        /* mendeklarasikan, meng-inisialisasi variable usernip sebagai penampun session nip */
        $usernip = $this->session->userdata('nip');
        /* pengecekan, apakah sudah ada yang login atau belum */
        if (($usernip == '') || (!isset ($usernip))) 
        {
            /* jika belum login, halaman akan terlempar ke halaman login */
            $this->load->view('login_form');
        }
        else{ }
    }
    public function index(){
        /* inisialisasi variable yang dibutuhkan pada template dan form utama admin */
        $data = array(
            'mainview'=>'dashboard/view_dashboard'
            ,'information_message'=>'SELAMAT DATANG DI HALAMAN ADMINISTRATOR'
            ,'title'=>'DASHBOARD '.APP_NAME);
        $this->parser->parse('layout_dashboard/maintemplate',$data);
    }
}
