// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract Coin {
    address public minter;
    mapping (address => uint) public balances;

    // Event Sent
    event Sent(address from, address to, uint amount);

    // Ran when contract first created
    constructor() {
        minter = msg.sender;
    }
    // Minter can send money to any address.
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    } 
    // 
    error InsufficientBalance(uint requested, uint available);

    // send coin from any caller to address
    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        // Change balances & send event
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
    
}