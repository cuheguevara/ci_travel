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

class Citdbase extends CI_Model{
     
    private $mytable = "";
    
    public function __construct(){
        parent::__construct('ci_session');
    }
    public function set_table($new_table){ return $this->mytable = $new_table; }
    public function get_table(){ return $this->mytable; }
    
    public function CIT_JQGRID($table,$sidx='', $sord='', $start='0', $limit='10',$opr='',$data='array'){
        $datax = array();
        $this->db->select("*");
        $this->db->from($table);
        if ($opr != ''){

            switch($opr){
                case 'like':
                        foreach($data as $key=>$val){ $this->db->like($key,$val); }
                        break;
                case 'equal':
                        foreach($data as $key=>$val){ 
                            $this->db->where($key,$val);

                        }
                        break;
            }
        }
        if (trim($sidx)!=''){
            $this->db->order_by($sidx,$sord);
        }

        $this->db->limit($limit,$start);

        $Q = $this-> db-> get();
        if ($Q-> num_rows() > 0){
            foreach ($Q-> result_array() as $row){
                    $datax[] = $row;
            }
        }
        $Q-> free_result();
        return $datax;
    }
    public function CIT_DMLSQL($sql_statement){
        $this->db->query($sql_statement);
        
        $Q = $this-> db-> get();
        if ($Q-> num_rows() > 0){
            foreach ($Q-> result_array() as $row){
                $record[] = $row;
            }
        }

        $Q-> free_result();
        return $record;
    }
    
    public function CIT_SELECT($table='',$opr='',$data='array',$ord='',$sort='asc',$limit=0,$start=0){
        $record = array();
        $this->db->select("*");
        $this->db->from($table);

        if ($opr != ''){
            switch($opr){
            case 'like':
                foreach($data as $key=>$val){
                    $this->db->like($key,$val);
                }
                break;
            case 'equal':
                foreach($data as $key=>$val){
                    $this->db->where($key,$val);
                }
            break;
            }
        }

        if (trim($ord)!=''){ $this->db->order_by($ord, $sort); }
        if (trim($limit)!='0'){ $this->db->limit($limit,$start); }

        $Q = $this-> db-> get();
        if ($Q-> num_rows() > 0){
            foreach ($Q-> result_array() as $row){
                $record[] = $row;
            }
        }

        $Q-> free_result();
        return $record;
    }
    public function CIT_INSERT($table,$data='array'){
        foreach($data as $key=>$val){
            $this->db->set($key,$val);
        }
        $q = $this->db->insert($table);
        return $q;
    }
    public function CIT_UPDATE($table,$data='array',$where='array'){
        $q = $this->db->update($table, $data, $where);
        return $q;
    }
    public function CIT_DELETE($mode='normal|empty|truncate',$table='my table',$where='array'){
        if($mode == "normal"){ //will produce DELETE FROM mytable WHERE .....
            if(is_array($where)){
                if(count($where)>0){
                    foreach($where as $key=>$val){
                        $this->db->where($key,$val);
                    }
                    $q = $this->db->delete($table); 
                }else{
                    $q = $this->db->delete($table); 
                }
            }else{
                $q = $this->db->delete($table); 
            }
        }elseif($mode=='empty'){ //will produce DELETE FROM mytable
            $q = $this->db->empty_table($table); 
        }elseif($mode=='truncate'){ //will produce DELETE FROM mytable
                    $this->db->from($table); 
            $q      = $this->db->truncate(); 
        }
        return $q;
    }
    public function CIT_GETSOMETHING($field,$table,$data='array'){
        $this->db->select($field);
        foreach($data as $key=>$val){
            $this->db->where($key,$val);
        }
        
        $record=array();
        $Q = $this-> db-> get($table);
        if ($Q-> num_rows() > 0){
            foreach ($Q-> result_array() as $row){
                $record[] = $row;
            }
        }
        $result = "";     
        
        $Q-> free_result();
        foreach ($record as $rs){
            $result = $rs[$field];
        }
        return $result;     
    }
    public function CIT_AUTONUMBER($table,$where,$Parse,$Digit_Count){
        $NOL="0";

        $data = array();
        $this->db->select("*");
        $this->db->from($table);
        $this->db->like($where,$Parse,'after');
        $this->db->order_by($where, "desc");
        $this->db->limit(1, 0);

        $counter=2;

        $Q = $this-> db-> get();
        if ($Q-> num_rows() == 0){
            while ($counter < $Digit_Count){
                $NOL = "0".$NOL;
                $counter++;
            }
            return $Parse.$NOL."1";
        }else{
            foreach ($Q-> result_array() as $row){
                $data[] = $row;
            }
            
            $Q-> free_result();

            foreach ($data as $value) {
                $maxID = $value[$where];
            }

            $K = sprintf("%d",substr($maxID,-$Digit_Count));
            $K = $K + 1;
            $L = $K;
            while(strlen($L)!=$Digit_Count)
            {
                $L = $NOL.$L;
            }
            return $Parse.$L;

            
        }
    }
    
}

?>