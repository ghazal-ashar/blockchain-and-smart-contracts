contract Staking{

    Ghazal public token;

    mapping(address => uint256) public stakes;
    uint8 constant public reward = 5;

    function stake(uint256 amount) public{

        token.transfer(address(this), amount);
        stakes[msg.sender] += amount;

    }

}
