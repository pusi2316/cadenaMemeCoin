// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract CoinContract is ERC20, Ownable, ERC20Burnable {
    event onCoinsMinted(address indexed owner, uint256 amount, string message);
    event onCoinsBurned(address indexed owner, uint256 amount, string message);
    event onAdditionalCoinsMinted(address indexed owner, uint256 amount, string message);

    constructor() ERC20("AwesomeCoin", "AWC") {
        _mint(msg.sender, 2000*10**18);
        emit onCoinsMinted(msg.sender, 2000*10**18, "AwesomeCoin has been born with a supply of initial coins");
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
        emit onAdditionalCoinsMinted(msg.sender, _amount, "Coins minted.");
    }

    function burn(uint256 _amount) public override onlyOwner {
        _burn(msg.sender, _amount);
        emit onCoinsBurned(msg.sender, _amount, "Coins burned");
    }
}