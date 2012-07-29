<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Trefmanufaktur extends CI_Controller {

    private $nomor_manufaktur_baru;
    private $table;
    private $primaryKey;
    private $username;
    private $conn;
    
    function __construct(){
        
        parent::__construct();
        
        /* mendeklarasikan, meng-inisialisasi variable usernip sebagai penampun session nip */
        $this->usernip = $this->session->userdata('nip');
        
        /* membangun koneksi dengan melakukan panggilan class citdbase */
        $this->conn = new Citdbase();
        
        /* pengecekan, apakah sudah ada yang login atau belum */
        if (($this->usernip == '') || (!isset ($this->usernip))) 
        {
            /* jika belum login, halaman akan terlempar ke halaman login */
            redirect('home', 'refresh');
            
            /* jika tidak berhasil tukarkan dengan perintah ini */
            //  $this->load->view('login_form');
        }
        else{
            /* inisialisasi sql statement untuk memanggil stored procedure */
            $sql       = "call sp_GetUserByNIP(?)";
            
            /* ekseskusi stored procedure */
            $result    = $this->db->query($sql, array(mysql_escape_string($this->usernip)),TRUE)->result();
            
            /* retrieve nilai/hasil dari hasil eksekusi stored procedure */
            foreach ($result as $row) {
                $this->username = $row->username;
            }
        }
        
        /* inisialisasi nama table dan primarykey dari table */
        $this->table = "tref_manufaktur";
        $this->primaryKey = "manufakturID";
        
        /* inisialisasi nomor manufaktur baru */
        $this->nomor_manufaktur_baru=  $this->conn->CIT_AUTONUMBER($this->table, $this->primaryKey, 'M', '2');
    }

    public function index(){
        /* inisialisasi variable yang dibutuhkan pada template dan form utama admin */
        $view = array(
            'mainview'=>'view_tref_manufaktur'
            ,'namaform'=>'FORM MANUFAKTUR'
            ,'information_message'=>'REFERENSI MANUFAKTUR'
            ,'title'=>'DASHBOARD '.APP_NAME);
        
        /* inisialisasi nilai textbox */
        $textbox = array('manufakturID'=>  $this->nomor_manufaktur_baru
                , 'manufakturNama'=>'');
        
        /* merge array */
        $data = array_merge($view,$textbox);
        
        /* render */
        $this->load->view('view_tref_manufaktur',$data);
    }
  
    /* mendapatkan data record dari berdasarkan record yang dipilih pada grid */
    public function getDataManufaktur(){
        /* mendapatkan variabel post manufakturID */
        $manufakturID   = $_POST["manufakturID"]; 
        
        /* mendapatkan nilai yang dibutuhkan berdasarkan variabel yang dikirim */
        $manufakturNama = $this->conn->CIT_GETSOMETHING('manufakturNama', $this->table, array($this->primaryKey=>$manufakturID));
        
        /* simpan nilai yang dibutuhkan berdasarkan variabel yang dikirim kedalam variabel array untuk diencode kedalam bentuk jSon */
        $return = array('manufakturNama'=>$manufakturNama);
        
        echo json_encode($return);
        
    }

    /* menghapus record */
    public function delete(){
        
        /* mendapatkan variabel post dari text-box id manufaktur pada view */
        $manufakturID   = $_POST["manufakturID"]; 
        $manufakturNama   = $_POST["manufakturNama"]; 
        
        /* deklarasi nilai balik proses penyimpanan */
        $return = array();
        
        /* inisialisasi sql statement untuk memanggil stored procedure */
        $sql       = "call sp_manufaktur_delete(?,?,?,?)";

        /* ekseskusi stored procedure, dengan memberikan parameter yang dibutuhkan oleh stored procedure */
        $result    = $this->db->query($sql
                , array(
                    mysql_escape_string($manufakturID)
                    , mysql_escape_string($manufakturNama)
                    , $_SERVER["REMOTE_ADDR"]
                    , $this->username
                    ),TRUE)->result();

        /* inisialisasi hasil kembalian pemanggilan stored procedure */
        $hasil = 0;
        foreach ($result as $row) {
            $hasil = $row->HASIL;
        }

        if($hasil == 'OK'){
            /* jika OK, maka tampilkan pesan berhasil */
            $return = array('alert'=>'<h4 class="alert_success">DATA BERHASIL DIHAPUS</h4>');
        }else{
            /* jika NOK, maka tampilkan pesan gagal */
            $return = array('alert'=>'<h4 class="alert_error">DATA GAGAL DIHAPUS</h4>');
        }
            
        /* render pesan sebagai nilai balik */
        echo json_encode($return);
    }
    
    /* merubah data */
    public function update(){
        /* mendapatkan variabel post dari text-box nama manufaktur pada view */
        $manufakturNama = $_POST["manufakturNama"];
        
        /* mendapatkan variabel post dari text-box id manufaktur pada view */
        $manufakturID   = $_POST["manufakturID"]; 
        
        /* deklarasi nilai balik proses penyimpanan */
        $return = array();
        
        /* jika nama manufaktur tidak kosong, maka eksekusi stored procedure penyimpanan manufaktur */
        if((isset($manufakturNama)) && (trim($manufakturNama)!="")){
            
            /* inisialisasi sql statement untuk memanggil stored procedure */
            $sql       = "call sp_manufaktur_update(?,?,?,?)";
            
            /* ekseskusi stored procedure, dengan memberikan parameter yang dibutuhkan oleh stored procedure */
            $result    = $this->db->query($sql
                    , array(
                        mysql_escape_string($manufakturID)
                        , mysql_escape_string($manufakturNama)
                        , $_SERVER["REMOTE_ADDR"]
                        , $this->username
                        ),TRUE)->result();
            
            /* inisialisasi hasil kembalian pemanggilan stored procedure */
            $hasil = 0;
            foreach ($result as $row) {
                $hasil = $row->HASIL;
            }
            
            if($hasil == 'OK'){
                /* jika OK, maka tampilkan pesan berhasil */
                $return = array('alert'=>'<h4 class="alert_success">DATA BERHASIL DISIMPAN</h4>');
            }else{
                /* jika NOK, maka tampilkan pesan gagal */
                $return = array('alert'=>'<h4 class="alert_error">DATA GAGAL DISIMPAN</h4>');
            }
        }else{
            /* jika nama manufaktur kosong, maka tampilkan pesan error */
            $return = array('alert'=>'<h4 class="alert_error">A Success Message</h4>');
        }
                
        /* render pesan sebagai nilai balik */
        echo json_encode($return);
    }
    
    /* memasukan data baru */
    public function entry(){
        /* mendapatkan variabel post dari text-box nama manufaktur pada view */
        $manufakturNama = $_POST["manufakturNama"];
        
        /* mendapatkan variabel post dari text-box id manufaktur pada view */
        /* $manufakturID   = $_POST["manufakturID"]; */
        
        /* karena proses insert, dan menghindari duplikasi entry pada kolom manufakturID, generate ulang untuk ID Manufaktur */
        $manufakturID   = $this->conn->CIT_AUTONUMBER($this->table, $this->primaryKey, 'M', '2');
        
        /* deklarasi nilai balik proses penyimpanan */
        $return = array();
        
        /* jika nama manufaktur tidak kosong, maka eksekusi stored procedure penyimpanan manufaktur */
        if((isset($manufakturNama)) && (trim($manufakturNama)!="")){
            
            /* inisialisasi sql statement untuk memanggil stored procedure */
            $sql       = "call sp_manufaktur_insert(?,?,?,?)";
            
            /* ekseskusi stored procedure, dengan memberikan parameter yang dibutuhkan oleh stored procedure */
            $result    = $this->db->query($sql
                    , array(
                        mysql_escape_string($manufakturID)
                        , mysql_escape_string($manufakturNama)
                        , $_SERVER["REMOTE_ADDR"]
                        , $this->username
                        ),TRUE)->result();
            
            /* inisialisasi hasil kembalian pemanggilan stored procedure */
            $hasil = 0;
            foreach ($result as $row) {
                $hasil = $row->HASIL;
            }
            
            if($hasil == 'OK'){
                /* jika OK, maka tampilkan pesan berhasil */
                $return = array('alert'=>'<h4 class="alert_success">DATA BERHASIL DISIMPAN</h4>');
            }else{
                /* jika NOK, maka tampilkan pesan gagal */
                $return = array('alert'=>'<h4 class="alert_error">DATA GAGAL DISIMPAN</h4>');
            }
        }else{
            /* jika nama manufaktur kosong, maka tampilkan pesan error */
            $return = array('alert'=>'<h4 class="alert_error">A Success Message</h4>');
        }
                
        /* render pesan sebagai nilai balik */
        echo json_encode($return);
    }
    
    /* menampilkan data */
    public function gridManufaktur(){
        /* inisialisasi variable index untuk melakukan sorting pada grid */
        $sidx = $_REQUEST['sidx'];
        
        /* inisialisasi metode sorting pada grid */
        $sord = $_REQUEST['sord'];
        
        /* inisialisasi halaman yang sedang diakses pada grid */
        $page = $_REQUEST['page'];
        
        /* inisialisasi jumlah row yang diakses setiap kali tampil grid */
        $limit = $_REQUEST['rows'];

        /* inisialisasi koneksi */
        // $cn     = new Citdbase(); jika tidak menggunakan variable global
        $data   = $this->conn->CIT_JQGRID('tref_manufaktur');
        
        /* mendapatkan jumlah data */
        $count  =  count($data);

        /* jika data > 0 , total halaman adalah hasil pembulatan dari jumlah data dibagi batas data yang tampil */
        /* jika data = 0 , total halaman adalah 0 */
        if( $count > 0 ) {
            $total_pages = ceil($count/$limit);
        } else {
            $total_pages = 0;
        }

        /* jika halaman > jumlah halaman , halaman = jumlah halaman*/
        if ($page > $total_pages) $page=$total_pages;

        /* mendapatkan nilai awal untuk query */
        $start = $limit*$page - $limit;

        /* jika nilai awal < 0 , maka nilai awal di set menjadi 0*/
        if ($start<0) $start=0;

        /* membentuk queri dengan limit dan start*/
        $row = $this->conn->CIT_JQGRID('tref_manufaktur',$sidx, $sord, $start, $limit);

        $responce->page = $page;
        $responce->total = $total_pages;
        $responce->records = $count;

        $i=0;
        $rowId = 1;

        /* extract data hasil eksekusi dan tempelkan pada array untuk dimasukan kedalam grid*/
        foreach ($row as $val => $r) {
            $responce->rows[$i]['manufakturID']=$r['manufakturID'];
            $responce->rows[$i]['cell']=array(
                $r['manufakturID'],
                $r['manufakturNama']
            );
        $i++;
        }
        /* encode array kedalam bentuk json */
        echo json_encode($responce);
    }
    
    public function getExcel(){
        $result = $this->conn->CIT_SELECT($this->table);
        
        $this->load->library('PHPExcel');
        $this->load->library('PHPExcel/IOFactory');

        $objPHPExcel = new PHPExcel();
        $objPHPExcel->getProperties()->setTitle("title")
                    ->setDescription("description");
        // Assign cell values
        $objPHPExcel->setActiveSheetIndex(0);
        $sheet = $objPHPExcel->getActiveSheet();
        $sheet->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
        $styleArray = array(
          'borders' => array(
            'allborders' => array(
              'style' => PHPExcel_Style_Border::BORDER_THIN
            )
          )
        );
        
        $sheet->setShowGridlines(false);
        $sheet->getColumnDimension('A')->setWidth(10);
        $sheet->getColumnDimension('B')->setWidth(21.57);
        
        $sheet->getRowDimension('1')->setRowHeight(10);
        
        $sheet->setCellValue('A1', 'ID MANUFAKTUR');
        $sheet->setCellValue('B1', 'NAMA MANUFAKTUR');
        
        $counter = 2;
        foreach ($result as $row){
            $sheet->setCellValue('A'.$counter, $row["manufakturID"]);
            $sheet->setCellValue('B'.$counter, $row["manufakturNama"]);
            $counter++;
        }
         // Save it as an excel 2003 file
        $objWriter = IOFactory::createWriter($objPHPExcel, 'Excel5');
        $filename = date('dmYHis')."-manufaktur.xls";
        $path = "./".ASSETS.'userfiles/'.$filename;
        $objWriter->save($path);
        
        $result = array();
        $result = array("alert"=>"<h4 class=\"alert_success\">FILE BERHASIL DI EXPORT. <a href=\"".$path."\">KLIK UNTUK MENGUNDUH FILE</a></h4>");
        echo json_encode($result);
        
        //echo $filename;
        
    }
    
}