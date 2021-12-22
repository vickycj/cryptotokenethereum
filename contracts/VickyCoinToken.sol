// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ERC20Interface.sol";

contract VickyCoinToken is ERC20 {
    uint256 private constant MAX_UINT256 = 2**256 - 1;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;

    uint256 public totSupply;
    string public name;
    uint8 public decimals;
    string public symbol;

    constructor() {
        totSupply = 100000000000000;
        balances[msg.sender] = totSupply;
        name = "VickyCoin";
        decimals = 1;
        symbol = "VCN";
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balances[msg.sender] >= _value, "No funds available");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 allowanceAllowed = allowed[_from][msg.sender];
        require(
            balances[_from] >= _value && allowanceAllowed >= _value,
            "Funds not allowed"
        );
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowanceAllowed < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value);
        return true;
    }

    function totalSupply() public view returns (uint256 totSupp) {
        return totSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }
}
