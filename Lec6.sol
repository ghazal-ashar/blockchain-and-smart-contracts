contract Staking {

    Ghazal public token;
    address public contractAdd;

    mapping(address => uint256) public stakes;
    uint256 public reward;

    mapping(address => uint256) public stakeTime;

    constructor(address token_address) {
        token = Ghazal(token_address);
        
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");

        token.transfer(address(this), amount);

        stakes[msg.sender] += amount;
        stakeTime[msg.sender] = block.timestamp;
    }

    function unstake() external {
       
        uint256 stakedAmount = stakes[msg.sender];
        uint256 time = stakeTime[msg.sender];
        require(block.timestamp >= (time + (1 days)), "Wait a minimum of 24 hours before unstaking.");
        require(stakedAmount > 0, "No tokens staked");

        reward = (block.timestamp - time) / 1 seconds;

        uint256 rewardAmount = (stakedAmount * reward) / 100;

        uint256 amount = stakedAmount + rewardAmount;

        token.transfer(msg.sender, amount);

        stakes[msg.sender] = 0;
    }
}
