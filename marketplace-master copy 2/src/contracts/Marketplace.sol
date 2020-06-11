pragma solidity ^0.5.0;

contract Marketplace {
    string public name;
    uint public productCount = 0;
    mapping(uint => Product) public products;

    uint public userCount = 0;
    mapping(uint => User) public users;

    struct User{
        uint id;
        string uname;
        string password; 
        address payable owner;
  

    }
    struct Product {
        uint id;
        string name;
        uint price;
        address payable owner;
        bool purchased;
    }

    event UserLoggedin(
    uint id,
    string uname,
    string password,
            address payable owner

    );

    event ProductCreated(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );

    event ProductPurchased(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );

    constructor() public {
        name = "Dapp University Marketplace";
    }

    function LoginUser(string memory _uname, string memory _password) public payable{



        // Require a valid username
        require(bytes(_uname).length > 0);
        // Require a valid password
        require(bytes(_password).length > 0);
        // Increment user count
        userCount ++;
        // Login the user
        users[userCount] = User(userCount, _uname, _password,msg.sender);
        // Trigger an event
        emit UserLoggedin(userCount, _uname, _password,msg.sender);
    }

    function createProduct(string memory _name, uint _price) public {
        // Require a valid name
        require(bytes(_name).length > 0);
        // Require a valid price
        require(_price > 0);
        // Increment product count
        productCount ++;
        // Create the product
        products[productCount] = Product(productCount, _name, _price, msg.sender, false);
        // Trigger an event
        emit ProductCreated(productCount, _name, _price, msg.sender, false);
    }

    function purchaseProduct(uint _id) public payable {
        // Fetch the product
        Product memory _product = products[_id];
        // Fetch the owner
        address payable _seller = _product.owner;
        // Make sure the product has a valid id
        require(_product.id > 0 && _product.id <= productCount);
        // Require that there is enough Ether in the transaction
        require(msg.value >= _product.price);
        // Require that the product has not been purchased already
        require(!_product.purchased);
        // Require that the buyer is not the seller
        require(_seller != msg.sender);
        // Transfer ownership to the buyer
        _product.owner = msg.sender;
        // Mark as purchased
        _product.purchased = true;
        // Update the product
        products[_id] = _product;
        // Pay the seller by sending them Ether
        address(_seller).transfer(msg.value);
        // Trigger an event
        emit ProductPurchased(productCount, _product.name, _product.price, msg.sender, true);
    }
}
