// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor(address recipient) ERC20("TokenA", "TKA") {
        _mint(recipient, 100000 * 10 ** decimals());
    }
}

contract TokenB is ERC20 {
    constructor(address recipient) ERC20("TokenB", "TKB") {
        _mint(recipient, 100000 * 10 ** decimals());
    }
}

contract swapping{

    IERC20 tokenA;
    IERC20 tokenB;
    uint rate;

    address owner;

    event swap_event(uint amount, address A, address B);

    constructor(address _tokenA, address _tokenB, uint _rate){
        owner = msg.sender;
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        rate = _rate;
    }

    function swap(uint amount) external{
        require(amount > 0, "Amount should be greater than zero.");
        
        require(tokenA.transferFrom(msg.sender, address(this), amount*rate), "Could not transfer");
        // require(tokenA.transfer(address(this), amount*rate), "Could not transfer");
        tokenB.transfer(msg.sender, amount);

        emit swap_event(amount, address(tokenA), address(tokenB));
    }

    modifier onlyOwner {
    require(msg.sender == owner, "Not the contract owner");
    _;
}

    function changeRate(uint _rate) public onlyOwner{
        rate = _rate;
    }
}
