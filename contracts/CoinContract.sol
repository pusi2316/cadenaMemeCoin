// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract CoinContract is ERC20, Ownable, ERC20Burnable {
    event coinsMinted(address indexed owner, uint256 amount, string message);
    event coinsBurned(address indexed owner, uint256 amount, string message);
    event additionalCoinsMinted(address indexed owner, uint256 amount, string message);
    event coinsTransfered(address indexed snder, address indexed to, uint256 amount, string message);

    constructor() ERC20("AwesomeCoin", "AWC") {
        _mint(msg.sender, 2000*10**decimals());
        emit coinsMinted(msg.sender, 2000*10*decimals(), "AwesomeCoin has been bor with a supply of initial coins");
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
        emit additionalCoinsMinted(msg.sender, _amount, "Coins minted.");
    }

    function burn(uint256 _amount) public override onlyOwner {
        _burn(msg.sender, _amount);
        emit coinsBurned(msg.sender, _amount, "Coins burned");
    }

    function transfer(address _to, uint256 _amount) public override returns(bool){
        _transfer(msg.sender, _to, _amount);
        return true;
    }
}