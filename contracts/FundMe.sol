// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;
    
    function fund() public payable {
        // require can take a second argument that is an error message that is sent in case of failure
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough!"); //1e18 == 1*10 ** 18; msg.value is in wei and 1 ether = 1 * 10^18 wei
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public {
        // reset the mapping
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex = funderIndex + 1) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array to a new address array with (0) elements in it. (1) would mean 1 elements, (2) would mean 2 elements, etc; basically <type>[](0) is an empty array of <type>
        funders = new address[](0);
        // actually withdraw the funds
        // 3 ways to send funds: transfer, send and call
        // transfer - we need to cast msg.sender to a payable address; msg.sender is an address, while payable(msg.sender) becomes a payable address through casting
        // address(this).balance takes the whole balance of the contract; transfer can take any uint256(? I guess) values
        
        //payable(msg.sender).transfer(address(this).balance));
        
        // both transfer and send cost 2300 gas; the problem with transfer, though is that it throws an error if the gas limit is exceeded, while send returns a boolean whether it succeeded or not
        // send - returns a bool with success status and it is adviseable to store it in a bool and follow up with a require for it to be true, so that the transaction is reverted in case of failure
        
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send failed!");

        // call - allows us to call methods by their name
        // in the next example, we treat the call as a transaction by leaving the parameters blank and hardcoding the details (value)
        // call returns two values: a bool that stores whether the call was successfull or not and a bytes variable that stores the returned data
        // in our case, we don't need dataReturned as we aren't calling an actual function
        // as with send, we should check the success of the call with a require
        (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed!");

        // currently, call is the prefered way of withdrawing tokens
    }
}