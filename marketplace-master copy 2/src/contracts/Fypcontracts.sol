pragma solidity >=0.4.21 <0.7.0;
contract User{
 address public NotificationContract;
  address public HistoryContract;
    ////history struct

   
     constructor (address notfication,address History ) public payable {
     NotificationContract= notfication;
     HistoryContract=History;    
     }
   
    struct user{
        string name;
        string privatekey;
        uint256 balance;
        mapping(uint256 => commodity) ownedCommodity;
        mapping(uint256 => commodity) pendingSaleCommodity;
        mapping(uint256 => commodity) pendingExchangeCommodity;
        mapping(uint256 => commodity) pendingBuyCommodity;
       
       // mapping(uint256 => notification) Notification;
       
       ///////history lists
      //  mapping(uint256 => history) SaleHistory;
    //    mapping(uint256 => history) BuyHistory;
     //   mapping(uint256 => history) ExchangeHistory;
        ///////history list end
       
        uint256 OwnedCount;
        uint256 pendingSaleCount;
        uint256 pendingExchangeCount;
        uint256 pendingBuyCount;
        //uint256 notificationCount;
       
        ////history count
        //uint256 HistorySaleCount;
       // uint256 HistoryExchangeCount;
    //    uint256 HistoryBuyCount;
        ////history count end
       
    }
   
    struct commodity {
        uint id;
        string name;
        uint price;
        address owner;
        uint quantity;
        string namewith;
    }
   
    //count no of users
    uint public UserCount;
    mapping(address => user) public users;
   
   
   
 //create or modify a user data
  function AddUser(string memory _name,address _address,string memory _privatekey) public {
  //check if the user data exists in  table
  //if not exist, create a new user in the table
   Notification ContractNotification =Notification(address(NotificationContract));
   History ContractHistory=History(address(HistoryContract));
   
      if(bytes(users[_address].name).length==0){
         
         users[_address] = user(_name,_privatekey,100,1,1,1,0);
         UserCount++;
         ContractNotification. addusernotification(_address);
         ContractHistory.adduserhistory(_address);
      }
   
 }
   
  function AddBalance(address a,uint256 _b) public {
         users[a].balance += _b;
  }
  function DecBalance(address a,uint256 _b) public{
         users[a].balance -= _b;
  }
  //user balance
  function getBalance(address a) public view returns (uint256) {
        return users[a].balance;
    }
  ////owned commodities    
  function getcommodityquantity(address p,string memory _name) public view returns (uint256)
  {
   
        uint qty=0;
           for (uint i = 1; i <= users[p].OwnedCount ; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
                if(keccak256(abi.encodePacked(users[p]. ownedCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    qty=users[p]. ownedCommodity[i].quantity;
               
                }
            }
            return qty;
    }
  //owned commodities    
  function addcommodity(address p,string memory _name, uint _quantity) public
  {
        uint t=0;
           for (uint i = 0; i <= users[p].OwnedCount && t==0 ; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
                if(keccak256(abi.encodePacked(users[p]. ownedCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    users[p].ownedCommodity[i].quantity +=_quantity;
                    t=1;
                }
            }
            if(t==0){
                users[p]. ownedCommodity[users[p].OwnedCount]=commodity(users[p].OwnedCount, _name,0,p,_quantity,"null");
                //users[p].ownedCommodity[users[p].OwnedCount].quantity +=_quantity;
                users[p].OwnedCount++;
            }
    }
  function deccommodity(address p,string memory _name, uint _quantity) public
  {
        uint t=0;
           for (uint i = 0; i <= users[p].OwnedCount && t==0 ; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
                if(keccak256(abi.encodePacked(users[p]. ownedCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    users[p]. ownedCommodity[i].quantity -=_quantity;
                    t=1;
                }
            }
           
    }
   
  //add to pending list
  function addtoSalePendinglist(address p,string memory _name, uint _price, uint _quantity) public
  {
        uint t=0;
           for (uint i = 1; i <= users[p].pendingSaleCount && t==0 ; i++)// to check new commodity is ==gold silver or copper
           {
            //compare commodity name
                if(keccak256(abi.encodePacked(users[p]. pendingSaleCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    users[p]. pendingSaleCommodity[i].quantity +=_quantity;
                    t=1;
                }
            }
            if(t==0){
                users[p]. pendingSaleCommodity[users[p].pendingSaleCount]=commodity(users[p].pendingSaleCount, _name,_price,p,_quantity,"null");
                users[p].pendingSaleCount++;
            }
         
           
    }
  function addtoExchangePendinglist(address p,string memory _name, uint _price, uint _quantity) public
  {
        uint t=0;
           for (uint i = 1; i <= users[p].pendingExchangeCount && t==0 ; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
                if(keccak256(abi.encodePacked(users[p]. pendingExchangeCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    users[p]. pendingExchangeCommodity[i].quantity +=_quantity;
                    t=1;
                }
            }
            if(t==0){
                users[p]. pendingExchangeCommodity[users[p].pendingExchangeCount]=commodity(users[p].pendingExchangeCount, _name,_price,p,_quantity,"null");
                users[p].pendingExchangeCount++;
            }
         
           
    }
   
   
  function dectoSalePendinglist(address p,string memory _name, uint _quantity) public
  {
        uint t=0;
           for (uint i = 1; i <= users[p].pendingSaleCount && t==0 ; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
                if(keccak256(abi.encodePacked(users[p].pendingSaleCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    users[p].pendingSaleCommodity[i].quantity -=_quantity;
                    t=1;
                }
            }
           
    }
  function dectoExchangePendinglist(address p,string memory _name, uint _quantity) public
  {
        uint t=0;
           for (uint i = 1; i <= users[p].pendingExchangeCount && t==0 ; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
                if(keccak256(abi.encodePacked(users[p].pendingExchangeCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    users[p].pendingExchangeCommodity[i].quantity -=_quantity;
                    t=1;
                }
           }
    }
   
    //types of commodity   pending
    function getPendingSaleCommodityCount(address _adress) public view returns (uint256) {
         return users[_adress].pendingSaleCount;
    }
    function nameofSalePendingcommodity(address  p ,uint _index)public view returns (string memory name)
    {
        return users[p].pendingSaleCommodity[_index].name;
    }
     function getPendignSaleCommodityNameCount(address  p , string memory _name) public view returns (uint256) {
          uint256 count;
           for (uint i = 1; i <= users[p].pendingSaleCount; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
                if(keccak256(abi.encodePacked(users[p].pendingSaleCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    count =users[p].pendingSaleCommodity[i].quantity;
                   
                }
            }
            return count;
    }
    function getPendingExchangeCommodityCount(address _adress) public view returns (uint256) {
         return users[_adress].pendingExchangeCount;
    }
   
    function nameofExchangePendingcommodity(address  p ,uint _index)public view returns (string memory name)
    {
        return users[p].pendingExchangeCommodity[_index].name;
    }
     function getPendignExchangeCommodityNameCount(address  p , string memory _name) public view returns (uint256) {
          uint256 count;
           for (uint i = 1; i <= users[p].pendingExchangeCount; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
                if(keccak256(abi.encodePacked(users[p].pendingExchangeCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    count =users[p].pendingExchangeCommodity[i].quantity;
                   
                }
            }
            return count;
    }
   
   
    //owned
    function getTypeCommoditycount(address _adress) public view returns (uint256) {
         return users[_adress].OwnedCount;
    }
   // quantity of each commodity repeat
     function getUserCommoditycount(address  p , string memory _name) public view returns (uint256) {
          uint256 count;
           for (uint i = 1; i <= users[p].OwnedCount; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
                if(keccak256(abi.encodePacked(users[p].ownedCommodity[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    count =users[p].ownedCommodity[i].quantity;
                   
                }
            }
            return count;
    }
    //ownedCommodity name
    function nameofcommodity(address  p ,uint _index)public view returns (string memory name)
    {
        return users[p]. ownedCommodity[_index].name;
    }
   

}
contract Commodity {
    struct commodity {
        uint id;
        string name;
        uint price;
        address owner;
        uint quantity;
        string exchangewith;
    }

    mapping(uint => commodity) public forSalecommodities;
    mapping(uint => commodity) public forExchangecommodities;
   
    uint public commoditiesforSaleCount;
    uint public commoditiesforExchangeCount;
   
   
    address admin;
    address public UserContract;
   
    constructor (address _userContract) public {
         admin=msg.sender;
         UserContract = _userContract;
       
    }
   
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }

      function getSalecommoditytotalcount(string memory _name ) public view returns (uint256) {
     
      uint256 q=0;
           for (uint i = 0; i <= commoditiesforSaleCount ; i++)// to check new commodity is ==gold silver or copper
           {
            //commare commodity name
           
                if(keccak256(abi.encodePacked(forSalecommodities[i].name)) == keccak256(abi.encodePacked(_name)))
                {
                    q +=forSalecommodities[i].quantity;
                   
                }
               
            }
            return q;
   
      }

    function addforSaleCommodities ( string memory _name ,uint _quantity,address _a) public {
       
          uint t=0;
           for (uint i = 0; i <= commoditiesforSaleCount && t==0 ; i++)// to check new commodity is ==gold silver or copper
           {
            if(keccak256(abi.encodePacked(forSalecommodities[i].owner))==keccak256(abi.encodePacked(_a)))
            //commare commodity name
           
                if(keccak256(abi.encodePacked(forSalecommodities[i].name))==keccak256(abi.encodePacked(_name)))
                {
                    forSalecommodities[i].quantity +=_quantity;
                    t=1;
                }
            }
            if(t==0){
                    commoditiesforSaleCount++;

               forSalecommodities[commoditiesforSaleCount] = commodity(commoditiesforSaleCount, _name,0,_a,_quantity,"null");
            }
   
    }
   
    function decSaleCommodity(uint i,uint _quantity) public{
    forSalecommodities[i].quantity -=_quantity;
    }
   
      function decExchangeCommodity(uint i,uint _quantity) public{
    forExchangecommodities[i].quantity -=_quantity;
    }
   
    function addforExchangeCommodities ( string memory _name ,uint _quantity,address _a,string memory  _with) public {
        commoditiesforExchangeCount++;
        forExchangecommodities[commoditiesforExchangeCount] = commodity(commoditiesforExchangeCount, _name,0,_a,_quantity,_with);
    }
   
   function addUser ( string memory _name,address _adress,string memory _privatekey) public onlyAdmin {
             User ContractUser = User(address(UserContract));
             ContractUser.AddUser(_name,_adress,_privatekey);
    }
    function getSaleCommodityCount() public view returns (uint256) {
    return commoditiesforSaleCount;
    }
    function getExchangeCommodityCount() public view returns (uint256) {
    return commoditiesforExchangeCount;
    }
    function getSaleCommodityName(uint256 index) public view  returns (string memory) {
    return forSalecommodities[index].name;
    }
    function getExchangeCommodityName(uint256 index) public view  returns (string memory) {
    return forExchangecommodities[index].name;
    }
    //each commodity quantity
    function getSaleCommodityQuantity(uint256 index) public view returns (uint256) {
    return forSalecommodities[index].quantity;
    }
    function getExchangeCommodityQuantity(uint256 index) public view returns (uint256) {
    return forExchangecommodities[index].quantity;
    }
   
    function getSaleCommodityOwner(uint256 index) public view returns (address) {
    return forSalecommodities[index].owner;
    }
    function getExchangeCommodityOwner(uint256 index) public view returns (address) {
    return forExchangecommodities[index].owner;
    }
   
}


contract SellContract
{
   
    address public Usercontract; // smart contract address of Usercontract
    address public commodityContract;
   
    constructor (address _userContract,address _commodityContract) public payable {
        Usercontract = _userContract;
        commodityContract= _commodityContract;
    }
   
    function sellCommodities  (string memory _name,uint _quantity) public payable {
        User ContractUser = User(address(Usercontract));
        Commodity ContractCommodity =  Commodity(address(commodityContract));
       
        //check quantity
         uint q=ContractUser.getcommodityquantity(msg.sender, _name);
        if(q >= _quantity)
        {                 //add to for sale list
                          ContractCommodity.addforSaleCommodities (_name ,_quantity,msg.sender);
                          //add to user pending list
                          ContractUser.addtoSalePendinglist(msg.sender,_name,0, _quantity);
                           
        }
       
       
  }  
}

contract ExchangeContract
{
    address public Usercontract; // smart contract address of Usercontract
    address public commodityContract;
    address public NotificationContract;
    address public HistoryContract;
    User public ContractUser;
 Commodity public ContractCommodity;
    Notification public ContractNotification;
 History public ContractHistory;
    address public a;
    uint256 returnvalue;
    uint256 public withquantityreturn;
    function getReturnValue() public view returns(uint256)
    {
        return returnvalue;
    }

    constructor (address _userContract,address _commodityContract,address notfication,address _History) public  {
        Usercontract = _userContract;
        commodityContract= _commodityContract;
          NotificationContract= notfication;
     HistoryContract=_History;    
         ContractUser = User(address(Usercontract));
        ContractCommodity =  Commodity(address(commodityContract));
           ContractHistory=History(address(HistoryContract));
              ContractNotification =Notification(address(NotificationContract));
                                 
   
     
   
    }
   
    //check exist exchange yes no
    //pendling yes no
    //nofication array
   
    function exchangeCommodities  (string memory _name,uint  _quantity,uint _price,uint _withprice,string memory _namewith,string memory _date) public returns (uint256)  {
     
        if(ContractUser.getcommodityquantity(msg.sender, _name) >= _quantity)
        {
           
              //check if namewith is in the list of exchangeforcommodities ///in my case sale for commodities
                uint yes=0;
                for(uint i=1;i <= ContractCommodity.getExchangeCommodityCount() && yes==0;i++)
                {
                      if(keccak256(abi.encodePacked(ContractCommodity.getExchangeCommodityName(i)))==keccak256(abi.encodePacked(_namewith)))
                      {
                          if(ContractCommodity.getExchangeCommodityOwner(i)!=msg.sender)
                          {
                                  uint p=_withprice;
                        uint  withquantity=1;
                         
                            for(;p<=(_price*_quantity);)
                                {
                               p=p+_withprice;
                               if(p<=(_price*_quantity))
                               withquantity=withquantity+1;//quantity od c2
                                }
                                if(ContractCommodity.getExchangeCommodityQuantity(i)>=withquantity)
                                {  
                                     yes=1;
                                    withquantityreturn=withquantity;
                                   returnvalue= i;
                                }
               
                          }
                      }
               
                     
             
                }
               
                if(yes == 0)//no match add in exchange with list
                {
                            ContractCommodity.addforExchangeCommodities (_name ,_quantity,msg.sender,_namewith);
                           
                            //add to pending exchanfe list
                            ContractUser.addtoExchangePendinglist(msg.sender, _name, _price, _quantity);
                           returnvalue= 0;
                           
                }
               
        }

   }
   function remaningExchange (string memory _name,uint  _quantity,uint _price,uint withprice,string memory _namewith,string memory _date,uint256 index ) public returns(uint256)
   {
                     
                       
                       index=returnvalue;
                       if(returnvalue!=0)
                       {
     
        address owner= ContractCommodity.getExchangeCommodityOwner(index);
         ContractUser.addcommodity(msg.sender,_namewith, withquantityreturn);
                                  ContractUser.deccommodity(owner,_namewith,withquantityreturn);
                                   
                                   ContractUser.addcommodity(owner ,_name,  _quantity);
                                   ContractUser.deccommodity( msg.sender,_name, _quantity);
                                   //history
                                    return withquantityreturn;
                             
                       }
   }    
function exchangeHistory(string memory _name,uint  _quantity,uint _price,uint withprice,string memory _namewith,string memory _date ) public{
        if(returnvalue!=0)
                       {  
       uint256 index=returnvalue;
        address owner= ContractCommodity.getExchangeCommodityOwner(index);
          ContractHistory.addtoExchangeHistorylist(_price,_date, owner, msg.sender, _name,_namewith, _quantity);
         
                       }
                                   //pending list
                               
   
}  
function exchangeNotificationPending(string memory _name,uint  _quantity,uint _price,uint withprice,string memory _namewith,string memory _date) public{
       
        if(returnvalue!=0)
                       {      uint256 index=returnvalue;
       uint256 withquantity=withquantityreturn;
       address owner= ContractCommodity.getExchangeCommodityOwner(index);
                                   //pending list
                                    ContractUser.dectoExchangePendinglist(owner,_namewith, withquantity);
                                   
                                   //notification
                          ContractCommodity.decExchangeCommodity(index,withquantityreturn);
                            ContractNotification. SendExchangeNotification(owner,msg.sender, _quantity,_name, _price, _namewith,_date );
   
}
}
}

contract BuyContract
{
    address public Usercontract; // smart contract address of Usercontract
    address public commodityContract;
    address public NotificationContract;
    address public HistoryContract;
    User public ContractUser;
    uint256 _price;
    address payable to;
 Commodity public ContractCommodity;
    Notification public ContractNotification;
 History public ContractHistory;
 string returnaddress;
    address public a;
    uint256 returnvalue;
    uint256 public withquantityreturn;
    function getReturnValue() public view returns(uint256)
    {
        return returnvalue;
    }
     function getReturnAddress() public view returns(string memory)
    {
        return returnaddress;
    }
   
   
function toAsciiString() public returns (string memory) {
    address x=a;
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
        byte b = byte(uint8(uint(x) / (2**(8*(19 - i)))));
        byte hi = byte(uint8(b) / 16);
        byte lo = byte(uint8(b) - 16 * uint8(hi));
        s[2*i] = char(hi);
        s[2*i+1] = char(lo);            
    }
   returnaddress =string(s);
    return string(s);
}

function char(byte b)public returns (byte c) {
    if (uint8(b )< 10) return byte(uint8(b) + 0x30);
    else return byte(uint8(b) + 0x57);
}

    constructor (address _userContract,address _commodityContract,address notfication,address _History) public  {
        Usercontract = _userContract;
        commodityContract= _commodityContract;
          NotificationContract= notfication;
     HistoryContract=_History;    
         ContractUser = User(address(Usercontract));
        ContractCommodity =  Commodity(address(commodityContract));
           ContractHistory=History(address(HistoryContract));
              ContractNotification =Notification(address(NotificationContract));
                                 

     
   
    }
 
   
    //check exist exchange yes no
    //pendling yes no
    //nofication array
   
    function BuyCommodities  (string memory _name,string memory _date,uint _quantity,uint price) public payable   {
              uint256 balance = ContractUser.getBalance(msg.sender);
             
                if((balance)>=price*_quantity)
                {
                    for (uint i = 1; i <= ContractCommodity.getSaleCommodityCount() ; i++)
                    {
                          if(keccak256(abi.encodePacked(ContractCommodity.getSaleCommodityName(i)))==keccak256(abi.encodePacked(_name)))
                            {
                                  if(ContractCommodity.getSaleCommodityQuantity(i) >= _quantity&&ContractCommodity.getSaleCommodityOwner(i)!=msg.sender)
                                 
                                    {
                                        returnvalue=price*_quantity;
                                       
                                     //   to=payable(ContractCommodity.getSaleCommodityOwner(i));
                                        a=ContractCommodity.getSaleCommodityOwner(i);
                                        _price=price;
                                       toAsciiString();
                                       // to.transfer((price)); //transfer to the owner
                                        //add dec balance
                            ContractUser.AddBalance(to,price*_quantity);
                            ContractUser.DecBalance(msg.sender,price*_quantity);//buyer
                           
                            //add commodity to user owned commodity list
                            ContractUser.addcommodity(msg.sender,_name,_quantity);
                            ContractUser.deccommodity(to,_name,_quantity);
                           
                       
                            //pending list remove
                         
                           
                            //add to sale history of seller
                           ContractHistory.addtoSaleHistorylist(price,_date, to, msg.sender,_name, _quantity);
                           
                           // add to buy history of buyer
                             ContractHistory.addtoBuyHistorylist(price,_date, to, msg.sender,_name, _quantity);
                               ContractCommodity.decSaleCommodity(i,_quantity);
                               ContractUser.dectoSalePendinglist(to,_name, _quantity);
                            ContractNotification.SendBuyNotification(to,msg.sender, _quantity,_name,price, _name,_date) ;
     
                                         
                                       
                                    }            
             
                            }
             
                    }
                }
     
}}


contract Notification{
    struct notification
    {

        bool ConfirmFromSeller ;
        string reqtype;
        uint price;  // ??? current value
        string date; // ??
        address seller;
        address buyer;
        string fromcommodityname;
        string tocommodityname;
        string state; /// ??
        uint quantity;
        uint no_id;
       
    }
    struct notification_array
    {
         mapping(uint256 => notification) Notification;
         uint256 notificationCount;
       
       
    }
   
      address public Usercontract; // smart contract address of Usercontract
      mapping(address => notification_array) users;
      uint256 usercount;
 
    constructor () public  {
     
    }
   
    function addusernotification(address _toAdress) public
    {
        users[_toAdress]= notification_array(0);
        usercount++;
    }
 function SendExchangeNotification(address _toAddress,address _fromAdress,uint256 _quantity,string memory fromcomtype,uint256 price, string memory withcomtype,string memory _date) public {
        address i=_toAddress;
        users[i].Notification[users[i].notificationCount]=notification(false,"exchange",price,_date,_toAddress,_fromAdress,fromcomtype,withcomtype,"false",_quantity,users[i].notificationCount);
        users[i].notificationCount++;
        i=_fromAdress;
        users[i].Notification[users[i].notificationCount]=notification(false,"exchange",price,_date,_toAddress,_fromAdress,fromcomtype,withcomtype,"false",_quantity,users[i].notificationCount);
        users[i].notificationCount++;
   
 }
  function SendBuyNotification(address _toAdress,address _fromAdress,uint256 _quantity,string memory fromcomtype,uint256 price, string memory withcomtype,string memory _date) public {
        address i=_toAdress;
        users[i].Notification[users[i].notificationCount]=notification(false,"seller",price,_date,_toAdress,_fromAdress,fromcomtype,withcomtype,"false",_quantity,users[i].notificationCount);
        users[i].notificationCount++;
         i=_fromAdress;
        users[i].Notification[users[i].notificationCount]=notification(false,"buyer",price,_date,_toAdress,_fromAdress,fromcomtype,withcomtype,"false",_quantity,users[i].notificationCount);
        users[i].notificationCount++;
   
 }
 function getNotificationCount(address i)public view returns (uint256) {
      return users[i].notificationCount;
     
  }
 function getNotificationReqType(address i,uint256 index)public view returns (string memory) {
      return users[i].Notification[index].reqtype;
     
  }
 function getNotificationPrice(address i,uint256 index)public view returns (uint256) {
      return users[i].Notification[index].price;
     
  }
 function getNotificationDate(address i,uint256 index)public view returns (string memory) {
      return users[i].Notification[index].date;
     
  }
 function getNotificationSeller(address i,uint256 index)public view returns (address) {
      return users[i].Notification[index].seller;
     
  }
 function getNotificationBuyer(address i,uint256 index)public view returns (address) {
      return users[i].Notification[index].buyer;
     
  }
 function getNotificationFromCommodityName(address i,uint256 index)public view returns (string memory) {
      return users[i].Notification[index].fromcommodityname;
     
  }
 function getNotificationToCommodityName(address i,uint256 index)public view returns (string memory) {
      return users[i].Notification[index].tocommodityname;
     
  }
 function getNotificationState(address i,uint256 index)public view returns (string memory) {
      return users[i].Notification[index].state;
     
  }
 function getNotificationQuantity(address i,uint256 index)public view returns (uint256){
      return users[i].Notification[index].quantity;
     
  }
 function getNotificationId(address i,uint256 index)public view returns (uint256){
      return users[i].Notification[index].no_id;
     
  }
 function SendConfirmationNotification(address _toAdress,address _fromAdress,uint256 _quantity,string memory fromcomtype,uint256 price ,string memory withcomtype,string memory _date) public {
    address i=_toAdress;
    users[i].Notification[users[i].notificationCount]=notification(false,"Accepted",price,_date,_toAdress,_fromAdress,fromcomtype,withcomtype,"false",_quantity,users[i].notificationCount);
    users[i].notificationCount++;

 }
   function SendRejectionNotification(address _toAdress,address _fromAdress,uint256 _quantity,string memory fromcomtype,uint256 price ,string memory withcomtype,string memory _date) public {
     address i=_toAdress;
     users[i].Notification[users[i].notificationCount]=notification(false,"Rejected",price,_date,_toAdress,_fromAdress,fromcomtype,withcomtype,"false",_quantity,users[i].notificationCount);
     users[i].notificationCount++;
   
 }
 //alert
  function deleteNotification(address i,uint id,string memory ans) public {
         users[i].Notification[id].state="true";
///     if(keccak256(abi.encodePacked("accept"))==keccak256(abi.encodePacked(ans)))
    {
    //   SendConfirmationNotification(users[i].Notification[id].buyer,users[i].Notification[id].seller,users[i].Notification[id].quantity,users[i].Notification[id].fromcommodityname,users[i].Notification[id].price ,users[i].Notification[id].tocommodityname,users[i].Notification[id].date);
       
    }
 //   else
    {
   //    SendRejectionNotification(users[i].Notification[id].buyer,users[i].Notification[id].seller,users[i].Notification[id].quantity,users[i].Notification[id].fromcommodityname,users[i].Notification[id].price ,users[i].Notification[id].tocommodityname,users[i].Notification[id].date);
       
    }
 }
 
}

contract History{
   
     ////history struct
   struct history
    {
         uint no_id;
        uint price;  
        string date;
        address seller;
        address buyer;
        string fromcommodityname;
        string tocommodityname;
        uint quantity;
    }
     
        struct history_array
    {
         mapping(uint256 => history) SaleHistory;
         mapping(uint256 => history) BuyHistory;
         mapping(uint256 => history) ExchangeHistory;
         
         uint256 HistorySaleCount;
         uint256 HistoryBuyCount;
         uint256 HistoryExchangeCount;
       
    }
      address public Usercontract; // smart contract address of Usercontract
      mapping(address => history_array) users;
      uint256 usercount;
   
    constructor () public {
       
    }
 
  function adduserhistory(address _address) public
  {
      users[_address]= history_array(0,0,0);
        usercount++;
  }
     
  function addtoSaleHistorylist(uint _price,string memory _date, address _seller, address _buyer,string memory _fromcommodityname , uint _quantity) public
  {
                users[_seller]. SaleHistory[users[_seller].HistorySaleCount]=history(users[_seller].HistorySaleCount,_price,_date, _seller,_buyer,_fromcommodityname,_fromcommodityname,_quantity);
                users[_seller].HistorySaleCount++;
    }
// same  for exchane and buy
 function addtoBuyHistorylist(uint _price,string memory _date, address _seller, address _buyer,string memory _fromcommodityname, uint _quantity) public
  {
                users[_buyer]. BuyHistory[users[_buyer].HistoryBuyCount]=history(users[_buyer].HistoryBuyCount,_price,_date, _seller,_buyer,_fromcommodityname,_fromcommodityname,_quantity);
                users[_buyer].HistoryBuyCount++;
    }
// same  for exchane and buy
 function addtoExchangeHistorylist(uint _price,string memory _date, address _seller, address _buyer,string memory _fromcommodityname,string memory _tocommodityname, uint _quantity) public
  {
                users[_buyer].ExchangeHistory[users[_buyer].HistoryExchangeCount]=history(users[_buyer].HistoryExchangeCount,_price,_date, _seller,_buyer,_fromcommodityname,_tocommodityname,_quantity);
                users[_buyer].HistoryExchangeCount++;
               
                users[_seller].ExchangeHistory[users[_seller].HistoryExchangeCount]=history(users[_seller].HistoryExchangeCount,_price,_date, _seller,_buyer,_fromcommodityname,_tocommodityname,_quantity);
               users[_seller].HistoryExchangeCount++;
               
    }
    function getHistorySaleCount(address i)public view returns (uint256) {
      return users[i].HistorySaleCount;
  }
   function getHistoryExchangeCount(address i)public view returns (uint256) {
      return users[i].HistoryExchangeCount;
  }
  function getHistoryBuyCount(address i)public view returns (uint256) {
      return users[i].HistoryBuyCount;
  }
 
   function getHistorySaleNameCommodity(address i,uint256 index)public view returns (string memory ) {
      return users[i].SaleHistory[index].fromcommodityname;
  }
   function getHistoryExchangeFromNameCommodity(address i,uint256 index)public view returns (string memory) {
      return users[i].ExchangeHistory[index].fromcommodityname;
  }
   function getHistoryExchangetoNameCommodity(address i,uint256 index)public view returns (string memory) {
      return users[i].ExchangeHistory[index].tocommodityname;
  }
   function getHistoryBuyNameCommodity(address i,uint256 index)public view returns (string memory) {
      return users[i].BuyHistory[index].fromcommodityname;
  }
 
   function getHistorySalePrice(address i,uint256 index)public view returns (uint256) {
      return users[i].SaleHistory[index].price;
  }
   function getHistoryExchangePrice(address i,uint256 index)public view returns (uint256) {
      return users[i].ExchangeHistory[index].price;
  }
   function getHistoryBuyPrice(address i,uint256 index)public view returns (uint256) {
      return users[i].BuyHistory[index].price;
  }
 
   function getHistorySaleQuantity(address i,uint256 index)public view returns (uint256) {
      return users[i].SaleHistory[index].quantity;
  }
   function getHistoryExchangeQuantity(address i,uint256 index)public view returns (uint256) {
      return users[i].ExchangeHistory[index].quantity;
  }
   function getHistoryBuyQuantity(address i,uint256 index)public view returns (uint256) {
      return users[i].BuyHistory[index].quantity;
  }
     
   
}