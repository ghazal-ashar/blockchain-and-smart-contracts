// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lecture1{

    // function add(uint256 a, uint256 b) public pure returns(uint256){
    //     return a+b;
    // }

    // function sub(uint256 a, uint256 b) public pure returns(uint256){
    //     return a-b;
    // }

    // function multiply(uint256 a, uint256 b) public pure returns(uint256){
    //     return a*b;
    // }

    // function divide(uint256 a, uint256 b) public pure returns(uint256){
    //     return a/b;
    // }

    // int public num;

    // function increment() public{
    //     num++;
    // }

    //  function decrement() public{
    //     num--;
    // }

    // bool public value = true;

    // function toggle() public returns(bool){
    //     if (value == true){
    //         value = false;
    //     } else {
    //         value = true;
    //     }
    //     return value;
    // }

    // function oddeven(int256 num) public pure returns (string memory) {
    //     if (num % 2 == 0) {
    //         return "Num is Even";
    //     } else {
    //         return "Num is Odd";
    //     }
    // }

    // function stringConcat(string memory a, string memory b) public pure returns (string memory) {
    //     return string(abi.encodePacked(a," ",b));
    // }

    // function evenRequire(int256 num) public pure {
    //    require(num % 2 == 0, "ERROR: Num is Odd");
    // }

    function getOwner() public view returns (address) {
        return msg.sender;
    }
}
