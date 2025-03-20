// contract Staking{

//     Ghazal public token;

//     mapping(address => uint256) public stakes;
//     uint8 public reward = 5;

//     function stake(uint256 amount) public{

//         token.transfer(address(this), amount);
//         stakes[msg.sender] += amount;

//     }

// }

//Above did not work without a constructor.


contract Staking {

    Ghazal public token;

    mapping(address => uint256) public stakes;
    uint8 public reward = 5;

    constructor(address token_address) {
        token = Ghazal(token_address);
    }

    function stake(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");

        token.transfer(address(this), amount);

        stakes[msg.sender] += amount;
    }

    function unstake() public {
       
        uint256 stakedAmount = stakes[msg.sender];
        require(stakedAmount > 0, "No tokens staked");

        uint256 rewardAmount = (stakedAmount * reward) / 100;

        uint256 amount = stakedAmount + rewardAmount;

        token.transfer(msg.sender, amount);

        stakes[msg.sender] = 0;
    }

}
