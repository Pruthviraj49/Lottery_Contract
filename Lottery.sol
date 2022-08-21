//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    address public manager;
    address payable[]public participants;


    constructor() 
    {
        manager = msg.sender;  //global Variable to make the controller of the contract => manager 

    }

    // Participants can transfer ethers in contract through it

    receive() external payable
    {   
        require(msg.value == 1 ether);
        participants.push(payable(msg.sender));
    }

    // Total balance sended to manager
    function getBalance() public view returns(uint)
    {   
        require(msg.sender == manager);
        return address(this).balance;
    }

    // random number generation
    function random() public view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
          
    }

    // returns winner's address
    function selectWinner() public view returns(address){
        require(msg.sender == manager);
        require(participants.length>=3); // necessary condition to announce the winner

        uint largeNumber = random();

        address payable winner;   

        uint winnerIndex = largeNumber % participants.length;
        winner = participants[winnerIndex];
        return winner;
    }
   
    
}
