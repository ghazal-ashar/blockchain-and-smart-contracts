// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DummyToken{

    mapping(address=>uint)public balanceof;

    uint limit = 200000;
    uint TotalSupply = 500000;
    address owner = msg.sender;

    function deposit(uint amount)public {
        balanceof[msg.sender]= amount;
    }
    function transfer(address sender,address recipent,uint amount)public returns (bool){
        require(balanceof[sender] >= amount, "Not enough balance");
        require(recipent != address(0), "Not zero address");

        balanceof[sender] -= amount;
        balanceof[recipent] += amount;

        return true;
    }

     function mint(address recipient, uint amount) public {
        require(msg.sender==owner,"only owner can mint");
        require(recipient != address(0), "Cannot mint to zero address");
        require(amount>0,"Amount must be greater than 0");
        require(limit<=TotalSupply,"Limit Reached");
        balanceof[recipient] += amount;
    }

}
