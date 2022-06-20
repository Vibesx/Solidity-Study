//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SafeMathTester {

    uint8 public bigNumber = 255;

    function add() public {
        bigNumber = bigNumber + 1;
        // before version 0.8.0, this would cause bigNumber to cycle through to 0.
        // from version 0.8.0 onward, this fails with an error, because it would overflow. SafeMath library would help with that
        // we can use unchecked keyword to skip this check and risk a spillover
        // syntax: unchecked {operation;} ex: unchecked {bigNumber = bigNumber + 1;}
        // !!! while risky, unchecked reduces gas cost of our contract, thus we can use it if we are sure there will be no overflows
    }
}