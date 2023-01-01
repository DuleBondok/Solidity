
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/token/ERC721/ERC721.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract GameItems is ERC721 {
    uint256 internal _counter;

    struct ItemProps {
        string itemType;
        uint256 strength;
    }

    mapping(uint256 => ItemProps) internal items;

    constructor () ERC721 ("GameItem", "GAME") {}

    function createItem(string memory itemType, uint256 strength) external {
        _mint(msg.sender, _counter);
        ItemProps memory props;
        props.itemType = itemType;
        props.strength = strength;
        items[_counter++] = props;
    }

    function itemProps(uint256 id) external view returns(string memory itemType, uint256 strength) {
        require(_exists(id), "Item does not exist");
         ItemProps memory props = items[id];
         return(props.itemType, props.strength);
    }
}

contract CatNFTs is ERC721URIStorage {
    uint256 internal _counter;

    constructor () ERC721 ("CatNFTs", "CAT") {}

    function createImage (string memory url) external {
        _mint(msg.sender, _counter);
        _setTokenURI(_counter++,url);
    }
}