<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Log extends CI_Controller {
    
    function __construct()
    {
        parent::__construct();
        $this->load->library('logviewer');
        // Run 
        $this->logviewer->run();

    }
    public function index(){
        //echo $messages;
        $this->load->view('Logviewer/default/index');
    }
}

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
?>
