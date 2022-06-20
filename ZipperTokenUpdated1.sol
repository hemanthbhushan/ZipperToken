// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ZipperToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("ZipperToken", "ZIP") {
        _mint(msg.sender, initialSupply);
    }
    function balanceOf(address _owner) public view override returns (uint256 balance){
        return _balances[_owner];
        } 
    function transfer(address _to, uint256 _value) public override returns (bool success){
        require(_balances[msg.sender] >= _value,"insufficient Token");
       _transfer(msg.sender, to, amount);

        emit Transfer(msg.sender, to,_value);
        return true;
        }
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        _transfer(from, to, amount);
         emit Transfer(_from,_to, _value);

         return true;
        }
    function approve(address _spender, uint256 _value) public override returns (bool success){
        require(_balances[msg.sender] >= _value, "insuffecient balance");
        _allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender,_value);
        return true;
    }
    function allowance(address _owner, address _spender) public override view returns (uint256 remaining){

        return _allowances[_owner][_spender];

    }

}
