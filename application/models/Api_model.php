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
         
     
          
         $data2['created_at']=date('Y-m-d H:i:s');
         $data2['notificationdate']=$data['startdate'];
         $data2['noticedescription']=$data['description']. '  Last Date : '. $data['enddate'] ;

         $this->db->insert('raghuerp_hostel.notifications',$data2);

         $data['n_id']=$this->db->insert_id();

         $this->db->insert('raghuerp_hostel.bookings',$data);
         
         $lastid=$this->db->insert_id();

         $this->db->query("UPDATE raghuerp_hostel.selectionstatus s SET s.status='1' WHERE s.bid IN (SELECT b.bid FROM raghuerp_hostel.bookings b where b.hosteltype='".$data['hosteltype']."') ");

         $this->db->query("INSERT INTO raghuerp_hostel.selectionstatus (`ssid`, `bid`, `status`) VALUES (NULL,'$lastid', '0') ");

    }

     // postpone/prepone booking end date
     public function changebookingenddate($data){
        
     
    
        if ($data['type']=='postpone') {

    $dateadd="DATE_ADD(b.enddate, INTERVAL ".$data['value']." DAY)";
    $note="concat('End Date for Registration is Postponed for ".$data['value']." days ', b.description ,' Last Date : ', b.enddate)";
        $this->db->query("UPDATE raghuerp_hostel.bookings b,raghuerp_hostel.notifications n SET b.enddate=$dateadd,n.noticedescription=$note WHERE b.bid='".$data['bid']."' and n.n_id=b.n_id "); 

     } else {
        $datesub="DATE_SUB(b.enddate, INTERVAL ".$data['value']." DAY)";
        $note="concat('End Date for Registration is Postponed for ".$data['value']." days ', b.description ,' Last Date : ', b.enddate)";
        $this->db->query("UPDATE raghuerp_hostel.bookings b,raghuerp_hostel.notifications n SET b.enddate=$datesub,n.noticedescription=$note WHERE b.bid='".$data['bid']."' and n.n_id=b.n_id "); 
    }
        
   }


    // Edit booking
     public function editbooking($data){
         
             $this->db->where('bid',$data['bid']); 
             $this->db->update('raghuerp_hostel.bookings',$data); 


             $this->db->where('bid',$data['bid']); 
            $n_id= $this->db->get('raghuerp_hostel.bookings')->row()->n_id; 


             
         $data2['notificationdate']=$data['startdate'];
         $data2['noticedescription']=$data['description']. ' , Last Date : '. $data['enddate'] ;

         $this->db->where('n_id',$n_id);
         $this->db->update('raghuerp_hostel.notifications',$data2);
        
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
            $htype=$data['hostelid'];
            $datas=$this->db->query("select * from raghuerp_hostel.roomsconfig where roomno = '$roomno' and hostelid='$htype'")->result();

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
        if($type=='all' && $data['hid']=='all'){
              $sql="select * from raghuerp_hostel.roomsconfig r inner join raghuerp_hostel.hostelconfig h on r.hostelid=h.hid inner join raghuerp_hostel.roomtype rt on r.roomtype=rt.typeid"; 
          
        }else if ($type!='all' && $data['hid']!='all'){
            $sql="select * from raghuerp_hostel.roomsconfig r inner join raghuerp_hostel.hostelconfig h on r.hostelid=h.hid and r.roomtype='".$data['rtype']."' and hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on r.roomtype=rt.typeid"; 
            
        }else if ($type=='all'){
             $sql="select * from raghuerp_hostel.roomsconfig r inner join raghuerp_hostel.hostelconfig h on r.hostelid=h.hid and hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on r.roomtype=rt.typeid ";
        }else if ($data['hid']=='all'){
            $sql="select * from raghuerp_hostel.roomsconfig r inner join raghuerp_hostel.hostelconfig h on r.hostelid=h.hid and roomtype='".$data['rtype']."' inner join raghuerp_hostel.roomtype rt on r.roomtype=rt.typeid";
       }
        $data=$this->db->query($sql);
        return $data->result();
    }

     //  get rooms available list 
    public function getroomslistavlb($data){
        $hid=$data['hid'];

        $sql="select *,rt.type as type  from raghuerp_hostel.roomsconfig r  inner join raghuerp_hostel.roomtype rt on r.roomtype = rt.typeid and r.hostelid='$hid' and r.avlbeds>0"; 
      
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
        $type=$data['hostelid'];
        $roomno=$data['rcid'];

        $check=$this->db->query("select * from raghuerp_hostel.roomdetails r where r.roomno='$roomno' ")->result();
      if(sizeof($check)==0){
         $sql="select * from raghuerp_hostel.roomsconfig rc inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid and rc.rcid='$roomno'"; 
      }else{
           $sql="select concat('') as studentname,rc.*,r.*,rc.roomno as roomnum,hc.hosteltype from raghuerp_hostel.roomsconfig rc inner join raghuerp_hostel.roomdetails r on rc.rcid=r.roomno and rc.rcid='$roomno' inner join raghuerp_hostel.hostelconfig hc on rc.hostelid=hc.hid and rc.hostelid='$type'"; 
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
           $sql="select s.reg_no,(select r.rstatus from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rstatus,(select r.registrationid from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rid,(select r.type from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as type,(select r.genderT from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as genderT,(select r.studentname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as studentname,(select r.dateofbirth from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as dateofbirth,(select r.distance from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as distance,(select r.pwd from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as pwd,(select r.fathername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as fathername,(select r.mothername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as mothername,(select r.parentmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentmobile,(select r.parentemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentemail,(select r.parentaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentaddress,(select r.guardianname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianname,(select r.guardianrelation from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianrelation,(select r.guardianmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianmobile,(select r.guardianemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianemail,(select r.guardianaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianaddress,(select college from raghuerp_db1.colleges c where c.id=s.college) as college,(select branch from raghuerp_db1.branches b where b.id=s.branch) as branch,(select year from raghuerp_db1.year y where y.id=s.year) as year,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select d.bedno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as bedno,(select d.hsttype from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as hsttype,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select rc.hostelid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' )  and rc.hosteltype='$type' ) as hostelid,(select rc.blockid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' )  and rc.hosteltype='$type' ) as blockid,(select rc.roomtype from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' ) and rc.hosteltype='$type' ) as roomtype,(select rc.floorno from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no'  and dc.hsttype='$type')  and rc.hosteltype='".$type."' ) as floorno from raghuerp_db1.students s where s.reg_no='$reg_no'"; 
            $data=$this->db->query($sql)->row();
        return $data;
      }
        
      
       
    }

    //  get bookings list 
    public function getbookingslist(){
        $sql="SELECT * FROM raghuerp_hostel.bookings ORDER BY status DESC,bid DESC";
        $data=$this->db->query($sql)->result();
        return $data;
    }

     //  get register list 
    public function getreglist($data){
 
         if ($data['gender']=='Boys') {
            $gen='M';
         } else {
            $gen='F';
         }
         

        $data2=$this->db->query("SELECT rd.registerid,rd.reg_no,rd.registereddate,rd.distance,rd.rstatus,rd.utype,stud.firstname,stud.fathername,stud.mothername,stud.gender,stud.email,stud.mobile,stud.present_address,stud.dob,stud.father_income,stud.scholarship_status,clg.college,br.branch,yr.year,sc.section,case when rd.roomtype='all' then 'all' else (select rt.type from raghuerp_hostel.roomtype rt where rt.typeid=rd.roomtype) end as appliedtype,(select rt.type from raghuerp_hostel.roomtype rt where rt.typeid=rd.typepriority) as prioritytype,(select rt.type from raghuerp_hostel.roomtype rt where rt.typeid=rd.selectedtype) as selectedtype,(select hc.hlocation from raghuerp_hostel.hostelconfig hc where hc.hid=rd.locationpriority) as prioritylocation,(select hc.hlocation from raghuerp_hostel.hostelconfig hc where hc.hid=rd.selectedlocation) as selectedlocation,case when rd.hostellocation='all' then 'all' else (select hc.hlocation from raghuerp_hostel.hostelconfig hc where hc.hid=rd.hostellocation) end as appliedlocation,ed.bloodgroup,ed.disability FROM raghuerp_hostel.bookings b,raghuerp_hostel.registereddetails rd INNER JOIN raghuerp_dbnew.students stud on rd.reg_no=stud.reg_no and stud.gender='$gen' INNER JOIN raghuerp_dbnew.colleges clg on stud.college=clg.id INNER JOIN raghuerp_dbnew.branches br on stud.branch=br.id INNER JOIN raghuerp_dbnew.year yr on stud.year=yr.id INNER JOIN raghuerp_dbnew.sections sc on stud.section=sc.id left JOIN raghuerp_dbnew.emergency_details ed  on rd.reg_no=ed.reg_no where b.bid=(SELECT max(bs.bid) FROM raghuerp_hostel.bookings bs where bs.hosteltype='".$data['gender']."') and  DATE(rd.registereddate) BETWEEN b.startdate and b.enddate and rd.roomtype='".$data['type']."' ORDER BY
        CASE rd.rstatus
        WHEN 'selected' THEN 1
        WHEN 'waiting' THEN 2
         WHEN 'pending' THEN 3
        ELSE 4
     END")->result();

        // $data2=$this->db->query("SELECT rd.registerid,rd.reg_no,rd.registereddate,rd.distance,rd.rstatus,rd.utype,stud.firstname,stud.fathername,stud.mothername,stud.gender,stud.email,stud.mobile,stud.present_address,stud.dob,stud.father_income,stud.scholarship_status,clg.college,br.branch,yr.year,sc.section,case when rd.roomtype='all' then 'all' else (select rt.type from raghuerp_hostel.roomtype rt where rt.typeid=rd.roomtype) end as appliedtype,(select rt.type from raghuerp_hostel.roomtype rt where rt.typeid=rd.typepriority) as prioritytype,(select hc.hlocation from raghuerp_hostel.hostelconfig hc where hc.hid=rd.locationpriority) as prioritylocation,case when rd.hostellocation='all' then 'all' else (select hc.hlocation from raghuerp_hostel.hostelconfig hc where hc.hid=rd.hostellocation) end as appliedlocation,ed.bloodgroup,ed.disability FROM raghuerp_hostel.bookings b,raghuerp_hostel.registereddetails rd INNER JOIN raghuerp_dbnew.students stud on rd.reg_no=stud.reg_no and stud.gender='$gen' INNER JOIN raghuerp_dbnew.colleges clg on stud.college=clg.id INNER JOIN raghuerp_dbnew.branches br on stud.branch=br.id INNER JOIN raghuerp_dbnew.year yr on stud.year=yr.id INNER JOIN raghuerp_dbnew.sections sc on stud.section=sc.id left JOIN raghuerp_dbnew.emergency_details ed  on rd.reg_no=ed.reg_no where b.bid=(SELECT max(bs.bid) FROM raghuerp_hostel.bookings bs where bs.hosteltype='".$data['gender']."') and  DATE(rd.registereddate) BETWEEN b.startdate and b.enddate and rd.roomtype='".$data['type']."' ORDER BY
        // CASE rd.rstatus
        //    WHEN 'selected' THEN 1
        //    WHEN 'waiting' THEN 2
        //     WHEN 'pending' THEN 3
        //    ELSE 4
        // END")->result();

       
        return $data2;
    }

      //  vacant room  
    public function vacantroom($data){

       $this->db->query("update raghuerp_hostel.registereddetails r set r.selectedtype='".$data['type']."', r.rstatus='selected' where r.registerid='".$data['registerid']."'");

    }

     //  update status to waiting list  
     public function waitinglist($data){
        
               $this->db->query("update raghuerp_hostel.registereddetails r set r.rstatus='waiting',r.selectedtype='' where r.registerid='".$data['registerid']."'");
            
            }

  //  vacant room  
    public function getdetailstoadd($data){
  $reg_no=$data['reg_no'];
        $details=$this->db->query("select s.reg_no,(select r.type from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as type,(select r.genderT from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as genderT,(select r.studentname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as studentname,(select r.dateofbirth from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as dateofbirth,(select r.distance from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as distance,(select r.fathername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as fathername,(select r.mothername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as mothername,(select r.parentmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentmobile,(select r.parentemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentemail,(select r.parentaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentaddress,(select r.guardianname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianname,(select r.guardianrelation from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianrelation,(select r.guardianmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianmobile,(select r.guardianemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianemail,(select r.guardianaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianaddress,(select college from raghuerp_db1.colleges c where c.id=s.college) as college,(select branch from raghuerp_db1.branches b where b.id=s.branch) as branch,(select year from raghuerp_db1.year y where y.id=s.year) as year,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select d.bedno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as bedno,(select d.hsttype from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as hsttype,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno from raghuerp_db1.students s where s.reg_no='$reg_no'")->row();
//  $count=sizeof($list)+1;
//        $this->db->query("update raghuerp_hostel.registrationdetails r set r.pid='".$count."',type='".$data['type']."', r.rstatus='Accepted' where r.registrationid='".$data['registrationid']."'");
    return $details;
    }

     //  vacant room  
    public function getdetailsbyid($data){
        $reg_no=$data['reg_no'];
        $utype=$data['utype'];

          if ($utype=='std') {
            $checking=$this->db->query("select firstname from raghuerp_dbnew.students where reg_no='$reg_no'")->result();
          }else if ($utype=='stf') {
            $checking=$this->db->query("select firstname from raghuerp_dbnew.staff s where s.reg_no='$reg_no'")->result();
          }
 
             if(sizeof($checking)==0){
                return null;
             }else{


       $type=$this->db->query("select registerid from raghuerp_hostel.registereddetails where reg_no='$reg_no'")->result();
        if(sizeof($type)!=0){
        
      //  default query to test in sql
         // $details=$this->db->query("select s.reg_no,(select r.registrationid from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rid,(select r.type from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as type,(select r.genderT from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as genderT,(select r.studentname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as studentname,(select r.dateofbirth from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as dateofbirth,(select r.distance from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as distance,(select r.pwd from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as pwd,(select r.fathername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as fathername,(select r.parentmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentmobile,(select r.parentemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentemail,(select r.parentaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentaddress,(select r.guardianname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianname,(select r.guardianrelation from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianrelation,(select r.guardianmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianmobile,(select r.guardianemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianemail,(select r.guardianaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianaddress,(select college from raghuerp_db1.colleges c where c.id=s.college) as college,(select branch from raghuerp_db1.branches b where b.id=s.branch) as branch,(select year from raghuerp_db1.year y where y.id=s.year) as year,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select d.bedno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as bedno,(select d.hsttype from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as hsttype,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select rc.hostelid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' and dc.hsttype='$typ' )  and rc.hosteltype='$typ') as hostelid,(select rc.blockid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' ) and rc.hosteltype='$typ' ) as blockid,(select rc.roomtype from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' ) and rc.hosteltype='$typ') as roomtype from raghuerp_db1.students s where s.reg_no='$reg_no'")->row();
          
         if ($utype=='stf') {
            //  query  SELECT hc.hostelname,hc.hosteltype,hc.hlocation,rc.roomno,rc.floorno,rmd.bedno,rt.type,rgd.reg_no,rgd.registereddetails,rgd.distance,rgd.utype,rgd.rstatus,ed.bloodgroup,ed.disability,clg.college,crs.department,stud.designation,stud.firstname,stud.email,stud.mobile,stud.dp,stud.present_address,stud.gender,stud.dateob,stud.employment_type,stud.father_name,stud.mother_name from raghuerp_hostel.registereddetails rgd  INNER JOIN raghuerp_dbnew.staff stud  INNER JOIN raghuerp_dbnew.colleges clg  INNER JOIN raghuerp_dbnew.departments crs INNER JOIN raghuerp_dbnew.emergency_details ed INNER JOIN raghuerp_hostel.hostelconfig hc INNER JOIN raghuerp_hostel.roomsconfig rc INNER JOIN raghuerp_hostel.roomdetails rmd INNER JOIN raghuerp_hostel.roomtype rt on rgd.reg_no=stud.reg_no and clg.id=stud.college and crs.id=stud.department and ed.reg_no=rgd.reg_no and rt.typeid=rgd.selectedtype and rmd.reg_no=rgd.reg_no and rc.rcid=rmd.roomno and hc.hid=rc.hostelid and rgd.reg_no='CSE2CR'
            // $details=$this->db->query("select s.reg_no,(select r.rstatus from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rstatus,(select r.registrationid from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rid,(select r.type from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as type,(select r.genderT from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as genderT,(select r.studentname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as studentname,(select r.dateofbirth from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as dateofbirth,(select r.distance from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as distance,(select r.pwd from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as pwd,(select r.fathername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as fathername,(select r.mothername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as mothername,(select r.parentmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentmobile,(select r.parentemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentemail,(select r.parentaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentaddress,(select r.guardianname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianname,(select r.guardianrelation from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianrelation,(select r.guardianmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianmobile,(select r.guardianemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianemail,(select r.guardianaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianaddress,(select college from raghuerp_db1.colleges c where c.id=s.college) as college,(select branch from raghuerp_db1.branches b where b.id=s.branch) as branch,(select year from raghuerp_db1.year y where y.id=s.year) as year,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select d.bedno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as bedno,(select d.hsttype from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as hsttype,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select rc.hostelid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no'  and dc.hsttype='$typ')  and rc.hosteltype='".$typ."') as hostelid,(select rc.blockid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' and dc.hsttype='$typ') and rc.hosteltype='".$typ."') as blockid,(select rc.roomtype from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' and dc.hsttype='$typ') and rc.hosteltype='".$typ."' ) as roomtype,(select rc.floorno from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no'  and dc.hsttype='$typ')  and rc.hosteltype='".$typ."') as floorno from raghuerp_db1.students s where s.reg_no='$reg_no'")->row();

                $details=$this->db->query("SELECT hc.hostelname,hc.hosteltype,hc.hlocation,rc.rcid,rc.roomno,rc.floorno,rmd.bedno,(select rt.type from raghuerp_hostel.roomtype rt where rt.typeid=rc.roomtype) as type,rgd.reg_no,rgd.registereddate,rgd.distance,rgd.utype,rgd.rstatus,(select rt.type from raghuerp_hostel.roomtype rt where rt.typeid=rgd.selectedtype) as selectedtype,(select hc.hlocation from raghuerp_hostel.hostelconfig hc where hc.hid=rgd.hostellocation) as appliedlocation,ed.bloodgroup,ed.disability,(select clg.college from raghuerp_dbnew.colleges clg where clg.id=stud.college) as college,(select clg.department from raghuerp_dbnew.departments clg where clg.id=stud.department) as department,stud.firstname,stud.email,stud.mobile,stud.dp,stud.designation,stud.present_address,stud.gender,stud.dateob as dob,stud.father_name as fathername,stud.mother_name as mothername from raghuerp_hostel.registereddetails rgd  INNER JOIN raghuerp_dbnew.staff stud on rgd.reg_no=stud.reg_no  and rgd.reg_no='$reg_no' left JOIN raghuerp_hostel.roomdetails rmd  on rmd.reg_no=rgd.reg_no left JOIN raghuerp_hostel.roomsconfig rc on rc.rcid=rmd.roomno  left JOIN raghuerp_dbnew.emergency_details ed  on rgd.reg_no=ed.reg_no left JOIN raghuerp_hostel.hostelconfig hc on hc.hid=rc.hostelid")->row();
                
     
         }else if ($utype=='std') {

            //  query  SELECT hc.hostelname,hc.hosteltype,hc.hlocation,rc.roomno,rc.floorno,rmd.bedno,rt.type,rgd.reg_no,rgd.registereddetails,rgd.distance,rgd.utype,rgd.rstatus,ed.bloodgroup,ed.disability,clg.college,crs.course,bch.branch,yr.year,sc.section,stud.firstname,stud.email,stud.mobile,stud.dp,stud.present_address,stud.gender,stud.dob,stud.living_status,stud.scholarship_status,stud.staff_child,stud.father_income,stud.mother_income,stud.fathername,stud.mothername from raghuerp_hostel.registereddetails rgd  INNER JOIN raghuerp_dbnew.students stud  INNER JOIN raghuerp_dbnew.colleges clg  INNER JOIN raghuerp_dbnew.courses crs   INNER JOIN raghuerp_dbnew.branch bch INNER JOIN raghuerp_dbnew.year yr INNER JOIN raghuerp_dbnew.section sc INNER JOIN raghuerp_dbnew.emergency_details ed   INNER JOIN raghuerp_hostel.hostelconfig hc INNER JOIN raghuerp_hostel.roomsconfig rc INNER JOIN raghuerp_hostel.roomdetails rmd INNER JOIN raghuerp_hostel.roomtype rt on rgd.reg_no=stud.reg_no and clg.id=stud.college and bch.id=stud.branch and yr.id=stud.year and crs.id=stud.course and sc.id=stud.section and ed.reg_no=rgd.reg_no and rt.typeid=rgd.selectedtype and rmd.reg_no=rgd.reg_no and rc.rcid=rmd.roomno and hc.hid=rc.hostelid and rgd.reg_no='CSE2CR' 
            // $details=$this->db->query("select s.reg_no,(select r.rstatus from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rstatus,(select r.registrationid from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as rid,(select r.type from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as type,(select r.genderT from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as genderT,(select r.studentname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as studentname,(select r.dateofbirth from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as dateofbirth,(select r.distance from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as distance,(select r.pwd from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as pwd,(select r.fathername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as fathername,(select r.mothername from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as mothername,(select r.parentmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentmobile,(select r.parentemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentemail,(select r.parentaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as parentaddress,(select r.guardianname from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianname,(select r.guardianrelation from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianrelation,(select r.guardianmobile from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianmobile,(select r.guardianemail from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianemail,(select r.guardianaddress from raghuerp_hostel.registrationdetails r where r.reg_no='$reg_no' ) as guardianaddress,(select college from raghuerp_db1.colleges c where c.id=s.college) as college,(select branch from raghuerp_db1.branches b where b.id=s.branch) as branch,(select year from raghuerp_db1.year y where y.id=s.year) as year,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select d.bedno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as bedno,(select d.hsttype from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as hsttype,(select d.roomno from raghuerp_hostel.roomdetails d where d.reg_no='$reg_no' ) as roomno,(select rc.hostelid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no'  and dc.hsttype='$typ')  and rc.hosteltype='".$typ."') as hostelid,(select rc.blockid from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' and dc.hsttype='$typ') and rc.hosteltype='".$typ."') as blockid,(select rc.roomtype from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no' and dc.hsttype='$typ') and rc.hosteltype='".$typ."' ) as roomtype,(select rc.floorno from raghuerp_hostel.roomsconfig rc where rc.roomno=(select roomno from raghuerp_hostel.roomdetails dc where dc.reg_no='$reg_no'  and dc.hsttype='$typ')  and rc.hosteltype='".$typ."') as floorno from raghuerp_db1.students s where s.reg_no='$reg_no'")->row();
            

            $details=$this->db->query("SELECT hc.hostelname,hc.hosteltype,hc.hlocation,rc.rcid,rc.roomno,rc.floorno,rmd.bedno,(select rt.type from raghuerp_hostel.roomtype rt where rt.typeid=rc.roomtype) as type,rgd.reg_no,rgd.registereddate,rgd.distance,rgd.utype,rgd.rstatus,(select rt.type from raghuerp_hostel.roomtype rt where rt.typeid=rgd.selectedtype) as selectedtype,(select hc.hlocation from raghuerp_hostel.hostelconfig hc where hc.hid=rgd.hostellocation) as appliedlocation,ed.bloodgroup,ed.disability,(select clg.college from raghuerp_dbnew.colleges clg where clg.id=stud.college) as college,(select clg.course from raghuerp_dbnew.courses  clg where clg.id=stud.course) as course,(select clg.branch from raghuerp_dbnew.branches clg  where clg.id=stud.branch) as branch,(select clg.year from raghuerp_dbnew.year clg where clg.id=stud.year) as year,(select clg.section from raghuerp_dbnew.sections  clg where clg.id=stud.section) as section,stud.firstname,stud.email,stud.mobile,stud.dp,stud.present_address,stud.gender,stud.dob,stud.fathername,stud.mothername,stud.living_status,stud.scholarship_status,stud.staff_child,stud.father_income,stud.mother_income from raghuerp_hostel.registereddetails rgd  INNER JOIN raghuerp_dbnew.students stud on rgd.reg_no=stud.reg_no  and rgd.reg_no='$reg_no' left JOIN raghuerp_hostel.roomdetails rmd  on rmd.reg_no=rgd.reg_no left JOIN raghuerp_hostel.roomsconfig rc on rc.rcid=rmd.roomno  left JOIN raghuerp_dbnew.emergency_details ed  on rgd.reg_no=ed.reg_no left JOIN raghuerp_hostel.hostelconfig hc on hc.hid=rc.hostelid")->row();
            
         }

        return $details;

        }else{
            if ($utype=='std') {
                return $this->db->query("select s.reg_no,concat(null) as firstname,concat(null) as bedno from raghuerp_dbnew.students s where s.reg_no='$reg_no'")->row();
            }else if ($utype=='stf') {
                return $this->db->query("select s.reg_no,concat(null) as firstname,concat(null) as bedno from raghuerp_dbnew.staff s where s.reg_no='$reg_no'")->row();
            }
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
        $this->db->query("update raghuerp_hostel.roomdetails r,raghuerp_hostel.roomsconfig rc1,raghuerp_hostel.roomsconfig rc2,raghuerp_hostel.registereddetails d set d.rstatus='allocated',r.roomno='".$data['rcid']."',r.bedno='".$data['bedno']."',rc1.avlbeds=(rc1.avlbeds+1),rc1.rcstatus='available',rc2.avlbeds=case when '".$result->roomno."'='".$data['rcid']."' and '".$result->reg_no."'='".$data['reg_no']."' then rc2.avlbeds else (rc2.avlbeds-1) end ,rc2.rcstatus=case when rc2.avlbeds=0 then 'filled' when rc2.avlbeds!=0 then 'available' end  where r.reg_no='".$data['reg_no']."' and rc1.rcid='".$data['prevrcid']."'  and rc2.rcid='".$data['rcid']."' and d.reg_no='".$data['reg_no']."' ");

        return "exists";
       }else{
        $this->db->query("INSERT INTO `roomdetails`(`rid`, `reg_no`, `roomno`, `bedno`, `utype`) VALUES (NULL,'".$data['reg_no']."','".$data['rcid']."','".$data['bedno']."','".$data['utype']."')");
        $this->db->query("update raghuerp_hostel.roomsconfig rc1,raghuerp_hostel.registereddetails d  set d.rstatus='allocated',rc1.avlbeds=(rc1.avlbeds-1),rc1.rcstatus=case when rc1.avlbeds=0 then 'filled' when rc1.avlbeds!=0 then 'available' end  where d.reg_no='".$data['reg_no']."' and  rc1.rcid='".$data['rcid']."'");
        
        return  "not exists";
       }
       
    }

      //  delete Student  from the Room 
      public function freetheroom($data){
        
               $this->db->query("DELETE FROM raghuerp_hostel.roomdetails  where reg_no = '".$data['reg_no']."'");
               $this->db->query("update raghuerp_hostel.roomsconfig rc1,raghuerp_hostel.registereddetails d  set d.rstatus='deallocated',rc1.avlbeds=(rc1.avlbeds+1),rc1.rcstatus='available'  where d.reg_no='".$data['reg_no']."' and rc1.rcid='".$data['rcid']."' ");
              
            }

              //  get available seats count 
      public function getavlseatscount($data){

        if ($data['hosteltype']=='Boys') {
            $gen='M';
         } else {
            $gen='F';
         }
         
           return $this->db->query("SELECT rt.type,rt.typeid,SUM(rc.totbeds) as totbeds,SUM(rc.avlbeds) as avlbeds, (select count(rd.reg_no) from raghuerp_hostel.bookings b,raghuerp_hostel.registereddetails rd inner join raghuerp_dbnew.students st on rd.reg_no=st.reg_no and st.gender='$gen' where b.bid=(SELECT max(bs.bid) FROM raghuerp_hostel.bookings bs where bs.hosteltype='".$data['hosteltype']."') and  DATE(rd.registereddate) BETWEEN b.startdate and b.enddate  and rd.rstatus='selected' and rd.selectedtype=rt.typeid ) as selected FROM  raghuerp_hostel.roomsconfig rc INNER JOIN raghuerp_hostel.hostelconfig hc on rc.hostelid=hc.hid and hc.hosteltype='".$data['hosteltype']."' INNER JOIN raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid GROUP BY rc.roomtype")->result();

            
           //   return $this->db->query("SELECT rt.type,rt.typeid,SUM(rc.totbeds) as totbeds,SUM(rc.avlbeds) as avlbeds FROM  raghuerp_hostel.roomsconfig rc INNER JOIN raghuerp_hostel.hostelconfig hc on rc.hostelid=hc.hid and hc.hosteltype='".$data['hosteltype']."' INNER JOIN raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid GROUP BY rc.roomtype")->result();
   
        }

              //  edit Room Config 
       public function editroomconfig($data){
        
                $valid=$this->db->query("select * from raghuerp_hostel.roomsconfig r where r.roomno='".$data['roomno']."' and r.hostelid='".$data['hostelid']."' and r.rcid!='".$data['rcid']."'")->result();
            
                if (sizeof($valid)>0) {
                return 'invalid';
                }
                else{                    

                    $filledlist=$this->db->query("select * from raghuerp_hostel.roomdetails r where r.roomno='".$data['rcid']."'")->result();
                  
                    $data['avlbeds']=(int)$data['totbeds']-sizeof($filledlist);
                    if ((int)$data['avlbeds']>0) {
                        $data['rcstatus']='available';
                    
                    }else{
                        $data['rcstatus']='filled';
                    }
             
                    $this->db->where('rcid',$data['rcid']);
                $this->db->update('raghuerp_hostel.roomsconfig',$data);

                return 'valid';    
                }
                      
         }

               //  delete Room Config 
       public function deleteroomconfig($data){
        
        $this->db->where('rcid',$data['rcid']);
        $this->db->delete('raghuerp_hostel.roomsconfig');
                      
         }



   // venkat sai

         
    // add registration
     public function addregistration($data){ 
       $data['registereddate']=date('Y-m-d H:i:s');
     
       
       if ($data['registeredtype']=='adm') {

        array_splice($data,6,1);
             $data['selectedtype']=$data['typepriority'];
             $data['selectedlocation']=$data['locationpriority'];
             $data['rstatus']='selected';
           $this->db->insert('raghuerp_hostel.registereddetails',$data);  
        //    $lastid=$this->db->insert_id();
        //    $this->db->query("update raghuerp_hostel.registereddetails r");  
           

       }else{
        array_splice($data,6,1);
        $this->db->insert('raghuerp_hostel.registereddetails',$data);  
       }
    }

    // get valid  registration 
    public function getvalidusertest($data){ 
        $sql="select * from raghuerp_hostel.registereddetails r where r.reg_no='".$data['reg_no']."'";
        $data=$this->db->query($sql);
        return $data->result(); 
     }

      // change registration 
    public function changeregistration($data){ 
        $sql="UPDATE raghuerp_hostel.registereddetails r SET r.hostellocation='".$data['hostellocation']."',r.roomtype='".$data['roomtype']."',r.typepriority='".$data['typepriority']."' WHERE r.registerid='".$data['registerid']."'";
        $data=$this->db->query($sql);
       
     }


        // enable status to selection process
        public function clearregdatavisible($data){

            $this->db->query("UPDATE raghuerp_hostel.selectionstatus s SET s.status='1' WHERE s.bid IN (SELECT b.bid FROM raghuerp_hostel.bookings b where b.hosteltype='".$data['hosteltype']."' )");       
         
        }

         // enable visible to selection process
         public function visiselc($data){
            
                        $vis=$this->db->query("SELECT * FROM raghuerp_hostel.selectionstatus s WHERE s.status='0' AND s.bid IN (SELECT b.bid FROM raghuerp_hostel.bookings b where b.hosteltype='".$data['hosteltype']."' )")->result();       
                        
                   if (sizeof($vis)>0) {
                       $mes='enable';
                   } else {
                      $mes='disable';
                   }
                   
                   return $mes;

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
         $sql="select * from raghuerp_hostel.notifications  i order by i.n_id DESC";
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
         $sql="select * from raghuerp_hostel.instructions i order by i.i_id DESC";
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
         $sql="select * from raghuerp_hostel.upcomingevents  i order by i.e_id DESC";
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

      //  get Students data except regitered users
      public function getstudataexreg(){

            $sql=$this->db->query("select s.reg_no,s.firstname from raghuerp_db.students s where NOT EXISTS (select r.reg_no from raghuerp_hostel.registrationdetails r where r.reg_no=s.reg_no)")->result();
      
        return $sql;
    }

    //  get Students data except regitered users
    public function getstudatabyid($data){
        
                    $sql=$this->db->query("select s.reg_no,s.firstname,s.fathername,s.mothername,s.present_address,s.permanent_address,s.dob,s.gender from raghuerp_db.students s where s.reg_no='".$data['reg_no']."'")->result();
              
                return $sql;
            }


            //  get hostel config data
    public function gethostelconfig(){
        
                    return $this->db->query("select * from raghuerp_hostel.hostelconfig")->result();
              
            }

              //  add hostel config data
    public function addhostelconfig($data){
        
                    $valid=  $this->db->query("select * from raghuerp_hostel.hostelconfig h where h.hostelname='".$data['hostelname']."' or h.hlocation='".$data['hlocation']."'")->result();
                   
                    if (sizeof($valid)<=0) {
                        $this->db->insert("raghuerp_hostel.hostelconfig",$data);
                        return 'valid';
                    } else {
                        return 'invalid';
                    }

 
            }

              //  edit hostel config data
    public function edithostelconfig($data){
        
        $valid=  $this->db->query("select * from raghuerp_hostel.hostelconfig h where (h.hostelname='".$data['hostelname']."' or h.hlocation='".$data['hlocation']."') and h.hid!='".$data['hid']."'")->result();
        
         if (sizeof($valid)<=0) {
             # code...
             $this->db->where("hid",$data['hid']);
             $this->db->update("raghuerp_hostel.hostelconfig",$data);
             return 'valid';
         } else {
             # code...
             return 'invalid';
         }
              
            }

            
              //  edit hostel config data
    public function deletehostelconfig($data){

        $this->db->where("hid",$data['hid']);
        $this->db->delete("raghuerp_hostel.hostelconfig");
              
            }

                 //  change status in room types according to hostels
    public function changestatustype($data){
        

          if ($data['type']=='enable') {
            $data2=$this->db->query("select * from raghuerp_hostel.roomtype r where r.typeid='".$data['typeid']."'")->row();
            $view=explode(",",$data2->hostels);
            array_push($view,$data['hid']);
            $dsdata = implode(',', $view);
            $this->db->query("Update raghuerp_hostel.roomtype r set r.hostels='$dsdata' where r.typeid='".$data['typeid']."'");
          }
           elseif ($data['type']=='disable') {
            $data2=$this->db->query("SELECT *,FIND_IN_SET('".$data['hid']."',r.hostels) as ind from raghuerp_hostel.roomtype r where r.typeid='".$data['typeid']."'")->row();
            $view=explode(",",$data2->hostels);
            array_splice($view,((int)$data2->ind)-1,1);
            $dsdata = implode(',', $view);
            // $this->db->query("Update raghuerp_hostel.roomtype r set r.hostels=REPLACE(REPLACE(CONCAT(hostels), '".$data['hid']."', ''), ',,', ',') where r.typeid='".$data['typeid']."'");
            $this->db->query("Update raghuerp_hostel.roomtype r set r.hostels='$dsdata' where r.typeid='".$data['typeid']."'");
          }
          
                      
     }

                   //  change status in room types according to hostels
    public function getusersdataR($data){
        

          if ($data['utype']=='stf') {
            $data2=$this->db->query("select s.firstname,s.reg_no,s.gender from raghuerp_dbnew.staff s where not exists (select * from raghuerp_hostel.registereddetails r where r.reg_no=s.reg_no)")->result();
           
          } elseif ($data['utype']=='std') {
            $data2=$this->db->query("select s.firstname,s.reg_no,s.gender from raghuerp_dbnew.students s where not exists (select * from raghuerp_hostel.registereddetails r where r.reg_no=s.reg_no)")->result();
            
          }
          return $data2;
          
                      
     }

     
     
                   //  get hostelers data to outings
    public function getRoomDetails(){
      
            $data2=$this->db->query("SELECT rc.* FROM raghuerp_hostel.roomdetails rc");
            
          
          return $data2->result();
                         
     }

                      //  empty the room
    public function emptytheroom($data){

        if($data['empty']=='hosteltype'){
            $this->db->query("UPDATE raghuerp_hostel.roomsconfig rc INNER JOIN raghuerp_hostel.hostelconfig hc2 ON rc.hostelid=hc2.hid ,raghuerp_hostel.registereddetails rd INNER JOIN raghuerp_hostel.roomdetails rmd ON rd.reg_no=rmd.reg_no INNER JOIN raghuerp_hostel.roomsconfig rc3 ON rmd.roomno=rc3.rcid INNER JOIN raghuerp_hostel.hostelconfig hc3 ON rc3.hostelid=hc3.hid  SET rc.avlbeds=rc.totbeds,rc.rcstatus='available',rd.rstatus='deallocated' WHERE hc2.hosteltype='".$data['hosteltype']."' and hc3.hosteltype='".$data['hosteltype']."'");
            $this->db->query("DELETE FROM raghuerp_hostel.roomdetails USING raghuerp_hostel.roomdetails,raghuerp_hostel.roomsconfig,raghuerp_hostel.hostelconfig   WHERE raghuerp_hostel.roomdetails.roomno=raghuerp_hostel.roomsconfig.rcid and  raghuerp_hostel.roomsconfig.hostelid=raghuerp_hostel.hostelconfig.hid  and raghuerp_hostel.hostelconfig.hosteltype='".$data['hosteltype']."' ");
            
        } else  if($data['empty']=='hostel'){
            $this->db->query("UPDATE raghuerp_hostel.roomsconfig rc ,raghuerp_hostel.registereddetails rd INNER JOIN raghuerp_hostel.roomdetails rmd ON rd.reg_no=rmd.reg_no INNER JOIN raghuerp_hostel.roomsconfig rc2 on rc2.rcid=rmd.roomno and rc2.hostelid='".$data['hostel']."' SET rc.avlbeds=rc.totbeds,rc.rcstatus='available',rd.rstatus='deallocated' WHERE rc.hostelid='".$data['hostel']."' ");
            $this->db->query("DELETE FROM raghuerp_hostel.roomdetails USING raghuerp_hostel.roomdetails,raghuerp_hostel.roomsconfig  WHERE raghuerp_hostel.roomdetails.roomno=raghuerp_hostel.roomsconfig.rcid and raghuerp_hostel.roomsconfig.hostelid='".$data['hostel']."' ");
      
        } else  if($data['empty']=='room'){
            $this->db->query("UPDATE raghuerp_hostel.roomsconfig rc,raghuerp_hostel.registereddetails rd INNER JOIN raghuerp_hostel.roomdetails rmd ON rd.reg_no=rmd.reg_no and rmd.roomno='".$data['room']."' SET rc.avlbeds=rc.totbeds,rc.rcstatus='available',rd.rstatus='deallocated' WHERE rc.rcid='".$data['room']."'  ");
            $this->db->query("DELETE FROM raghuerp_hostel.roomdetails  WHERE roomno='".$data['room']."'");
      
        }
        
                      
    }
     
                   //  get rooms data bi hid
    public function getroomslistbyhid($data){
        

          if ($data['hid']=='all') {
            $data2=$this->db->query("SELECT rc.*,rt.type FROM raghuerp_hostel.roomsconfig rc INNER JOIN raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid");
           
          } else {
            $data2=$this->db->query("SELECT rc.*,rt.type FROM raghuerp_hostel.roomsconfig rc INNER JOIN raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid AND rc.hostelid='".$data['hid']."'");
            
          }
          return $data2->result();
          
                      
     }

                      //  get occupy data 
    public function getoccupydata($data){
        

          if ($data['roomno']=='') {
            
            if($data['roomtype']=='all'){
                  $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid  inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid and rc.hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid"; 
              
            }else if ($data['roomtype']!='all'){
                $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid  inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid and rc.hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid and rc.roomtype='".$data['roomtype']."' "; 
                
            }
        //     else if ($data['roomtype']=='all'){
        //         $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid  inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid  and rc.hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid ";
        //    }else if ($data['hid']=='all'){
        //        $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid  inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid  inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid and rc.roomtype='".$data['roomtype']."' ";
        //   } 
        
           
          } else {

                 if ($data['roomno']=='all') {

                                        if($data['roomtype']=='all'){
                                            $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid  inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid  and rc.hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid"; 
                                        
                                    }else if ($data['roomtype']!='all'){
                                        $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid  and rc.hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid and rc.roomtype='".$data['roomtype']."' "; 
                                        
                                    }
                                    // else if ($data['roomtype']=='all'){
                                    //     $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid and h.hid and rc.hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid ";
                                    // }else if ($data['hid']=='all'){
                                    //     $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid and rc.roomtype='".$data['roomtype']."' ";
                                    // } 

                 } else {


                                if($data['roomtype']=='all'){
                                    $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid  inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid  and rc.hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid"; 
                                
                            }else if ($data['roomtype']!='all'){
                                $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid and rd.roomno='".$data['roomno']."' inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid  and rc.hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid and rc.roomtype='".$data['roomtype']."' "; 
                                
                            }
                            // else if ($data['roomtype']=='all'){
                            //     $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid and rd.roomno='".$data['roomno']."' inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid and h.hid and rc.hostelid='".$data['hid']."' inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid ";
                            // }else if ($data['hid']=='all'){
                            //     $sql="select * from raghuerp_hostel.roomdetails rd  inner join raghuerp_hostel.roomsconfig rc on rd.roomno=rc.rcid and rd.roomno='".$data['roomno']."' inner join raghuerp_hostel.hostelconfig h on rc.hostelid=h.hid inner join raghuerp_hostel.roomtype rt on rc.roomtype=rt.typeid and rc.roomtype='".$data['roomtype']."' ";
                            // } 
                 }

                        
          }

          $data2=$this->db->query($sql)->result();
          return $data2;
                  
     }

     
                      //  get Register Users List
    public function getregisusers(){
        
          $data2=$this->db->query("SELECT rd.*,stf.firstname,clg.college,br.department,concat('') as year FROM raghuerp_hostel.registereddetails rd INNER JOIN raghuerp_dbnew.staff stf on rd.reg_no=stf.reg_no INNER JOIN raghuerp_dbnew.colleges clg on stf.college=clg.id INNER JOIN raghuerp_dbnew.departments br on stf.department=br.id
                                    UNION
                                    SELECT rd.*,std.firstname,clg.college,br.branch,yr.year FROM raghuerp_hostel.registereddetails rd INNER JOIN raghuerp_dbnew.students std on rd.reg_no=std.reg_no INNER JOIN raghuerp_dbnew.colleges clg on std.college=clg.id INNER JOIN raghuerp_dbnew.branches br on std.branch=br.id INNER JOIN raghuerp_dbnew.year yr on std.year=yr.id")->result();
          return $data2;
                  
     }


                        //  delete Register User
    public function delregisuser($data){
         
        $valid=$this->db->query("select r.reg_no from  raghuerp_hostel.roomdetails r where r.reg_no=(select rd.reg_no from raghuerp_hostel.registereddetails rd where rd.registerid='".$data['rid']."') ")->row();
       
        if ($valid) {
           
            return 'exists';
        } else {
         $this->db->query("DELETE FROM raghuerp_hostel.registereddetails  WHERE registerid='".$data['rid']."' ");
         return 'ok';
        }   
                  
     }

                        //  delete Register Users
    public function delallregisusers($data){

        if ($data['type']!='all') {
            $valid=$this->db->query("SELECT r.reg_no FROM  raghuerp_hostel.roomdetails r INNER JOIN raghuerp_dbnew.staff st on r.reg_no=st.reg_no and st.gender='".$data['type']."'
            UNION
            SELECT r.reg_no FROM  raghuerp_hostel.roomdetails r INNER JOIN raghuerp_dbnew.students std on r.reg_no=std.reg_no and std.gender='".$data['type']."'")->result();
            
        } else {
            $valid=$this->db->query("SELECT r.reg_no FROM  raghuerp_hostel.roomdetails r INNER JOIN raghuerp_dbnew.staff st on r.reg_no=st.reg_no 
            UNION
            SELECT r.reg_no FROM  raghuerp_hostel.roomdetails r INNER JOIN raghuerp_dbnew.students std on r.reg_no=std.reg_no ")->result();            
        }
        
       
        if (sizeof($valid)>0) {
           
            return 'exists';
        } else {

            if ($data['type']!='all') {
                $this->db->query("DELETE FROM raghuerp_hostel.registereddetails  WHERE reg_no IN ( SELECT * FROM raghuerp_dbnew.staff s WHERE s.gender='".$data['type']."') ");
                               
            } else {
                $this->db->query("DELETE FROM raghuerp_hostel.registereddetails ");
                
            }
         return 'ok';
        }   
                  
     }
 

     
                        //  get register form show Status
    public function getregstatus($data){
          
        if ($data['utype']=='adm') {
            $sql="select * from raghuerp_hostel.selectionstatus ss where ss.status='0'";
           $das= $this->db->query($sql)->result();

           if(sizeof($das)>0){
               $mes='disable';
            } else{
                $mes='enable';
            }

        } else {
            if ($data['gender']=='M') {
                $sql="select * from raghuerp_hostel.bookings bs where bs.hosteltype='Boys' and bs.status='enable'";
                $das= $this->db->query($sql)->result();
                
            } else if($data['gender']=='F') {
                $sql="select * from raghuerp_hostel.bookings bs where bs.hosteltype='Girls' and bs.status='enable'";
                $das= $this->db->query($sql)->result();
            }

            if(sizeof($das)>0){
                $mes='enable';
            } else{
                $mes='disable';
            }
            
        }
        
            return $mes;   
                          
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


    // mess


    
    public function insertlist($data)
    {  
        $latest_inn=0;
       //  $val1 = $data['insert_date'];
       // $insert_date = $val1['jsdate'];
        
        $from_to=$data['purchaser'];
        $insert_date1=$data['insert_date'];
        $receipt_no=$data['receipt_no']; 
        $discount=$data['discount']; 

        $active_list = $data['active_list'];
        $type =$data['type']; 
        $reg_no = $data['reg_no'];

       
      
        for($i=0; $i<sizeof($active_list); $i++) {
           $sql = "insert into raghuerp_mess.stock_register(discount,reg_no,item, quantity,price,receipt_no,edate,trans_type,balance,brand,from_to) values";
           $val = $active_list[$i];
           $quantity=  $this->db->query('SELECT * FROM `material` where mid="'.$val['name'].'" ORDER BY mid DESC limit 1')->row();
          
         
           if($quantity->latest_in==0){
           // echo 'if condition';
            $last_in_updated = date('Y-m-d h:i:s');
            $sql .= "('$discount','$reg_no','" . $val['name'] . "','" . $val['quantity'] . "','".$val['price']."','$receipt_no','$insert_date1','$type','" . $val['quantity'] . "','" . $val['brand'] . "','$from_to'),"; 
            $inupdate=  $this->db->query('update raghuerp_mess.material set latest_in="'.$val['quantity'].'" , total_balance = "'.$val["quantity"].'", last_in_updated =  "'.$last_in_updated.'" where mid="'.$val['name'].'" ');
            $discount=0;
           }else{
          
            $bal1 = $quantity->total_balance;
            $bal = $quantity->total_balance + $val['quantity'];

            $latest_inn += $val['quantity'];
            $last_in_updated = date('Y-m-d h:i:s');
             $sql .= "('$discount','$reg_no','" . $val['name'] . "','" . $val['quantity'] . "','".$val['price']."','$receipt_no','$insert_date1','$type',($bal1 + ".$val["quantity"]."),'" . $val['brand'] . "','$from_to'),";
            $inupdate=  $this->db->query('update raghuerp_mess.material set latest_in="'.$latest_inn.'" ,total_balance =  "'.$bal.'", last_in_updated =  "'.$last_in_updated.'"    where mid="'.$val['name'].'" ');
            } 
            $discount=0;    
              $sql = substr($sql, 0, strlen($sql)-1);    
              $result = $this->db->query($sql);
           }
           
           if($result){
            //$inupdate=  $this->db->query('SELECT SUM(price) FROM stock_register where receipt_no="'..'" ');
            $data1=[];
            $data1['receipt_no']= $receipt_no;
            $data1['discount']= $discount;
            $data1['purchase_date']=$insert_date1;
            if( $receipt_no!='' || $discount!=''){
              $result1 = $this->db->insert('raghuerp_mess.discount',$data1);
              $last_id = $this->db->insert_id();
            }else{
              return array("success" => true,"data"=>'');
            }
                       


            if($result1){
               return array("success" => true,"data"=>$last_id);
            }
            else{
              return array("success" => false);
            }
           

            }
         else
        {
            return array("success" => false);
        }

     }


//  public function itemoutlist($data)
//     {  
//         $latest_out=0;
        
//          $out_date1 = $data['out_date'];

//         $active_list1 = $data['active_list1'];
//         $type =$data['type'];
//         $slot =$data['slot']; 
//         $reg_no = $data['reg_no'];
                    

//         for($j=0; $j<sizeof($active_list1); $j++) {
//             $val1 = $active_list1[$j];
//             $sql = "insert into stock_register(reg_no,item, quantity,units,edate,slot_type,trans_type,balance) values";
//             $quantity= $this->db->query('SELECT * FROM `material` where mid="'.$val1['name'].'" ORDER BY mid DESC limit 1')->row();
           
//             if($quantity){
         
//             $bal1 = $quantity->total_balance; 


//             if($bal1 >= $val1['quantity'])
//             {
//             $bal = $quantity->total_balance - $val1['quantity'];
//             $latest_out += $val1['quantity'];
//             $last_out_updated = date('Y-m-d h:i:s');
//             $sql .= "('$reg_no','" . $val1['name'] . "','" . $val1['quantity'] . "','" . $val1['units'] . "','$out_date1','$slot','$type',($bal1 - ".$val1["quantity"].")),";
//             $inupdate=  $this->db->query('update `material` set latest_out="'.$latest_out.'" ,total_balance =  "'.$bal.'", last_out_updated= "'.$last_out_updated.'"  where mid="'.$val1['name'].'" ');

//             $sql = substr($sql, 0, strlen($sql)-1);
//             $result = $this->db->query($sql);    
//                     if($result){
//                   return array("success" => true);
//                   } 
//                   else
//                   {
//                  return array("success" => false);
//                  }
//             }
     

//            else{
//             // echo 'sai';
//              // return array("success" => false,"data" => $bal1);
//               return array("success" => false);
//            } 
//            }
//     }

// }

     public function itemoutlist($data)
    {  
        $data1 = $data['active_list1'];

        $sum = array_reduce($data1, function ($a, $b) {
            isset($a[$b['name']]) ? $a[$b['name']]['quantity'] += $b['quantity'] : $a[$b['name']] = $b;
            return $a;
        });

        

 // print_r(array_values($sum));
foreach($sum as $s)
{
    // $qty=boolean;
   // echo $s['name'];
//   $p=0;
//     $item_history=array();
//     $itemdata= $this->db->query('SELECT * FROM `material` where mid="'.$s['name'].'" ORDER BY mid DESC limit 1')->row();
//     $item_history[$p]=$itemdata;
// $p++;
    $i=0;
       $quantity= $this->db->query('SELECT * FROM raghuerp_mess.material where mid="'.$s['name'].'" ORDER BY mid DESC limit 1')->row();
           $bal12 = $quantity->total_balance;
           // echo $bal12.''.'ji';
           // echo $s['quantity'];
           // $name = $quantity->item;
            $item_history[$i] = $quantity->item.'---'.'Available Balance --'.$quantity->total_balance.' '.$quantity->units;
           // $avbal = $bal12;   
           if($bal12 >= $s['quantity'])
           {
            // echo 'test success';
            $qty = true;
            continue;
         
           }
           else
           {
            $qty = false;
            break;
           // echo 'test failed';
           }
 
}

        if($qty){
        $latest_out=0;
                
         $out_date1 = $data['out_date'];

        $active_list1 = $data['active_list1'];
        $type =$data['type'];
        $slot =$data['slot']; 
        $from_to =$data['from_to']; 
        $reg_no = $data['reg_no'];
                    

        for($j=0; $j<sizeof($active_list1); $j++) {
            $val1 = $active_list1[$j];
             $sql = "insert into raghuerp_mess.stock_register(reg_no,item, quantity, edate,slot_type,trans_type,balance,from_to) values";
            $quantity= $this->db->query('SELECT * FROM raghuerp_mess.material where mid="'.$val1['name'].'" ORDER BY mid DESC limit 1')->row();
          
             if($quantity){
                 $bal1 = $quantity->total_balance; 

            $bal = $quantity->total_balance - $val1['quantity'];
            $latest_out += $val1['quantity'];
            $last_out_updated = date('Y-m-d h:i:s');
            $sql .= "('$reg_no','" . $val1['name'] . "','" . $val1['quantity'] . "','$out_date1','$slot','$type',($bal1 - ".$val1["quantity"]."),'$from_to'),";
            $inupdate=  $this->db->query('update raghuerp_mess.material set latest_out="'.$latest_out.'" ,total_balance =  "'.$bal.'", last_out_updated= "'.$last_out_updated.'"  where mid="'.$val1['name'].'" ');

            $sql = substr($sql, 0, strlen($sql)-1);
            $result = $this->db->query($sql);  
         
         }


        } 
        return array("success" => true);
     }
     else
        {
        return array("success" => false, "data" => $item_history);
        }    
    }

 //get list for mess
     public function getlist(){
        
        $sql ="select * from raghuerp_mess.material";
        $data=$this->db->query($sql);
         return   $data->result();
      // return $arr;
         
 
        // print_r($new_array);
        // foreach ($new_array as $name => $items)
        // {

        //   echo $name . '<br>'; 

        //   foreach ($items as $index => $item)
        //   {
        //     echo ($index + 1) . '. ' . $item . '<br>';
        //   }

        //   echo '___<br>';

        // }

         //return $arr;

    }

    public function addnewitem($data)
    {
          $result = $this->db->query('SELECT item FROM raghuerp_mess.material  where  item = "'.$data['item'].'" limit 1')->row();
        if($result){
             return array("success"=> false, $data);
        }else{
          $sql=$this->db->insert('raghuerp_mess.material',$data);

          if($sql){
            return array("success"=> true);
        } 
        }
   
    }
      public function menulist($data)
    {
       $this->db->insert('raghuerp_mess.menu_list',$data);
    }

    public function getmenulist(){
        
        $sql ="select * from raghuerp_mess.menu_list";
        $data=$this->db->query($sql);
        return $data->result();         
    }
    // public function updatelist($params)
    // {
    // $this->db->query('update menu_list set breakfast= "'.$params['breakfast'].'", lunch =  "'.$params['lunch'].'", snacks =  "'.$params['snacks'].'", dinner =  "'.$params['dinner'].'"  where id =  "'.$params['id'].'"');
    //  }

    public function updatelist($params)
    {
    $this->db->query('update raghuerp_mess.menu_list set breakfast= "'.$params['breakfast'].'", lunch =  "'.$params['lunch'].'", snacks =  "'.$params['snacks'].'", dinner = "'.$params['dinner'].'"  where id =  "'.$params['id'].'"');
     }


    //  public function stockRegister(){
    //   //  $result = $this->db->query('SELECT *, m.item,max(balance) as tot_balance , sum(price) as total_PRICE FROM stock_register s INNER join material m on m.mid=s.item GROUP by s.item order by balance')->result();
    //      $result = $this->db->query('SELECT s.*, m.item as item_name,m.units as units FROM stock_register s INNER join material m on m.mid=s.item   order by srid DESC ')->result();
    //     if($result){
    //         return array("success"=>true, "data"=>$result);
    //     }else{
    //         return array("success"=>false);
    //     }
    // }

     public function stockRegister(){
       $result = $this->db->query('SELECT s.*,b.bill_name,b.id, m.item as item_name,m.units as units,m.item_type FROM raghuerp_mess.stock_register s INNER join raghuerp_mess.material m on m.mid=s.item LEFT JOIN raghuerp_mess.bills b on b.billno = s.receipt_no   order by s.insert_dt DESC')->result();
        // $result = $this->db->query('SELECT s.*, m.item as item_name,m.units as units FROM stock_register s INNER join material m on m.mid=s.item   order by s.insert_dt DESC ')->result();
        if($result){
            return array("success"=>true, "data"=>$result);
        }else{
            return array("success"=>false);
        }
    }

    //  public function stockBalance(){
    //   //  $result = $this->db->query('SELECT *, m.item,max(balance) as tot_balance , sum(price) as total_PRICE FROM stock_register s INNER join material m on m.mid=s.item GROUP by s.item order by balance')->result();
    //      $result = $this->db->query('SELECT * FROM  material order by item ASC ')->result();
    //     if($result){
    //         return array("success"=>true, "data"=>$result);
    //     }else{
    //         return array("success"=>false);
    //     }
    // }

    public function stockBalance(){
      //  $result = $this->db->query('SELECT *, m.item,max(balance) as tot_balance , sum(price) as total_PRICE FROM stock_register s INNER join material m on m.mid=s.item GROUP by s.item order by balance')->result();
         // $result = $this->db->query('SELECT * FROM material order by item ASC ')->result();
     $result= $this->db->query('SELECT * FROM raghuerp_mess.material ORDER BY CASE WHEN total_balance <= minvalue THEN 1 ELSE 2 END')->result();
        if($result){
            return array("success"=>true, "data"=>$result);
        }else{
            return array("success"=>false);
        }
    } 

    public function getunits($params){
        // echo $params['mid'];
        
        $sql = $this->db->query('select *  from raghuerp_mess.material where mid = "'. $params['mid'] .'"')->row();
        
        if($sql){

          return array("success"=>true, "data"=>$sql);
        }
        else{
            return array("success"=>false);
        }
          
    }


       public function purchaserlist($data){
       $list = $data['list'];
       $purchaser = $data['purchaser'];

   $sql = "insert into raghuerp_mess.purchase(mid,item,quantity,units,purchaser) values";
        for($i=0; $i<sizeof($list); $i++) {
            $val = $list[$i];
           // if (strlen(trim($val['description'])) > 0) {
                $sql .= "('" . $val['mid'] . "','" . $val['item'] . "','" . $val['quantity'] . "','" . $val['units'] . "','$purchaser'),";
           //}
        }

        $sql = substr($sql, 0, strlen($sql)-1);

       if($this->db->query($sql))
       {
      return array("success" => true);
      }
      else
      {
      return array("success" => false);
    }
  }



  // public function purchaseItemsList(){
  //     //  $result = $this->db->query('SELECT *, m.item,max(balance) as tot_balance , sum(price) as total_PRICE FROM stock_register s INNER join material m on m.mid=s.item GROUP by s.item order by balance')->result();
  //        $result = $this->db->query('SELECT * FROM  purchase order by pid DESC')->result();
  //       if($result){
  //           return array("success"=>true, "data"=>$result);
  //       }else{
  //           return array("success"=>false);
  //       }
  //   }


  public function purchaseItemsList(){
      //  $result = $this->db->query('SELECT *, m.item,max(balance) as tot_balance , sum(price) as total_PRICE FROM stock_register s INNER join material m on m.mid=s.item GROUP by s.item order by balance')->result();
         // $result = $this->db->query('SELECT * FROM purchase order by pid DESC')->result();
    $result = $this->db->query('SELECT s.status,s.pdate,m.name,m.mobile_no FROM raghuerp_mess.purchase s INNER join raghuerp_mess.purchasers_list m on m.id=s.purchaser   GROUP BY pdate ORDER BY pid DESC')->result();
        if($result)
        {
            return array("success"=>true, "data"=>$result);
        }
        else
        {
            return array("success"=>false);
        }
    }


 public function deleteitem($params)
  {
    // $sql = 'delete from material where mid = "'. $params['mid'] .'"';
    // $data =  $this->db->query($sql);
    // return $data->result(); 
    $sql = $this->db->query('delete from raghuerp_mess.material where mid = "'. $params['mid'] .'"');
    if($sql)
    {
        return array("success" => true);
    }

  }

  // public function updatematerialslist($params)
  //   {    
  //  $sql = $this->db->query('update material set item = "'.$params['item'].'", units =  "'.$params['units'].'", minvalue =  "'.$params['minvalue'].'" where mid =  "'.$params['mid'].'"');
  //  if($sql)
  //  {
  //   return array("success" => true);
  //  }
  //  else
  //  {
  //   return array("succses" => false);
  //  }
  //  }


  public function updatematerialslist($params)
    {
   $sql = $this->db->query('update raghuerp_mess.material set item = "'.$params['item'].'",item_type = "'.$params['item_type'].'", units =  "'.$params['units'].'", minvalue = "'.$params['minvalue'].'" where mid =  "'.$params['mid'].'"');
   if($sql)
   {
    return array("success" => true);
   }
   else
   {
    return array("succses" => false);
   }
   }


   // public function selected_PurchaseData($params){
   //    $date   = $params['date'];
   //    $status = $params['status'];
   // // echo $date;
   //   if($status == 'all'){
   //       // echo $date;
   //       $result = $this->db->query(' SELECT * FROM purchase where DATE(pdate)= "'.$date.'"')->result();
                   
   //   }else{
        
   //        $result = $this->db->query(' SELECT * FROM purchase where DATE(pdate)= "'.$date.'" and status = "'.$status.'" ')->result();
   //   }
   //   if($result){
   //          return array("success"=>true, "data"=>$result);
   //        }else{
   //          return array("success"=>false);
   //        }
   // }

   public function selected_PurchaseData($params){
      $date   = $params['date'];
      $status = $params['status'];
   // echo $date;
     if($status == 'all'){
         // echo $date;
         // $result = $this->db->query(' SELECT * FROM purchase where DATE(pdate)= "'.$date.'" group by pdate ')->result();
           $result = $this->db->query('SELECT s.status,s.pdate,m.name,m.mobile_no FROM raghuerp_mess.purchase s INNER join raghuerp_mess.purchasers_list m on m.id=s.purchaser where DATE(pdate) ="'.$date.'" group by pdate ')->result();

     }
     // if($status == 'all' && $date == '')
     // {
     //  $result = $this->db->query('SELECT s.status,s.pdate,m.name,m.mobile_no FROM purchase s INNER join purchasers_list m on m.id=s.purchaser  group by pdate ')->result();
     // }
     // if($status != 'all')
     // {
     //  $result = $this->db->query('SELECT s.status,s.pdate,m.name,m.mobile_no FROM purchase s INNER join purchasers_list m on m.id=s.purchaser  where status ="'.$status.'" group by pdate ')->result();
     // }

     else{

          // $result = $this->db->query(' SELECT * FROM purchase where DATE(pdate)= "'.$date.'" and status = "'.$status.'" group by pdate')->result();
      $result = $this->db->query('SELECT s.status,s.pdate,m.name,m.mobile_no FROM raghuerp_mess.purchase s INNER join raghuerp_mess.purchasers_list m on m.id=s.purchaser where DATE(pdate) ="'.$date.'" and status ="'.$status.'" group by pdate ')->result();
     }

     if($result){
            return array("success"=>true, "data"=>$result);
          }
          else
          {
            return array("success"=>false);
          }
   } 

   public function itembuy($params)
   {
    $list = $params['list'];
    // print_r($list);
     for($i=0; $i<sizeof($list); $i++) {
      // echo $list[$i]['pid'];
      // echo $list[$i];
            $val = $list[$i]['pid'];
            $val1 =$list[$i]['mid'];
    $update = "update  raghuerp_mess.purchase set status = 1 where pid = '$val' and mid = '$val1' ";
     $result  = $this->db->query($update);
      }
    
     if($result)
       {
      return array("success" => true);
      }
      else
      {
      return array("success" => false);
      }

   }

   public function getCategories(){

    $result = $this->db->query('SELECT  item_type  from raghuerp_mess.material  GROUP by item_type')->result();
    if($result){
       return array("success" => true, "data"=>$result);
    }else{
       return array("success" => false);
    }
   }

   public function getItemsbyCategory($params){

    $result = $this->db->query('SELECT mid,item,item_type,units FROM raghuerp_mess.material where  item_type= "'.$params['item_type'].'" ORDER by item ASC')->result();
    if($result){
       return array("success" => true, "data"=>$result);
    }else{
       return array("success" => false);
    }
   }


   public function getnames()
  {

    $result = $this->db->query('SELECT * FROM raghuerp_mess.purchasers_list ')->result();
        if($result){
            return array("success"=>true, "data"=>$result);
        }else{
            return array("success"=>false);
        }

  }
  public function purchaserdetails($params){
    $result = $this->db->query('select * from raghuerp_mess.purchase where pdate = "' . $params['date'] . '"')->result();
        if($result){
            return array("success"=>true, "data"=>$result);
        }else{
            return array("success"=>false);
        }
    }
    public function status($params){
    $result = $this->db->query('update raghuerp_mess.purchase set status = 1 where pdate = "' . $params['date'] . '"');
        if($result){
            return array("success"=>true);
        }else{
            return array("success"=>false);
        }
    } 

    public function  purchasersname($params)
    {
       $result = $this->db->query('SELECT name FROM raghuerp_mess.purchasers_list  where  name = "'.$params['name'].'" limit 1')->row();
        if($result){
             return array("success"=> false, $params);
        }else{
          $sql=$this->db->insert('raghuerp_mess.purchasers_list',$params);

          if($sql){
            return array("success"=> true);
        }
        }

    }

   public function  purchaseupdate($params)
   {
     $sql = $this->db->query('update raghuerp_mess.purchasers_list set name = "'.$params['name'].'",location = "'.$params['location'].'", mobile_no =  "'.$params['mobile_no'].'" where id = "'.$params['id'].'"');
   if($sql)
   {
    return array("success" => true);
   }
   else
   {
    return array("success" => false);
   }
   }
   public function purchasersdelete($params)
  {
    // $sql = 'delete from material where mid = "'. $params['mid'] .'"';
    // $data =  $this->db->query($sql);
    // return $data->result();
    $sql = $this->db->query('delete from raghuerp_mess.purchasers_list where id = "'. $params['id'] .'"');
    if($sql)
    {
        return array("success" => true);
    }

  }

  ///sql


  public function addcategory($params)
  {
    $result = $this->db->query('SELECT item_type FROM raghuerp_mess.categories  where  item_type = "'.$params['item_type'].'" limit 1')->row();
        if($result){
             return array("success"=> false, $params);
        }
        else
        {
          $sql=$this->db->insert('raghuerp_mess.categories',$params);

          if($sql){
            return array("success"=> true);
     } 
   }
  }


  public function getCategoriesfornewItem(){
     $result = $this->db->query('SELECT * FROM raghuerp_mess.categories ORDER BY item_type ASC')->result();
        if($result){
             return array("success"=> true, "data"=> $result);
          }
        else
          {
            return array("success"=> false);
          } 
  }

  public function getlastInsertDate(){
     $result = $this->db->query('SELECT   year(date(edate)) as year ,month(date(edate)) as month , day(date(edate)-1) as day  FROM raghuerp_mess.stock_register where srid= (SELECT max(srid) FROM raghuerp_mess.stock_register)')->row();
        if($result){
             return array("success"=> true, "data"=> $result);
          }
        else
          {
            return array("success"=> false);
          } 
  }


  public function getImagesbyId($params=''){
     $result = $this->db->query('SELECT * FROM raghuerp_mess.bills where id="'.$params['id'].'"')->row();
        if($result){
             return array("success"=> true, "data"=> $result);
          }
        else
          {
            return array("success"=> false);
          } 
  }

  public function reportsdate($params)
     {
      // $result = $this->db->query('SELECT sum(price) as p from stock_register where Date(edate) BETWEEN "'.$params['from_date'].'" AND DATE_ADD("'.$params['end_date'].'",INTERVAL 1 DAY)')->result();
      $result1 = $this->db->query('select sum(price) as actotal,edate,sum(discount)as discount, ( sum(price) - sum(discount)) as grandtot from raghuerp_mess.stock_register   where trans_type = "IN" and edate BETWEEN "'.$params['from_date'].'" AND DATE_ADD("'.$params['end_date'].'",INTERVAL 1 DAY)GROUP by edate ORDER by edate DESC')->result();
      // $result = $this->db->query('SELECT *,sum(price) as a from stock_register where DATE(edate) BETWEEN "'.$params['from_date'].'" AND DATE_ADD("'.$params['end_date'].'",INTERVAL 1 DAY) group by DATE(edate) ')->result();
        $result = $this->db->query('select (select sum(price) from raghuerp_mess.stock_register where edate BETWEEN "'.$params['from_date'].'" AND DATE_ADD("'.$params['end_date'].'",INTERVAL 1 DAY)) - (SELECT sum(discount) from raghuerp_mess.stock_register where trans_type="IN" and  edate  BETWEEN "'.$params['from_date'].'" and  DATE_ADD("'.$params['end_date'].'", INTERVAL 1 DAY)) as total')->result();
        if($result){
            return array("success"=>true, "data"=>$result1, "data1"=>$result);
        }else{
            return array("success"=>false);
        }
    }

    public function report_details($params)
    {
      $result1= $this->db->query(' SELECT s.*, m.item as item_name,m.units as units FROM raghuerp_mess.stock_register s INNER join raghuerp_mess.material m on m.mid=s.item where edate = "'.$params['date1'].'"')->result();
      if($result1)
      {
        return array("success"=>true, "data" => $result1);
      }
      else
      {
        return array("success"=>false);
      }
    }

   


}
?>