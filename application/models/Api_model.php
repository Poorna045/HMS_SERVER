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

        //  get rooms total list 
    public function gettotalrooms($data){
        $type=$data['hosteltype'];

        $sql="select * from raghuerp_hostel.roomsconfig r where r.hosteltype='$type'"; 
      
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

   //  get details by roomno and bedno  
    public function getdetailsbyroom($data){
        $type=$data['hosteltype'];
        $roomno=$data['roomno'];
        $bedno=$data['bedno'];

        
        $check=$this->db->query("select reg_no from raghuerp_hostel.roomdetails where roomno='$roomno' and bedno='$bedno' and hsttype='$type' ")->result();

      if(sizeof($check)==0){
        return null;
      }else{

     $reg_no=$check[0]->reg_no;
           $sql="select s.reg_no,(select r.rstatus from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rstatus,(select r.registrationid from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rid,(select r.type from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as type,(select r.genderT from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as genderT,(select r.studentname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as studentname,(select r.dateofbirth from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as dateofbirth,(select r.distance from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as distance,(select r.pwd from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as pwd,(select r.fathername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as fathername,(select r.parentmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentmobile,(select r.parentemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentemail,(select r.parentaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentaddress,(select r.guardianname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianname,(select r.guardianrelation from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianrelation,(select r.guardianmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianmobile,(select r.guardianemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianemail,(select r.guardianaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianaddress,(select college from raghuerp_db1.colleges c where c.id=s.college) as college,(select branch from raghuerp_db1.branches b where b.id=s.branch) as branch,(select year from raghuerp_db1.year y where y.id=s.year) as year,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select d.bedno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as bedno,(select d.hsttype from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as hsttype,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select rc.hostelid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' )  and rc.hosteltype='$type' ) as hostelid,(select rc.blockid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' )  and rc.hosteltype='$type' ) as blockid,(select rc.roomtype from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' ) and rc.hosteltype='$type' ) as roomtype from raghuerp_db1.students s where s.reg_no='$reg_no'"; 
            $data=$this->db->query($sql)->row();
        return $data;
      }
        
      
       
    }

    //  get bookings list 
    public function getbookingslist(){
        $sql="select * from raghuerp_hostel.bookings";
        $data=$this->db->query($sql);
        return $data->result();
    }

     //  get register list 
    public function getreglist($data){

        $sql="select *,y.year as syear,r.fathername as fname  from raghuerp_hostel.registrationdetails r inner join raghuerp_db1.students s on r.reg_no=s.reg_no inner join raghuerp_db1.year y on s.year=y.id and r.roomtype='".$data['type']."' and r.genderT='".$data['gender']."' ORDER BY
        CASE r.rstatus
           WHEN 'Allocated' THEN 1
           WHEN 'Accepted' THEN 2
           WHEN 'Waiting' THEN 3
            WHEN 'Pending' THEN 4
           ELSE 5
        END ";
        $data=$this->db->query($sql)->result();
        return $data;
    }

      //  vacant room  
    public function vacantroom($data){

       $this->db->query("update raghuerp_hostel.registrationdetails r set r.type='".$data['type']."', r.rstatus='Accepted' where r.registrationid='".$data['registrationid']."'");
    
    }
     //  vacant room  
     public function waitinglist($data){
        
               $this->db->query("update raghuerp_hostel.registrationdetails r set r.rstatus='Waiting' where r.registrationid='".$data['registrationid']."'");
            
            }

  //  vacant room  
    public function getdetailstoadd($data){
  $reg_no=$data['reg_no'];
        $details=$this->db->query("select s.reg_no,(select r.type from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as type,(select r.genderT from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as genderT,(select r.studentname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as studentname,(select r.dateofbirth from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as dateofbirth,(select r.distance from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as distance,(select r.fathername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as fathername,(select r.parentmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentmobile,(select r.parentemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentemail,(select r.parentaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentaddress,(select r.guardianname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianname,(select r.guardianrelation from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianrelation,(select r.guardianmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianmobile,(select r.guardianemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianemail,(select r.guardianaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianaddress,(select college from raghuerp_db1.colleges c where c.id=s.college) as college,(select branch from raghuerp_db1.branches b where b.id=s.branch) as branch,(select year from raghuerp_db1.year y where y.id=s.year) as year,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select d.bedno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as bedno,(select d.hsttype from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as hsttype,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno from raghuerp_db1.students s where s.reg_no='$reg_no'")->row();
//  $count=sizeof($list)+1;
//        $this->db->query("update raghuerp_hostel.registrationdetails r set r.pid='".$count."',type='".$data['type']."', r.rstatus='Accepted' where r.registrationid='".$data['registrationid']."'");
    return $details;
    }

     //  vacant room  
    public function getdetailsbyid($data){
        $reg_no=$data['reg_no'];

 $checking=$this->db->query("select firstname from raghuerp_db1.students where reg_no='$reg_no'")->result();
             if(sizeof($checking)==0){
                return null;
             }else{


       $type=$this->db->query("select genderT from raghuerp_hostel.registrationdetails where reg_no='$reg_no'")->result();
        if(sizeof($type)!=0){
            

            $gtype=$type[0]->genderT;
            if($gtype=='M'){
                $typ='Boys';
            }
            else{
                $typ='Girls';
            }
      //  default query to test in sql
         // $details=$this->db->query("select s.reg_no,(select r.registrationid from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rid,(select r.type from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as type,(select r.genderT from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as genderT,(select r.studentname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as studentname,(select r.dateofbirth from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as dateofbirth,(select r.distance from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as distance,(select r.pwd from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as pwd,(select r.fathername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as fathername,(select r.parentmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentmobile,(select r.parentemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentemail,(select r.parentaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentaddress,(select r.guardianname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianname,(select r.guardianrelation from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianrelation,(select r.guardianmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianmobile,(select r.guardianemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianemail,(select r.guardianaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianaddress,(select college from raghuerp_db1.colleges c where c.id=s.college) as college,(select branch from raghuerp_db1.branches b where b.id=s.branch) as branch,(select year from raghuerp_db1.year y where y.id=s.year) as year,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select d.bedno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as bedno,(select d.hsttype from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as hsttype,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select rc.hostelid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' and dc.hsttype='$typ' )  and rc.hosteltype='$typ') as hostelid,(select rc.blockid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' ) and rc.hosteltype='$typ' ) as blockid,(select rc.roomtype from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' ) and rc.hosteltype='$typ') as roomtype from raghuerp_db1.students s where s.reg_no='$reg_no'")->row();

        $details=$this->db->query("select s.reg_no,(select r.rstatus from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rstatus,(select r.registrationid from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rid,(select r.type from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as type,(select r.genderT from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as genderT,(select r.studentname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as studentname,(select r.dateofbirth from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as dateofbirth,(select r.distance from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as distance,(select r.pwd from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as pwd,(select r.fathername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as fathername,(select r.parentmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentmobile,(select r.parentemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentemail,(select r.parentaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentaddress,(select r.guardianname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianname,(select r.guardianrelation from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianrelation,(select r.guardianmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianmobile,(select r.guardianemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianemail,(select r.guardianaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianaddress,(select college from raghuerp_db1.colleges c where c.id=s.college) as college,(select branch from raghuerp_db1.branches b where b.id=s.branch) as branch,(select year from raghuerp_db1.year y where y.id=s.year) as year,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select d.bedno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as bedno,(select d.hsttype from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as hsttype,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select rc.hostelid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no'  and dc.hsttype='$typ') ) as hostelid,(select rc.blockid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' and dc.hsttype='$typ') ) as blockid,(select rc.roomtype from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' and dc.hsttype='$typ') ) as roomtype from raghuerp_db1.students s where s.reg_no='$reg_no'")->row();
        return $details;
        }else{
            return $this->db->query("select s.reg_no,concat(null) as studentname,concat(null) as bedno from raghuerp_db1.students s where s.reg_no='$reg_no'")->row();
        }
    }
    }


    //  Edit Student Details 
    public function editstuddetails($data){

       $this->db->where('registrationid',$data['registrationid']);
        $this->db->update('raghuerp_hostel.registrationdetails',$data);
    
    }

      //  allocate Room for Student 
    public function allocateroomstud($data){

       $result=$this->db->query("select * from raghuerp_hostel.roomdetails r where reg_no='".$data['reg_no']."'")->row();
       if($result){
        $this->db->query("update raghuerp_hostel.roomdetails r,raghuerp_hostel.roomsconfig rc1,raghuerp_hostel.roomsconfig rc2 set r.roomno='".$data['roomno']."',r.bedno='".$data['bedno']."',rc1.avlbeds=(rc1.avlbeds+1),rc1.rcstatus='available',rc2.avlbeds=case when '".$result->roomno."'='".$data['roomno']."' and '".$result->hsttype."'='".$data['hosteltype']."' then rc2.avlbeds else (rc2.avlbeds-1) end ,rc2.rcstatus=case when rc2.avlbeds=0 then 'filled' when rc2.avlbeds!=0 then 'available' end  where r.reg_no='".$data['reg_no']."' and rc1.roomno='".$result->roomno."' and rc1.hosteltype='".$data['hosteltype']."' and rc2.hosteltype='".$data['hosteltype']."' and rc2.roomno='".$data['roomno']."' ");

        return "exists";
       }else{
        $this->db->query("INSERT INTO `roomdetails`(`rid`, `reg_no`, `roomno`, `bedno`, `hsttype`) VALUES (NULL,'".$data['reg_no']."','".$data['roomno']."','".$data['bedno']."','".$data['hosteltype']."')");
        $this->db->query("update raghuerp_hostel.roomsconfig rc1,raghuerp_hostel.registrationdetails d  set d.rstatus='Allocated',rc1.avlbeds=(rc1.avlbeds-1),rc1.rcstatus=case when rc1.avlbeds=0 then 'filled' when rc1.avlbeds!=0 then 'available' end  where d.reg_no='".$data['reg_no']."' and  rc1.roomno='".$data['roomno']."' and rc1.hosteltype='".$data['hosteltype']."' ");
        
        return  "not exists";
       }
       
    }

      //  delete Student  from the Room 
      public function freetheroom($data){
        
               $this->db->query("DELETE FROM raghuerp_hostel.roomdetails  where reg_no = '".$data['reg_no']."'");
               $this->db->query("update raghuerp_hostel.roomsconfig rc1,raghuerp_hostel.registrationdetails d  set d.rstatus='Waiting',rc1.avlbeds=(rc1.avlbeds+1),rc1.rcstatus='available'  where d.reg_no='".$data['reg_no']."' and rc1.hosteltype='".$data['hosteltype']."' and rc1.roomno='".$data['roomno']."' ");
              
            }

              //  get available seats count 
      public function getavlseatscount($data){

              return $this->db->query("SELECT SUM(r.totbeds) as acseats,(select SUM(r.totbeds)   FROM raghuerp_hostel.roomsconfig r where r.hosteltype='".$data['hosteltype']."' and roomtype='Non-AC' ) as nonacseats,(select count(rd.type)   FROM raghuerp_hostel.registrationdetails rd where rd.type='AC'  and ( rd.rstatus='Accepted' or rd.rstatus='Allocated' ) and rd.genderT=case when '".$data['hosteltype']."'='Boys' then 'M' when '".$data['hosteltype']."'='Girls' then 'F' end ) as Aacseats,(select count(rd.type)   FROM raghuerp_hostel.registrationdetails rd where rd.type='Non-AC' and ( rd.rstatus='Accepted' or rd.rstatus='Allocated' ) and rd.genderT=case when '".$data['hosteltype']."'='Boys' then 'M' when '".$data['hosteltype']."'='Girls' then 'F' end ) as Anonacseats FROM raghuerp_hostel.roomsconfig r where r.hosteltype='".$data['hosteltype']."' and roomtype='AC'")->row();
              
            }

              //  edit Room Config 
       public function editroomconfig($data){
        
        $this->db->where('rcid',$data['rcid']);
        $this->db->update('raghuerp_hostel.roomsconfig',$data);
                      
         }

               //  delete Room Config 
       public function deleteroomconfig($data){
        
        $this->db->where('rcid',$data['rcid']);
        $this->db->delete('raghuerp_hostel.roomsconfig');
                      
         }



   // venkat sai

         
    // add registration
     public function addregistration($data){ 
        // echo date('Y-m-d H:i:s');
       $data['registerdate']=date('Y-m-d H:i:s');
       $this->db->insert('raghuerp_hostel.registrationdetails',$data);       
    }

    // add Complaints
     public function addcomplaints($data){
       $this->db->insert('raghuerp_hostel.complaints',$data);       
    }

    // add Notifications
     public function addnotification($data){
        $data['created_at']=date('Y-m-d H:i:s');
       $this->db->insert('raghuerp_hostel.notifications',$data);       
    }
    // get Notifications
     public function getNotifications()
    {
         $sql="select * from raghuerp_hostel.notifications";
        $data=$this->db->query($sql);
        return $data->result(); 
    }

    // add Instractions
     public function addInstractions($data){
        $data['i_created_at']=date('Y-m-d H:i:s');
       $this->db->insert('raghuerp_hostel.instructions',$data);       
    }

    // get Instructions
     public function getInstructions()
    {
         $sql="select * from raghuerp_hostel.instructions";
        $data=$this->db->query($sql);
        return $data->result(); 
    }
    
    // add Events
     public function addEvents($data){
        $data['event_created_at']=date('Y-m-d H:i:s');
       $this->db->insert('raghuerp_hostel.upcomingevents',$data);       
    }

    // get Events
     public function getEvents()
    {
         $sql="select * from raghuerp_hostel.upcomingevents";
        $data=$this->db->query($sql);
        return $data->result(); 
    }


    //  get complaints list config
    public function getcomplaints($data){
        $type=$data['type'];
        if($type == 'all'){
            $sql=$this->db->query("select * from raghuerp_hostel.complaints c order by c.id DESC ")->result();
        }else{
            $sql=$this->db->query("select * from raghuerp_hostel.complaints c where c.complaint_type='$type'  order by c.id DESC")->result(); 
        }
       
        return $sql;
    }

     //  Add New Bill Type
     public function addbilltype($data){
         $ds=$this->db->query("select * from raghuerp_hostel.maintenanceservices b where b.billtype='".$data['billtype']."'")->result();
         if(sizeof($ds)==0){
        $this->db->insert('raghuerp_hostel.maintenanceservices',$data);
        return '';
         }else{
           return 'exists';
         }
       
    }

      //  Get Bill Types
      public function getbilltypes($data){
        $ds=$this->db->query("select * from raghuerp_hostel.maintenanceservices")->result();
      
        return $ds;
   }

     //  delete Bill Type by bid
     public function deletebilltype($data){
        
        $this->db->where('bid',$data['bid']);
     $this->db->delete('raghuerp_hostel.maintenanceservices');
    
      
   }

      //  add payment data
      public function addpaymentdata($data){

     $this->db->insert('raghuerp_hostel.maintenancedata',$data);
      
     }

      //  get maintenance data by type
      public function getmaintenancedata($data){
        $type=$data['btype'];
        if($type == 'all'){
            $sql=$this->db->query("select * from raghuerp_hostel.maintenancedata c where c.ctype='".$data['ctype']."' order by c.mdid DESC ")->result();
        }else{
            $sql=$this->db->query("select * from raghuerp_hostel.maintenancedata c where c.billtype='$type' and c.ctype='".$data['ctype']."'  order by c.mdid DESC")->result(); 
        }
       
        return $sql;
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