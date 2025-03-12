// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DummyToken {
    mapping(address => uint) public balanceof;
    
    uint public limit = 200000; // Max mint per transaction
    uint public TotalSupply = 500000;
    uint public mintedSupply = 0; // Track total minted tokens
    address public owner;

    constructor() {
        owner = msg.sender; // Set the deployer as the contract owner
    }

    function deposit(uint amount) public {
        balanceof[msg.sender] += amount; // Add to existing balance
    }

    function transfer(address recipient, uint amount) public returns (bool) {
        require(balanceof[msg.sender] >= amount, "Not enough balance");
        require(recipient != address(0), "Not zero address");

        balanceof[msg.sender] -= amount;
        balanceof[recipient] += amount;

        return true;
    }

    function mint(address recipient, uint amount) public {
        require(msg.sender == owner, "Only owner can mint");
        require(recipient != address(0), "Cannot mint to zero address");
        require(amount > 0, "Amount must be greater than 0");
        require(amount <= limit, "Cannot mint more than 200,000 at once"); // Per-mint limit
        require(mintedSupply + amount <= TotalSupply, "Total supply exceeded"); // Correct supply check

        balanceof[recipient] += amount;
        mintedSupply += amount; // Track total minted tokens
    }
}
