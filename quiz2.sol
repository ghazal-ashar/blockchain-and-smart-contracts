// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract TokenA is ERC20 {
    constructor(address recipient) ERC20("TokenA", "TKA") {
        _mint(recipient, 100000 * 10 ** decimals());
    }
}
    
contract ERC20Auction{

    IERC20 tokenA;

    constructor(address _tokenA){
        tokenA = IERC20(_tokenA);
    }

    struct Listing{
        uint listingID;
        address seller;
        IERC20 token;
        uint pricePerToken;
        uint remainingAmount;
    }
    
    Listing[] public listings;
    
    uint id = 0;

    event list(uint listingId, address seller, IERC20 token, uint amount);
    event buy(IERC20 token, uint amount, address buyer);

    function listTokens(IERC20 token, uint totalAmount, uint pricePerToken) external{
        require(totalAmount > 0 && pricePerToken > 0, "Cannot be 0.");
        require(tokenA.balanceOf(msg.sender) >= totalAmount, "Amount needs to be greater than or equal to your balance.");
    
        token.transfer(address(this), totalAmount);
        
        id++;
        listings[id].seller = msg.sender;
        listings[id].token = token;
        listings[id].pricePerToken = pricePerToken;
        listings[id].remainingAmount = totalAmount;

        emit list(id, msg.sender, token, totalAmount);
    }

    function buyTokens(uint listID, uint tokenAmount) external payable{
        require(listings[listID].seller != msg.sender);
        require(msg.value <= address(msg.sender).balance, "Not enough ETH.");
        require(tokenAmount <= listings[listID].remainingAmount, "Not enough tokens available.");
    
        uint pricePerToken = listings[listID].pricePerToken; 
        
        if (msg.value == (tokenAmount * pricePerToken)){
            payable(listings[listID].seller).transfer(address(this).balance);
            listings[listID].token.transfer(msg.sender, tokenAmount);
    }
    
    emit buy(listings[listID].token, tokenAmount, msg.sender);
}

    function getListCount() public view returns (uint){
        return listings.length;
    }


}

