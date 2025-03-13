 address public owner = msg.sender;

    modifier onlyOwner() {
    require(msg.sender==owner,"Only owner can change fee.");
    _;
    }

    address public beneficiary = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    uint256 fee = 10;

    function changeFee(uint256 percent) public onlyOwner {
    fee = percent;
    }
    
        
    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }

        uint256 percent_value = (value*fee)/100;
        uint256 amount_after = value - percent_value;

        value = amount_after;

        _update(from, to, value);
        _update(from, beneficiary, percent_value);
 }
