// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lecture2{

    receive() external payable { }
    address payable owner = payable(msg.sender);

    function sendEther() public payable{
        require(msg.value >= 1 ether, "Not enough funds.");
        payable(owner).transfer(address(this).balance);
    }

}
