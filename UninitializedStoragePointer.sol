/// SPDX-License-Identifier: UNLICENSED
/// @title Optimization Contract
/// @author: dd0sxx
/// difficulty: 6/10

/// execute the following function calls:
///     - setHappy(0)
///     - surpriseOne(0) 
/// what is the value of campers[0].isHappy ?

pragma solidity 0.4.19;

contract One {
 
  uint x = 100;
 
  function getXAndY() public view returns(uint, uint) {
    uint y = 101;
    return (x,y);
  }
}

contract Two {
 
  struct Camper {
    bool isHappy;
  }
 
  mapping(uint => Camper) public campers;
 
  function setHappy(uint index) public {
    campers[index].isHappy = true;
  }
  function surpriseOne(uint index) public {
    Camper c = campers[index];
    c.isHappy = false;
  }
 
}

contract Three {
 
  struct Camper {
    bool isHappy;
  }
 
  uint public x = 100;
 
  mapping(uint => Camper) public campers;
 
  function setHappy(uint index) public {
    campers[index].isHappy = true;
  }
 
  function surpriseTwo() public {
    Camper storage c;
    c.isHappy = false;
  }
}


/// answer:
/// read this article: https://blog.b9lab.com/storage-pointers-in-solidity-7dcfaa536089
