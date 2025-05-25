// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20, Ownable {
    constructor(address recipient) ERC20("TokenA", "TKA") Ownable(msg.sender) {
        _mint(recipient, 100000 * 10 ** decimals());
    }
     function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
    
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}

contract TokenB is ERC20, Ownable {
    constructor(address recipient) ERC20("TokenB", "TKB") Ownable(msg.sender) {
        _mint(recipient, 100000 * 10 ** decimals());
    }
     function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
    
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}


contract Bridge{

    IERC20 token_A;
    IERC20 token_B;

     constructor(address _tokenA, address _tokenB){
      token_A = IERC20(_tokenA);
      token_B = IERC20(_tokenB);
    }

    event TokenALocked(string aLocked, uint256 amount);
    event TokenBMinted(string bMinted, uint256 amount);
    event TokenBBurned(string bBurned, uint256 amount);
    event TokenAReleased(string aReleased, uint256 amount);

    function bridgeAtoB(uint256 amount) external {
        require(amount > 0, "Amount needs to be greater than 0.");

        token_A.transferFrom(msg.sender, address(this), amount);
        emit TokenALocked("Token A has been locked", amount);

        TokenB(address(token_B)).mint(msg.sender, amount);
        emit TokenBMinted("Token B has been minted", amount);
    }

    function bridgeBToA(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(token_A.balanceOf(address(this)) >= amount, "Not enough locked TokenA");
        
        token_B.transferFrom(msg.sender, address(this), amount);
        TokenB(address(token_B)).burn(amount);
        emit TokenBBurned("TokenB has been burned", amount);

        token_A.transfer(msg.sender, amount);
        emit TokenAReleased("Token A has been released", amount);
    }

}
