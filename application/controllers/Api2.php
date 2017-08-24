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
						case 'addroomconfig'	    : $result = $this->Api_model->addroomconfig($params); break;
						case 'getroomconfig'	    : $result = $this->Api_model->getroomconfig($params); break;
						case 'getroomslistavlb'	    : $result = $this->Api_model->getroomslistavlb($params); break;
						case 'getbedslistbyroomno'	    : $result = $this->Api_model->getbedslistbyroomno($params); break;
						case 'getdetailstoadd'	    : $result = $this->Api_model->getdetailstoadd($params); break;
						case 'getdetailsbyid'	    : $result = $this->Api_model->getdetailsbyid($params); break;
						case 'gettotalrooms'	    : $result = $this->Api_model->gettotalrooms($params); break;
						case 'getdetailsbyroom'	    : $result = $this->Api_model->getdetailsbyroom($params); break;
					
						// case 'getStaff'				: $result = $this->api_model->getStaff($token->reg_no, $params); break;
						// case 'Upload'				: $result = $this->Api_model->Upload($token->reg_no,$params); break;
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
		$data['description']=$this->post('description');
	    $this->getData('addbooking',$data);	    	
	   
	}
		// Edit Booking post
	public function editbooking_post(){
		$data['startdate']=$this->post('startdate')['formatted'];
		$data['enddate']=$this->post('enddate')['formatted'];
		$data['semstartdate']=$this->post('semstartdate')['formatted'];
		$data['semenddate']=$this->post('semenddate')['formatted'];
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
		$data['totalcount']=$this->post('totalcount');
		$data['cost']=$this->post('cost');
		$data['totaldues']=$this->post('totaldues');
		 $data['amt_perdue']=$data['cost']/$data['totaldues'];		
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
	    $this->getData('getreglist',$data);	
	     
	}

	// bookings list get view
	public function getbookingslist_get(){		    
	   
	    $data=[];
	    $this->getData('getbookingslist',$data);	
	     
	}

	// rooms list get view
	public function getroomconfig_post(){		    
	   
	    $data['rtype']=$this->post('rtype');
		$data['htype']=$this->post('htype');
	    $this->getData('getroomconfig',$data);	
	     
	}
	
	// vacant room post 
		public function vacantroom_post(){		    
    $data['registrationid']=$this->post('registrationid');
	$data['type']=$this->post('type');
	    $this->getData('vacantroom',$data);	
	     
	}

		// Add room config post
	public function addroomconfig_post(){	
		$data['roomtype']=$this->post('roomtype');
		$data['totbeds']=$this->post('totbeds');
		$data['avlbeds']=$this->post('totbeds');
		$data['roomno']=$this->post('roomno');
		$data['hosteltype']=$this->post('hosteltype');
		$data['hostelid']=$this->post('hostelid');
		$data['blockid']=$this->post('blockid');		
	    $this->getData('addroomconfig',$data);	    	
	 
	}

		// get rooms available  list post
	public function getroomslistavlb_post(){	
		$data['hosteltype']=$this->post('hosteltype');	
	    $this->getData('getroomslistavlb',$data);	    	
	 
	}

			// get rooms available  list post
	public function gettotalrooms_post(){	
		$data['hosteltype']=$this->post('hosteltype');	
	    $this->getData('gettotalrooms',$data);	    	
	 
	}


	// get beds list by roomno post
	public function getbedslistbyroomno_post(){	
		$data['hosteltype']=$this->post('hosteltype');
		$data['roomno']=$this->post('roomno');	
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
		$data['hosteltype']=$this->post('hosteltype');
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