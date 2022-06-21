// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract FallbackExample {

    uint256 public result;

    // receive is a special type of function that doesn't require the function keyword; 
    // receive is called when the contract receives funds but there is no data associated with the transaction (ex: not through a fund() type transaction like we have in FundMe.sol)
    receive() external payable {
        result = 1; 
    }

    // similar to receive, fallback is called when the contract is called with an invalid function (calldata)
    fallback() external payable {
        result = 2;
    }
}