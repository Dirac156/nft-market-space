// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

contract KryptoBird is ERC721Connector {

    // array to store our nfts
    string [] public kryptoBirdz;

    constructor() 
        ERC721Connector("KryptoBird", "KBIRDZ") {}

    function mint(string memory _kryptoBird) public {
        // this is deprecated 
        // uint _id = KtyptoBirdz.push(_kryptoBird);
        // .push returns the reference to the added element
        kryptoBirdz.push(_kryptoBird);
        uint _id = kryptoBirdz.length - 1;
        _mint(msg.sender, _id);
    }
}