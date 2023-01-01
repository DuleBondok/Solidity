// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract MyERC20 {

    mapping (address => uint256) internal _balances;
    mapping (address => mapping (address => uint256)) internal _allowance;
    uint256 internal _totalSupply;
    string internal _name;
    string internal _symbol;
    uint8 internal _decimals;

    event Transfer(address indexed from, address indexed to, uint256 indexed amount);

    constructor(uint256 amount, string memory name_, string memory symbol_, uint8 decimals_) {
        mint(msg.sender, amount);
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;

    }

    function mint(address to, uint256 amount) internal {
        amount *= 10 ** _decimals;
        _balances[to] += amount;
        _totalSupply += amount;

        emit Transfer(address(0), to, amount);
    }

     function totalSupply() view external returns(uint256) {
        return _totalSupply;
    }

    function name() view external returns(string memory) {
        return _name;
    }

    function symbol() view external returns(string memory) {
        return _symbol;
    }

    function decimals() view external returns(uint8) {
        return _decimals;
    }

    function balanceOf(address account) view external returns(uint256) {
        return _balances[account];
    }

    function _transferFrom(address from, address to, uint256 amount) internal {
        require(_balances[from] >= amount, "Insufficient funds");
        require(from == msg.sender || _allowance[from][msg.sender] >= amount, "You are not the owner or dont have sufficient funds");
    
        _balances[from] -= amount;
        _balances[to] += amount;

        if(from != msg.sender) _allowance[from][msg.sender] -= amount;

        emit Transfer(from, to, amount);
    }

    function transferFrom(address from, address to, uint256 amount) external {
        _transferFrom(from, to, amount);
    }

    function transfer(address to, uint256 amount) external {
        _transferFrom(msg.sender, to, amount);
    }

    function allowance(address owner, address spender) view external returns(uint256) {
        return _allowance[owner][spender];
    }

    function approve(address account, uint256 amount) external {
        _allowance[msg.sender][account] = amount;
    }

    function burn(uint256 amount) external {
        require(_balances[msg.sender] >= amount, "Insufficient funds.");

        _balances[msg.sender] -= amount;
        _totalSupply -= amount;

        emit Transfer(msg.sender, address(0), amount);
    }


    
}

