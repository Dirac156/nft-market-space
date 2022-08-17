// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

contract KryptoBird is ERC721Connector {

    // array to store our nfts
    string [] public kryptoBirdz;

    // keep track of kryptobirdz minted
    mapping(string => bool) _kryptoBirdzExists;

    constructor() 
        ERC721Connector("KryptoBird", "KBIRDZ") {}

    function mint(string memory _kryptoBird) public {
        require(!_kryptoBirdzExists[_kryptoBird],
        'Error - kryptoBird already exists');
        
        // add a kryptobird into our list of kryptobirdz
        kryptoBirdz.push(_kryptoBird);

        uint _id = kryptoBirdz.length - 1;

        _mint(msg.sender, _id);

        _kryptoBirdzExists[_kryptoBird] = true;
    }
}