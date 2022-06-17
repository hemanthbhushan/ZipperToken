// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ZipperToken is ERC20 {
    mapping(address=>uint) tokenBalances;
    
    mapping(address => mapping(address => uint)) allowed;

    constructor(uint256 initialSupply) ERC20("ZipperToken", "ZIP") {
        _mint(msg.sender, initialSupply);
    }
    function balanceOf(address _owner) public view override returns (uint256 balance){
        return tokenBalances[_owner];
    } 
    function transfer(address _to, uint256 _value) public override returns (bool success){
        require(tokenBalances[msg.sender] >= _value,"insufficient Token");
        tokenBalances[msg.sender] -= _value;
        tokenBalances[ _to ] += _value;

        emit Transfer( msg.sender , _to , _value);
        return true;
       
    }
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        uint allowedBal = allowed[_from][msg.sender];
        require(allowedBal >= _value ,"Insufficient Balance");
        tokenBalances[_from] -= _value;
        tokenBalances[_to] -= _value;
         emit Transfer( _from , _to , _value);

         return true;
        

    }
    function approve(address _spender, uint256 _value) public override returns (bool success){
        require(tokenBalances[msg.sender] >= _value, "insuffecient balance");
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender , _value );
        return true;
    }
    function allowance(address _owner, address _spender) public override view returns (uint256 remaining){

        return allowed[_owner][_spender];

    }

}