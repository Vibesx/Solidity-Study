// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// NOTE: one solidity file can contain multiple contracts, although it would be a better practice to create one file for each contract and use import
contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    // in order to interact with another contract you need the address and ABI (Application Binary Interface) of the contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }

}