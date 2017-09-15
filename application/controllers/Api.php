<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require APPPATH . "/libraries/REST_Controller.php";

if (isset($_SERVER['HTTP_ORIGIN'])) {
	header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
	header('Access-Control-Allow-Credentials: true');
	header('Access-Control-Max-Age: 86400');    // cache for 1 day
}

// Access-Control headers are received during OPTIONS requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

	if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
		header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

	if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
		header("Access-Control-Allow-Headers:        {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

	exit(0);
}


class Api extends REST_Controller {
	public function __construct()
	{
		parent::__construct();
		$this->load->model('Api_model');
		$this->load->helper('jwt');
	}
	public function __destruct() {  
	    $this->db->close();  
	} 
    
	public function index_get()
	{
		$this->response('NULL');
	}
	public function validLogin_post()
	{
		$username = $this->post('username');
		$password = $this->post('password');
		$result = $this->Api_model->login($username, $password);
		
		if ($result['success']) {
			// user logged in, generate a token and return
			$id = $result['reg_no'];
			$token = array();
			$token['reg_no'] = $id;
			$result['token'] = JWT::encode($token, $this->config->item('jwt_key'));
			$result['name'] = $result['name'];
			$result['utype'] = $result['utype'];
			$this->response($result);
		} else {
			// authentication failed, return error
			$this->response(
				array(
					"success"	=> $result['success'], 
					"error"		=> $result['error'],
				)
			);
		}
	}	
		
	function getData($type, $params=null) {
		$success = true;
		$error = '';
		$result = '';
		$response = [];
				
		if(!$_SERVER['HTTP_TOKEN']) {
			$success = false;
			$error = "Token not provided";
		}
		
		if ($success) {
			try 
			{
				$token = JWT::decode($_SERVER['HTTP_TOKEN'], $this->config->item('jwt_key'));
	
				if ($token->reg_no) {		
					switch($type) {
						case 'userData'				: $result = $this->Api_model->userData($token->reg_no); break;
						case 'changePassword'		: $result = $this->Api_model->changePassword($token->reg_no, $params); break;
						case 'addbooking'		    : $result = $this->Api_model->addbooking($params); break;
						case 'editbooking'		    : $result = $this->Api_model->editbooking($params); break;
						case 'deletebooking'		    : $result = $this->Api_model->deletebooking($params); break;
						case 'feeconfig'		    : $result = $this->Api_model->feeconfig($params); break;
					    case 'addtype'		        : $result = $this->Api_model->addtype($params); break;
						case 'editroomtype'		    : $result = $this->Api_model->editroomtype($params); break;
						case 'deleteroomtype'	    : $result = $this->Api_model->deleteroomtype($params); break;
						case 'getroomtype'		  	: $result = $this->Api_model->getroomtype(); break;
						case 'getbookingslist'		  	: $result = $this->Api_model->getbookingslist(); break;
						case 'getreglist'		  	: $result = $this->Api_model->getreglist($params); break;
						case 'vacantroom'	    : $result = $this->Api_model->vacantroom($params); break;
						case 'waitinglist'	    : $result = $this->Api_model->waitinglist($params); break;
						case 'addroomconfig'	    : $result = $this->Api_model->addroomconfig($params); break;
						case 'getroomconfig'	    : $result = $this->Api_model->getroomconfig($params); break;
						case 'getroomslistavlb'	    : $result = $this->Api_model->getroomslistavlb($params); break;
						case 'getbedslistbyroomno'	    : $result = $this->Api_model->getbedslistbyroomno($params); break;
						case 'getdetailstoadd'	    : $result = $this->Api_model->getdetailstoadd($params); break;
						case 'getdetailsbyid'	    : $result = $this->Api_model->getdetailsbyid($params); break;
						case 'gettotalrooms'	    : $result = $this->Api_model->gettotalrooms($params); break;
						case 'getdetailsbyroom'	    : $result = $this->Api_model->getdetailsbyroom($params); break;
						case 'editstuddetails'	    : $result = $this->Api_model->editstuddetails($params); break;
						case 'allocateroomstud'	    : $result = $this->Api_model->allocateroomstud($params); break;
						case 'freetheroom'	    : $result = $this->Api_model->freetheroom($params); break;
						case 'getavlseatscount'	    : $result = $this->Api_model->getavlseatscount($params); break;
						case 'editroomconfig'	    : $result = $this->Api_model->editroomconfig($params); break;
						case 'deleteroomconfig'	    : $result = $this->Api_model->deleteroomconfig($params); break;
						case 'addbilltype'			: $result = $this->Api_model->addbilltype($params);	break;
						case 'getbilltypes'			: $result = $this->Api_model->getbilltypes($params);	break;
						case 'deletebilltype'			: $result = $this->Api_model->deletebilltype($params);	break;
						case 'addpaymentdata'			: $result = $this->Api_model->addpaymentdata($params);	break;
						case 'getmaintenancedata'			: $result = $this->Api_model->getmaintenancedata($params);	break;
						case 'getstudataexreg'			: $result = $this->Api_model->getstudataexreg();	break;
						case 'getstudatabyid'			: $result = $this->Api_model->getstudatabyid($params);	break;

					 // new
						case 'gethostelconfig'			: $result = $this->Api_model->gethostelconfig();	break;
						case 'addhostelconfig'			: $result = $this->Api_model->addhostelconfig($params);	break;
						case 'edithostelconfig'			: $result = $this->Api_model->edithostelconfig($params);	break;
						case 'deletehostelconfig'			: $result = $this->Api_model->deletehostelconfig($params);	break;
						case 'changestatustype'			: $result = $this->Api_model->changestatustype($params);	break;
						case 'getusersdataR'			: $result = $this->Api_model->getusersdataR($params);	break;
						case 'getroomslistbyhid'			: $result = $this->Api_model->getroomslistbyhid($params);	break;
						case 'getoccupydata'			: $result = $this->Api_model->getoccupydata($params);	break;
						case 'getregisusers'			: $result = $this->Api_model->getregisusers();	break;
						case 'delregisuser'			: $result = $this->Api_model->delregisuser($params);	break;
						case 'delallregisusers'			: $result = $this->Api_model->delallregisusers($params); break;
						case 'getregstatus'			: $result = $this->Api_model->getregstatus($params);	break;
						case 'changebookingenddate'			: $result = $this->Api_model->changebookingenddate($params); break;
						case 'emptytheroom'			: $result = $this->Api_model->emptytheroom($params); break;
						case 'getvalidusertest'			: $result = $this->Api_model->getvalidusertest($params); break;
						case 'changeregistration'			: $result = $this->Api_model->changeregistration($params); break;
						
						// roomdetails for venkat sai
						case 'getRoomDetails'			: $result = $this->Api_model->getRoomDetails(); break;
						
                    //venkat
						case 'addregistration'		: $result = $this->Api_model->addregistration($params); break;
						case 'addcomplaints'		: $result = $this->Api_model->addcomplaints($params); break;
						case 'addnotification'		: $result = $this->Api_model->addnotification($params); break;
						case 'getcomplaintslist'	: $result = $this->Api_model->getcomplaintslist(); break;
						case 'getcomplaints'		: $result = $this->Api_model->getcomplaints($params); break;
						case 'getNotifications'		: $result = $this->Api_model->getNotifications($params); break;
						case 'addInstractions'		: $result = $this->Api_model->addInstractions($params); break;
						case 'getInstructions'		: $result = $this->Api_model->getInstructions($params);	break;
						case 'addEvents'			: $result = $this->Api_model->addEvents($params);	break;
						case 'getEvents'			: $result = $this->Api_model->getEvents($params);	break;
						case 'getEvents'			: $result = $this->Api_model->getEvents($params);	break;

						


						//  MESS
						case 'getlist'				: $result = $this->Api_model->getlist($params); break;
						case 'insertlist'			: $result = $this->Api_model->insertlist($params); break;
						case 'itemoutlist'			: $result = $this->Api_model->itemoutlist($params); break;
						case 'addnewitem'			: $result = $this->Api_model->addnewitem($params); break;
						case 'menulist'				: $result = $this->Api_model->menulist($params); break;
						case 'getmenulist' 			: $result = $this->Api_model->getmenulist($params); break;
						case 'updatelist' 			: $result = $this->Api_model->updatelist($params); break;
	
						case 'stockRegister'		: $result = $this->Api_model->stockRegister($params); break;
						case 'stockBalance'			: $result = $this->Api_model->stockBalance($params); break;
						case 'getunits'				: $result = $this->Api_model->getunits($params); break;	
						case 'purchaserlist'		: $result = $this->Api_model->purchaserlist($params); break;	
						case 'purchaseItemsList'	: $result = $this->Api_model->purchaseItemsList($params); break;
						case 'updatematerialslist'	: $result = $this->Api_model->updatematerialslist($params); break;
						case 'deleteitem'			: $result = $this->Api_model->deleteitem($params); break;
						case 'selected_PurchaseData': $result = $this->Api_model->selected_PurchaseData($params); break;
						case 'itembuy'				: $result = $this->Api_model->itembuy($params); break;
						case 'getCategories'		: $result = $this->Api_model->getCategories($params); break;
						case 'getItemsbyCategory'	: $result = $this->Api_model->getItemsbyCategory($params); break;
						case 'getnames'				: $result = $this->Api_model->getnames($params); break;
						case 'purchaserdetails'		: $result = $this->Api_model->purchaserdetails($params); break;
						case 'status'				: $result = $this->Api_model->status($params); break;
						case 'purchasersname'		: $result = $this->Api_model->purchasersname($params); break;
						case 'purchaseupdate'		: $result = $this->Api_model->purchaseupdate($params); break;
						case 'purchasersdelete'		: $result = $this->Api_model->purchasersdelete($params); break;
						case 'addcategory'			: $result = $this->Api_model->addcategory($params); break; 
						case 'getCategoriesfornewItem': $result = $this->Api_model->getCategoriesfornewItem($params); break;
						case 'getlastInsertDate'	: $result = $this->Api_model->getlastInsertDate($params); break; 
						case 'getImagesbyId'		: $result = $this->Api_model->getImagesbyId($params); break;  
						case 'reportsdate'			: $result = $this->Api_model->reportsdate($params); break;
						case 'report_details'		: $result = $this->Api_model->report_details($params); break;
						
					}
				
					$success = true;
				}
			} 
			catch (Exception $e)
			{
				$success = false;
				$error = "Token authentication failed";
			}					
		}
		
		$response['success'] = $success;
		$response['error'] = $error;
		if ($success) {
			$response['data'] = $result;
		}		
		$this->response($response);
	}


	// Add new Booking post
	public function addbooking_post(){

		$data['startdate']=$this->post('startdate')['formatted'];
		$data['enddate']=$this->post('enddate')['formatted'];
		$data['semstartdate']=$this->post('semstartdate')['formatted'];
		$data['semenddate']=$this->post('semenddate')['formatted'];
		$data['hosteltype']=$this->post('hosteltype');
		$data['description']=$this->post('description');
	    $this->getData('addbooking',$data);	    	
	   
	}

	
	// postpone/prepone booking end date
	public function changebookingenddate_post(){
		$data['value']=$this->post('value');
		$data['type']=$this->post('type');
		$data['bid']=$this->post('bid');
				$this->getData('changebookingenddate',$data);	    	
			   
			}



		// Edit Booking post
	public function editbooking_post(){
		$data['startdate']=$this->post('startdate')['formatted'];
		$data['enddate']=$this->post('enddate')['formatted'];
		$data['semstartdate']=$this->post('semstartdate')['formatted'];
		$data['semenddate']=$this->post('semenddate')['formatted'];
		$data['hosteltype']=$this->post('hosteltype');
		$data['description']=$this->post('description');
		$data['bid']=$this->post('bid');
	    $this->getData('editbooking',$data);	    	
	   
	}
			// Edit Booking post
	public function deletebooking_post(){
	
		$data['bid']=$this->post('bid');
	    $this->getData('deletebooking',$data);	    	
	   
	}

	// Add new Fee Config post
	public function feeconfig_post(){
		
		$data['roomtype']=$this->post('roomtype');
		$data['totalamount']=$this->post('totalamount');
		$data['totaldues']=$this->post('totaldues');
	    $this->getData('feeconfig',$data);	    	
	
	}

		// Add room type post
	public function addtype_post(){	
		$data['type']=$this->post('type');
		$data['hostels']=$this->post('hostels');	
	    $this->getData('addtype',$data);	    	
	 
	}

		// edit room type post
	public function editroomtype_post(){		
		$data['type']=$this->post('type');
		$data['totalcount']=$this->post('totalcount');
		$data['cost']=$this->post('cost');
		$data['totaldues']=$this->post('totaldues');
		 $data['amt_perdue']=$data['cost']/$data['totaldues'];	
		 $data['typeid']=$this->post('typeid');	
	    $this->getData('editroomtype',$data);	    	
	 
	}
		// delete room type post
	public function deleteroomtype_post(){
		$data['typeid']=$this->post('typeid');		
		 $this->getData('deleteroomtype',$data);
	}

	// roomtype get view
	public function roomtype_get(){		    
	   
	    $data=[];
	    $this->getData('getroomtype',$data);	
	     
	}

	// regester list get view
	public function getreglist_post(){		    
	   
		$data['type']=$this->post('type');
		$data['gender']=$this->post('gender');
	    $this->getData('getreglist',$data);	
	     
	}

		// get valid exists regester list 
		public function getvalidusertest_post(){		    
			
			 $data['reg_no']=$this->post('reg_no');
			 $this->getData('getvalidusertest',$data);	
			  
		 }

		 	// get valid exists regester list 
		public function changeregistration_post(){		    
			
			 $data['registerid']=$this->post('registerid');
			 $data['hostellocation']=$this->post('hostellocation');
			 $data['roomtype']=$this->post('roomtype');
			 $data['typepriority']=$this->post('typepriority');

			 $this->getData('changeregistration',$data);	
			  
		 }

	// bookings list get view
	public function getbookingslist_get(){		    
	   
	    $data=[];
	    $this->getData('getbookingslist',$data);	
	     
	}

	// rooms list get view
	public function getroomconfig_post(){		    
	   
	    $data['rtype']=$this->post('rtype');
		$data['hid']=$this->post('hid');
	    $this->getData('getroomconfig',$data);	
	     
	}
	
	// vacant room post 
		public function vacantroom_post(){		    
    $data['registerid']=$this->post('registerid');
	$data['type']=$this->post('type');
	    $this->getData('vacantroom',$data);	
	     
	}

		// waiting list  post 
		public function waitinglist_post(){		    
			$data['registerid']=$this->post('registerid');
		
				$this->getData('waitinglist',$data);	
				 
			}

		// Add room config post
	public function addroomconfig_post(){	
		$data['roomtype']=$this->post('roomtype');
		$data['totbeds']=$this->post('totbeds');
		$data['avlbeds']=$this->post('totbeds');
		$data['roomno']=$this->post('roomno');
		$data['hostelid']=$this->post('hostelid');
		$data['roomrent']=$this->post('roomrent');
		$data['floorno']=$this->post('floorno');		
	    $this->getData('addroomconfig',$data);	    	
	 
	}

		// get rooms available  list post
	public function getroomslistavlb_post(){	
		$data['hid']=$this->post('hid');	
	    $this->getData('getroomslistavlb',$data);	    	
	 
	}

			// get rooms available  list post
	public function gettotalrooms_post(){	
		$data['hosteltype']=$this->post('hosteltype');	
	    $this->getData('gettotalrooms',$data);	    	
	 
	}


	// get beds list by roomno post
	public function getbedslistbyroomno_post(){	
		$data['hostelid']=$this->post('hostelid');
		$data['rcid']=$this->post('rcid');	
	    $this->getData('getbedslistbyroomno',$data);	    	
	 
	}


	// get beds list by roomno post
	public function getdetailstoadd_post(){	
		$data['hosteltype']=$this->post('hosteltype');
		$data['reg_no']=$this->post('reg_no');	
	    $this->getData('getdetailstoadd',$data);	    	
	 
	}

		// get student details list by id post
	public function getdetailsbyid_post(){	
		$data['utype']=$this->post('utype');
		$data['reg_no']=$this->post('reg_no');	
	    $this->getData('getdetailsbyid',$data);	    	
	 
	}

			// get student details list by id post
	public function getdetailsbyroom_post(){	
		$data['hosteltype']=$this->post('type');
		$data['roomno']=$this->post('roomno');	
		$data['bedno']=$this->post('bedno');	
	    $this->getData('getdetailsbyroom',$data);	    	
	 
	}


			// edit student details by rid
	public function editstuddetails_post(){	
		$data['registrationid']=$this->post('registrationid');
		$data['studentname']=$this->post('studentname');
		$data['dateofbirth']=$this->post('dateofbirth')['formatted'];
		$data['genderT']=$this->post('genderT');
		$data['pwd']=$this->post('pwd');
		$data['distance']=$this->post('distance');
		$data['fathername']=$this->post('fathername');
		$data['occupation']=$this->post('occupation');
		$data['parentmobile']=$this->post('parentmobile');
		$data['parentemail']=$this->post('parentemail');
		$data['parentaddress']=$this->post('parentaddress');
		$data['guardianname']=$this->post('guardianname');
		$data['guardianrelation']=$this->post('guardianrelation');
		$data['guardianmobile']=$this->post('guardianmobile');
		$data['guardianemail']=$this->post('guardianemail');
		$data['guardianaddress']=$this->post('guardianaddress');
		
	    $this->getData('editstuddetails',$data);	    	
	   
	}

		// allocate Room student by regno
	public function allocateroomstud_post(){	
		$data['rcid']=$this->post('rcid');
		$data['bedno']=$this->post('bedno');
		$data['reg_no']=$this->post('reg_no');
		$data['utype']=$this->post('utype');
		$data['prevrcid']=$this->post('prevrcid');

		
	    $this->getData('allocateroomstud',$data);	    	
	   
	}

		// Free Room 
		public function freetheroom_post(){	
			$data['rcid']=$this->post('rcid');
			$data['reg_no']=$this->post('reg_no');
			

			$this->getData('freetheroom',$data);	    	
		   
		}

	// Free Room 
	public function getavlseatscount_post(){	
        $data['hosteltype']=$this->post('hosteltype');
		$this->getData('getavlseatscount',$data);	    	
	   
	}

	// Edit Room Config 
	public function editroomconfig_post(){	
		$data['roomno']=$this->post('roomno');
		$data['roomtype']=$this->post('roomtype');
		$data['hostelid']=$this->post('hostelid');
		$data['totbeds']=$this->post('totbeds');
		$data['rcid']=$this->post('rcid');
		$data['roomrent']=$this->post('roomrent');
		$data['floorno']=$this->post('floorno');

		

		$this->getData('editroomconfig',$data);	    	
	   
	}

	// Delete Room Config 
	public function deleteroomconfig_post(){	
	
		$data['rcid']=$this->post('rcid');
		

		$this->getData('deleteroomconfig',$data);	    	
	   
	}

	// venkat sai

	// Add registration post
	public function addregistration_post(){	
		$data['reg_no']=$this->post('reg_no');
		$data['roomtype']=$this->post('roomtype');
		$data['typepriority']=$this->post('typepriority');
		$data['hostellocation']=$this->post('hostellocation');
		$data['locationpriority']=$this->post('locationpriority');
		$data['utype']=$this->post('utype');
		$data['registeredtype']=$this->post('registeredtype');
		
		
	    $this->getData('addregistration',$data);	    	
	}


	// Add Complaints post
	public function addcomplaints_post(){
		// $data['typeid']=$this->post('typeid');
		$data['complaint_type']=$this->post('complaint_type');
		$data['reg_no']=$this->post('reg_no');
		$data['complaint_priority']=$this->post('complaint_priority');
		$data['complaint_category_type']=$this->post('complaint_category_type');
		$data['feedback']=$this->post('feedback');		
	    $this->getData('addcomplaints',$data);	    	
	    $this->response(true);
	}

	// Add Notifications post
	public function addnotification_post(){
		$data['notificationdate']=$this->post('notificationdate');
		$data['noticedescription']=$this->post('noticedescription');
	    $this->getData('addnotification',$data);	    	
	    //$this->response(true);
	}
	// get Notifications
	public function getNotifications_get(){
		$data=[];
		$this->getData('getNotifications',$data);
	}

	// Add Instractions post
	public function addInstractions_post(){
		$data['instructiondate']=$this->post('instructiondate');
		$data['instructiondescription']=$this->post('instructiondescription');
	    $this->getData('addInstractions',$data);	    	
	    //$this->response(true);
	}

	// get Notifications
	public function getInstructions_get(){
		$data=[];
		$this->getData('getInstructions',$data);
	}

	// Add Events post
	public function addEvents_post(){
		$data['eventtype']=$this->post('eventtype');
		$data['eventdate']=$this->post('eventdate');
		$data['eventdescription']=$this->post('eventdescription');
		$data['eventtime']=$this->post('eventtime');
	    $this->getData('addEvents',$data);	    	
	    //$this->response(true);
	}

	// get Events
	public function getEvents_get(){
		$data=[];
		$this->getData('getEvents',$data);
	}


	// complaints list get view
	public function getcomplaints_post(){		    
	   
	    $data['type']=$this->post('type');
	    $this->getData('getcomplaints',$data);	
	     
	}

	// add Bill type
	public function addbilltype_post(){		    
		 $data['billtype']=$this->post('billtype');
		 $this->getData('addbilltype',$data);	
		  
	 }

	 // get Bill types 
	public function getbilltypes_get(){		    
		$this->getData('getbilltypes',[]);	
		 
	}

	// get Bill types 
	public function deletebilltype_post(){
        $data['bid']=$this->post('bid');
		$this->getData('deletebilltype',$data);	
		 
	}

	// Add Payment Data 
	public function addpaymentdata_post(){
		$data['paymentdate']=$this->post('paymentdate')['formatted'] .' '. date('H:i:s');
		$data['reg_no']=$this->post('reg_no');
		$data['receipt_no']=$this->post('receipt_no');
		$data['ctype']=$this->post('ctype');
		$data['billtype']=$this->post('billtype');
		$data['description']=$this->post('description');
		$data['cost']=$this->post('cost');
		$this->getData('addpaymentdata',$data);	
		 
	}

	// get Bill types 
	public function getmaintenancedata_post(){
		$data['btype']=$this->post('billtype');
		$data['ctype']=$this->post('ctype');
		$this->getData('getmaintenancedata',$data);	
		 
	}

	// get Student data except Regiter Users 
	public function getstudataexreg_get(){
		$this->getData('getstudataexreg',[]);	
		 
	}

	// get Student data By ID 
	public function getstudatabyid_post(){
		$data['reg_no']=$this->post('reg_no');
		$this->getData('getstudatabyid',$data);	
		 
	}

	// get Hostel Configuration data 
	public function gethostelconfig_get(){

		$this->getData('gethostelconfig',[]);	
		 
	}

	// add Hostel Configuration data 
	public function addhostelconfig_post(){
		
			  $data['hostelname']=$this->post('hostelname');
			  $data['hosteltype']=$this->post('hosteltype');
			  $data['floors']=$this->post('floors');
			  $data['hlocation']=$this->post('hlocation');
				$this->getData('addhostelconfig',$data);	
				 
			}

			// get Hostel Configuration data 
	public function edithostelconfig_post(){
		$data['hostelname']=$this->post('hostelname');
		$data['hosteltype']=$this->post('hosteltype');
		$data['floors']=$this->post('floors');
		$data['hlocation']=$this->post('hlocation');
		$data['hid']=$this->post('hid');
				$this->getData('edithostelconfig',$data);	
				 
			}

				// delete Hostel Configuration data 
	public function deletehostelconfig_post(){
		$data['hid']=$this->post('hid');
				$this->getData('deletehostelconfig',$data);	
				 
			}

			
				// Change status in roomtype according to hostels 
	public function changestatustype_post(){
		$data['hid']=$this->post('hid');
		$data['typeid']=$this->post('typeid');
		$data['type']=$this->post('type');
				$this->getData('changestatustype',$data);	
				 
			}

						// get users data for regitration
	public function getusersdataR_post(){
		$data['utype']=$this->post('utype');
				$this->getData('getusersdataR',$data);	
				 
			}

							// get rooms data by hid
	public function getroomslistbyhid_post(){
		$data['hid']=$this->post('hid');
				$this->getData('getroomslistbyhid',$data);	
				 
			}

						// get occupy data 
	public function getoccupydata_post(){
		$data['hid']=$this->post('hid');
		$data['roomtype']=$this->post('roomtype');
		$data['roomno']=$this->post('roomno');
				$this->getData('getoccupydata',$data);	
				 
			}

						// empty the room 
	public function emptytheroom_post(){
		$data['room']=$this->post('room');
		$data['hostel']=$this->post('hostel');
		$data['hosteltype']=$this->post('hosteltype');
		$data['empty']=$this->post('empty');
				$this->getData('emptytheroom',$data);	
				 
			}

							// get Register users List
	public function getregisusers_get(){
				$this->getData('getregisusers',[]);	
				 
			}

				// delete Register user
				public function delregisuser_post(){
                   $data['rid']=$this->post('rid');
				  $this->getData('delregisuser',$data);	

				}

	// delete Register users 
	public function delallregisusers_post(){
		$data['type']=$this->post('type');
		$this->getData('delallregisusers',$data);	
			
	}


                        //  get register form show Status
		public function getregstatus_post(){
			$data['gender']=$this->post('gender');
			$data['utype']=$this->post('utype');
			$data['reg_no']=$this->post('reg_no');
			$this->getData('getregstatus',$data);	
				
		}

		
                   //  get hostels data for outings
				   public function getRoomDetails_get(){
					$this->getData('getRoomDetails',[]);	
						
				}


	   // MESS
	   
	   

    //Mess Incharge
    public function insertlist_post(){
    	$response1=[];
    	$des_price=[];
    	$time1=  $this->post('insert_date1');
		$start1 = date('h:i:s');
		$discont = $this->post('discount');
		$totalsum=0;
		if($discont !=''){
			foreach( $this->post('activeList') as $input ){
			 $totalsum +=$input['price'];	 
		}
		if($discont>=$totalsum){
			$des_price['discount']=$discont;
			$des_price['totalprice']=$totalsum;
			$response1['data'] =  array("success" => false, "data" => $des_price);
			return  $this->response($response1);
		}else{
    	$data=array(
    		'purchaser' => $this->post('purchaser'),
    		'type' => $this->post('type'),
    		'insert_date' =>  $time1.' '.$start1,
    		'active_list' => $this->post('activeList'),
    		'reg_no' => $this->post('reg_no'),
    		'discount' => $this->post('discount'),
    		'receipt_no' => $this->post('receipt_no') 
           );

	    $this->getData('insertlist',$data);	    	
	    $this->response(true);
	   }

		}else{
			$data=array(
    		'purchaser' => $this->post('purchaser'),
    		'type' => $this->post('type'),
    		'insert_date' =>  $time1.' '.$start1,
    		'active_list' => $this->post('activeList'),
    		'reg_no' => $this->post('reg_no'),
    		'discount' => $this->post('discount'),
    		'receipt_no' => $this->post('receipt_no') 
           );

	    $this->getData('insertlist',$data);	    	
	    $this->response(true);
		}
	}

	public function itemoutlist_post()
	{
		$time=  $this->post('out_date1');
		$start = date('h:i:s');
		$data=array(
			'slot' => $this->post('slot'),
			'from_to' => $this->post('towhom'),
            'type' => $this->post('type'),
			'active_list1' => $this->post('activeList1'),
			'out_date' => $time.' '.$start,
			'reg_no' => $this->post('reg_no')
			);
		 // print_r(  $data['active_list1']);
		  $this->getData('itemoutlist',$data);	    	
	    $this->response(true);
	}
	public function getlist_get(){		    
	    
	    $data=[];
	    $this->getData('getlist');	
	    	
	}
	public function addnewitem_post()
	{
		$data=array(
			'item' => $this->post('item1'),
			'item_type' => $this->post('item_type'),
			'units' => $this->post('units1'),
			'minvalue' => $this->post('minvalue')
			);
		// $data['item']=$this->post('item');
		$this->getData('addnewitem',$data);
	}
	public function menulist_post()
	{
		$data=array(
			'mday' => $this->post('day'),
            'breakfast' => $this->post('breakfast'),
			'lunch' => $this->post('lunch'),
			'snacks' => $this->post('snacks'),
			'dinner' => $this->post('dinner')
			);
		  $this->getData('menulist',$data);	    	
	    $this->response(true);
	}
	public function getmenulist_get(){		    
	    
	    $data=[];
	    $this->getData('getmenulist');	
	    	
	}
	public function updatelist_post()
	{
		$data=array(
			'id' => $this->post('id'),
            'breakfast' => $this->post('breakfast'),
			'lunch' => $this->post('lunch'),
			'snacks' => $this->post('snacks'),
			'dinner' => $this->post('dinner')
			);
		  $this->getData('updatelist',$data);	    	
	    $this->response(true);
	}
	public function stockRegister_get(){
		$this->getData('stockRegister');
	}

	public function stockBalance_get(){
		$this->getData('stockBalance');
	}
	public function getunits_post()
	{
		$data=array(
			'mid' => $this->post('units')
			);
		// $data['item']=$this->post('item');
		$this->getData('getunits',$data);
	}

	// public function purchaserlist_post()
 //    {
       
 //        $data=array(
 //            //'mid' => $this->post('mid'),
 //            'list' => $this->post('activeList')
 //            );
         
 //        $this->getData('purchaserlist',$data);
 //    }
	public function purchaserlist_post()
    {

        $data=array(
            'purchaser' => $this->post('purchaser'),
            'list' => $this->post('activeList')
            );

        $this->getData('purchaserlist',$data);
    }


    public function purchaseItemsList_get(){
		$this->getData('purchaseItemsList');
	}

	// public function updatematerialslist_post()
	// {
	// 	$data=array(
	// 		'mid' => $this->post('mid'),
	// 		'minvalue' => $this->post('minvalue'),
	// 		'item' => $this->post('item1'),
	// 		'units' => $this->post('units1')
	// 		);
	// 	// $data['item']=$this->post('item');
	// 	$this->getData('updatematerialslist',$data);
	// }

	public function updatematerialslist_post()
    {
        $data=array(
            'mid' => $this->post('mid'),
            'item_type' => $this->post('item_type'),
            'minvalue' => $this->post('minvalue'),
            'item' => $this->post('item1'),
            'units' => $this->post('units1')
            );
        // $data['item']=$this->post('item');
        $this->getData('updatematerialslist',$data);
    } 

	public function deleteitem_post()
	{
		$data=array(
			'mid' => $this->post('mid')
			);
		// $data['item']=$this->post('item');
		$this->getData('deleteitem',$data);
	}

	public function selected_PurchaseData_post(){
		 
		 // $time=  strtotime($this->post('status'));
   //      $start = date('Y-m-d H:i:s', $time);
		$data=array(
			'date' => $this->post('date') ,
			'status' =>$this->post('status')
			);
		// $data['item']=$this->post('item');
		$this->getData('selected_PurchaseData',$data);
	}

	public function itembuy_post()
	{
	 	$data=array(
		'list' => $this->post('list')
		);
		 
		$this->getData('itembuy',$data);
	}

	public function getCategories_get(){
		$this->getData('getCategories');
	}

	public function getItemsbyCategory_post(){
		$data=array(
			'item_type' => $this->post('category') 
			);
		$this->getData('getItemsbyCategory',$data);
	}

	public function getnames_get()
    {
      $this->getData('getnames');
    }
    public function purchaserdetails_post()
    {
        $data= array(
       'date' => $this->post('dat')
        );
        $this->getData('purchaserdetails',$data);
    }
    public function status_post()
    {
        $data= array(
       'date' => $this->post('dat')
        );
        $this->getData('status',$data);
    }

    ///controllers

public function purchasersname_post()
    {
        $data= array(
       'name' => $this->post('name'),
       'location' => $this->post('location'),
       'mobile_no' => $this->post('mobile_no')
        );
        $this->getData('purchasersname',$data);
    }
     public function purchaseupdate_post()
    {
        $data= array(
       'name' => $this->post('name'),
       'location' => $this->post('location'),
       'mobile_no' => $this->post('mobile_no'),
       'id' => $this->post('id'),
        );
        $this->getData('purchaseupdate',$data);
    }
    public function purchasersdelete_post()
    {
        $data=array(
            'id' => $this->post('id')
            );
        // $data['item']=$this->post('item');
        $this->getData('purchasersdelete',$data);
    }

    public function addcategory_post()
  {
    $data= array(
    'item_type' => $this->post('category')
    );
    $this->getData('addcategory',$data);
  }
 	
 	public function getCategoriesfornewItem_get()
    {
        $this->getData('getCategoriesfornewItem');
    }
	
	public function getlastInsertDate_get()
    {
        $this->getData('getlastInsertDate');
    }



     public function insert_docs_post( ){
  
      $data['bill_upload_date']=$this->post('date');
      $data['billno']=$this->post('receipt');
      for($i=0;$i<$this->post('length');$i++){
      $name= $_FILES["uploads"]["name"][$i] ;
        $data['bill_name'] = $name;
      $type= $_FILES["uploads"]["type"][$i] ;
      $data['bill_type'] = $type;
      $ftpe = pathinfo($_FILES["uploads"]["name"][$i] ,PATHINFO_EXTENSION);

      move_uploaded_file($_FILES["uploads"]["tmp_name"][$i] , "uploads/".$name);
       $this->db->insert('bills',$data);   
     }
  }

  public function getImagesbyId_post(){
  	$data['id']=$this->post('id');
  	$this->getData('getImagesbyId',$data);
  	//$data['billno']=$this->post('billno');
  }

  public function reportsdate_post()
    {
        $data = array(
            'from_date' => $this->post('from_date'),
            'end_date' => $this->post('end_date')
            );
        $this->getData('reportsdate',$data);
    }
    public function details_post()
    {
        $data = array(
            'date1' => $this->post('dat')
            );
        $this->getData('report_details',$data);
    }







	// Get Multiple query results function
	public function GetMultipleQueryResult($queryString)
    {
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