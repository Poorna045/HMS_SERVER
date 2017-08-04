<?php

class Api_model extends CI_Model
{
    function __construct()
    {
        parent::__construct();

        $this->load->database();
        $CI =   &get_instance();
        $this->db2 = $this->load->database('db2', TRUE);   
    }
    
    // validate login details
    function login($username, $password){
        $this->db->where('reg_no', $username);
        $this->db->where('password', md5($password));
        $this->db->limit(1);
        $ugt = $this->db->get('users');
        $cnt = $ugt->num_rows();

        if ($cnt) {
            $data = $ugt->row();
            return array("success"=>true, "reg_no"=>$data->reg_no, "utype"=>$data->utype, "name"=>$data->name);
        } 
        else {
            return array("success"=>false, "error"=>$username);
        }
    }

   

   


    // ###################
    // colleges list for form
    function allCollegesAndDepts($reg_no, $params) {
        $utype = $params[0];
        if($utype == "adm" || $utype == "stf") {
            if($utype == 'stf')
                $roll = $this->db->query("select count(*) as count from raghuerp_db1.staff where reg_no='".$reg_no."' and roll='ps' and status='1' ")->row()->count;
            else
                $roll = true;
            if($roll) {
                $college_data = $this->db->query("select * from colleges where status=1 order by college asc")->result();
                $dept_rs = $this->db->query("select * from departments where status = 1 order by department asc")->result();

                foreach($dept_rs as $dp) {
                    $depts[$dp->college][] = $dp;
                }
            } 
            else {
                $college_data = [];
                $depts = [];
            }
        } 
        else {
            $college_data = [];
            $depts = [];
        }

        $return['success'] = true;
        $return['colleges'] = $college_data;
        $return['departments'] = $depts;
        return $return;
    }
    
    // gettign designations data
    function getDesignations($reg_no, $params){
        $utype = $params[0];
        if($utype == "adm") {
            $data = $this->db->query("select * from raghuerp_db1.designations where status=1")->result();
        } 
        else if($utype == "stf") {
            $roll = $this->db->query("select count(*) as count from raghuerp_db1.staff where reg_no='".$reg_no."' and roll='ps' and status='1' ")->row()->count;
            if($roll) {
                $data = $this->db->query("select * from raghuerp_db1.designations where status=1")->result();
            } 
            else {
                $data = [];
            }
        } 
        else {
            $data = [];
        }
        $return['success'] = true;
        $return['data'] = $data;
        return $return;
    }
    


    
    // designation get
    public function getdesignationss(){
        $sql="select * from designations";
        $data=$this->db->query($sql);
        return $data->result();         
    }
    // year update
     public function updateyear($data){
       $this->db->where('id',$data['id']);
       $this->db->update('year',$data);         
    }


    // add new booking
     public function addbooking($data){
         
         $this->db->insert('raghuerp_hostel.bookings',$data);
             
    }
    // Edit booking
     public function editbooking($data){
         
             $this->db->where('bid',$data['bid']); 
             $this->db->update('raghuerp_hostel.bookings',$data); 
        
    }
     // delete booking
     public function deletebooking($data){
          
        $this->db->query("DELETE FROM raghuerp_hostel.bookings WHERE raghuerp_hostel.bookings.bid = ".$data['bid'].""); 
        
    }

    // update fee configuration
     public function updatefeeconfig($data){
         $roomtype=$data['roomtype'];
         $totalamount=$data['totalamount'];
         $totaldues=$data['totaldues'];
         $amtperdue=$totalamount/$totaldues;
         $sql="update raghuerp_hostel.feeconfig f set f.roomtype='$roomtype',f.totalamount='$totalamount',f.totaldues='$totaldues'  ";
       $this->db->insert('raghuerp_hostel.feeconfig',$data);
             
    }

     // insert fee configuration
     public function feeconfig($data){
         $roomtype=$data['roomtype'];
         $totalamount=$data['totalamount'];
         $totaldues=$data['totaldues'];
         $data['amt_perdue']=$totalamount/$totaldues;
         
        //  $sql="update raghuerp_hostel.feeconfig f set f.roomtype='$roomtype',f.totalamount='$totalamount',f.totaldues='$totaldues'  ";
       $this->db->insert('raghuerp_hostel.feeconfig',$data);
             
    }

        // add room config
     public function addroomconfig($data){
            $roomno=$data['roomno'];
            $htype=$data['hosteltype'];
            $datas=$this->db->query("select * from raghuerp_hostel.roomsconfig where roomno = '$roomno' and hosteltype='$htype'")->result();

            if(sizeof($datas)==0){
                $this->db->insert('raghuerp_hostel.roomsconfig',$data); 
                return ;
            }else{
                return 'already exists';
                }     
     }
     // add room type
     public function addtype($data){
            $type=$data['type'];
            $datas=$this->db->query("select * from raghuerp_hostel.roomtype where type = '$type'")->result();

            if(sizeof($datas)==0){
                $this->db->insert('raghuerp_hostel.roomtype',$data); 
                return ;
            }else{
                return 'already exists';
                }         
    }
    
      // edit room type
     public function editroomtype($data){
         $this->db->where('typeid',$data['typeid']); 
       $this->db->update('raghuerp_hostel.roomtype',$data); 
          
    }

     // delete room type
     public function deleteroomtype($data){
       $this->db->query("DELETE FROM raghuerp_hostel.roomtype WHERE raghuerp_hostel.roomtype.typeid = ".$data['typeid'].""); 
          
    }

    //  get room type
    public function getroomtype(){
        $sql="select * from raghuerp_hostel.roomtype";
        $data=$this->db->query($sql);
        return $data->result();
    }

     //  get room list config
    public function getroomconfig($data){
        $type=$data['rtype'];
        if($type!='all'){
              $sql="select * from raghuerp_hostel.roomsconfig where roomtype='".$data['rtype']."' and hosteltype='".$data['htype']."' "; 
      
        }else{
             $sql="select * from raghuerp_hostel.roomsconfig where hosteltype='".$data['htype']."' ";
        }
        $data=$this->db->query($sql);
        return $data->result();
    }

     //  get rooms available list 
    public function getroomslistavlb($data){
        $type=$data['hosteltype'];

        $sql="select * from raghuerp_hostel.roomsconfig r where r.hosteltype='$type' and r.avlbeds!=0"; 
      
        $data=$this->db->query($sql);
        return $data->result();
    }

     //  get beds list by roomno  
    public function getbedslistbyroomno($data){
        $type=$data['hosteltype'];
        $roomno=$data['roomno'];


        $check=$this->db->query("select * from raghuerp_hostel.roomdetails where roomno='$roomno' ")->result();
      if(sizeof($check)==0){
         $sql="select * from raghuerp_hostel.roomsconfig rc where rc.hosteltype='$type'  and rc.roomno='$roomno' and rc.avlbeds!=0"; 
      }else{
           $sql="select * from raghuerp_hostel.roomsconfig rc inner join raghuerp_hostel.roomdetails r on rc.roomno=r.roomno and rc.hosteltype='$type' and r.hsttype='$type'  and rc.roomno='$roomno' and r.roomno='$roomno' and rc.avlbeds!=0"; 
      }
        
      
        $data=$this->db->query($sql);
        return $data->result();
    }

    //  get bookings list 
    public function getbookingslist(){
        $sql="select * from raghuerp_hostel.bookings";
        $data=$this->db->query($sql);
        return $data->result();
    }

     //  get register list 
    public function getreglist($data){

        $sql="select *,y.year as syear,r.fathername as fname  from raghuerp_hostel.registrationdetails r inner join raghuerp_db1.students s on r.reg_no=s.reg_no inner join raghuerp_db1.year y on s.year=y.id and r.roomtype='".$data['type']."'  order by r.registrationid";
        $data=$this->db->query($sql);
        return $data->result();
    }

      //  vacant room  
    public function vacantroom($data){

        $list=$this->db->query("select * from raghuerp_hostel.registrationdetails r where r.type='".$data['type']."' and r.rstatus='Accepted'")->result();
 $count=sizeof($list)+1;
       $this->db->query("update raghuerp_hostel.registrationdetails r set r.pid='".$count."',type='".$data['type']."', r.rstatus='Accepted' where r.registrationid='".$data['registrationid']."'");
    
    }

  //  vacant room  
    public function getdetailstoadd($data){
  $reg_no=$data['reg_no'];
        $details=$this->db->query("select *,(select college from raghuerp_db1.colleges c where c.id=s.college) as ccollege,(select branch from raghuerp_db1.branches b where b.id=s.branch) as bbranch,(select branch from raghuerp_db1.year y where y.id=s.year) as yyear from raghuerp_hostel.registrationdetails r inner join raghuerp_db1.students s on r.reg_no=s.reg_no and s.reg_no='$reg_no'")->row();
//  $count=sizeof($list)+1;
//        $this->db->query("update raghuerp_hostel.registrationdetails r set r.pid='".$count."',type='".$data['type']."', r.rstatus='Accepted' where r.registrationid='".$data['registrationid']."'");
    return $details;
    }

    // Get Multiple query results function
    public function GetMultipleQueryResult($queryString)  {
        if (empty($queryString)) {
                    return false;
        }

        $index     = 0;
        $ResultSet = array();

        /* execute multi query */
        if (mysqli_multi_query($this->db->conn_id, $queryString)) {
            do {
                if (false != $result = mysqli_store_result($this->db->conn_id)) {
                    $rowID = 0;
                    while ($row = $result->fetch_assoc()) {
                        $ResultSet[$index][$rowID] = $row;
                        $rowID++;
                    }
                }
                $index++;
            } while (mysqli_more_results($this->db->conn_id) && mysqli_next_result($this->db->conn_id));
        }
        return $ResultSet;
    }


}
?>
