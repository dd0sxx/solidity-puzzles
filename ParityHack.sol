/// SPDX-License-Identifier: UNLICENSED
/// @title Optimization Contract
/// @author: dd0sxx, https://github.com/dd0sxx, https://twitter.com/dd0sxx
/// difficulty: 6/10

/// claim ownership of the Wallet contract

pragma solidity ^0.8.0;

contract WalletLibrary {
     address owner;

     // called by constructor
     function initWallet (address _owner) private {
         owner = (_owner);
         // ... more setup ...
     }

     function changeOwner(address _new_owner) external {
         if (msg.sender == owner) {
             owner = (_new_owner);
         }
     }

     fallback () external  {
         // ... receive money, log events, ...
     }

     function withdraw(uint amount) external returns (bool success) {
         if (msg.sender == owner) {
             return payable(owner).send(amount);
         } else {
             return false;
         }
     }
}

contract Wallet {
    address owner;
    address _walletLibrary;

    constructor (address WalletLib) {
        _walletLibrary = WalletLib;
        _walletLibrary.delegatecall(abi.encodeWithSignature("initWallet(address)", msg.sender));
    }

    function withdraw(uint amount) public returns (bool success) {
        (bool out, bytes memory data) = _walletLibrary.delegatecall(abi.encodeWithSignature("withdraw(uint)", amount));
        return out;
    }

    fallback () external payable {
        _walletLibrary.delegatecall(msg.data);
    }
}

/// answer: https://blog.openzeppelin.com/on-the-parity-wallet-multisig-hack-405a8c12e8f7/