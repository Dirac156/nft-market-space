// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    building out the minting function:
        a. nft to point to an address
        b. keep track of the token ids
        c. keep track of token owner addressesn to token ids
        d. keep track of how many tokens an owner address has
        e. create an event that emits a transfer log - contract address,
            where it is being minted to, the id        
*/

contract ERC721 {

    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId
    );

    // mapping in solidity creates a hash table of key pair values
    // mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;

    // mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    function _exists(uint256 tokenId) internal view returns(bool) {
        // setting the address of nft owner to check the mapping
        // of the address from tokenOwner at the tokenId.
        address owner = _tokenOwner[tokenId];
        // return truthiness the address is not zero
        return owner != address(0);
    }

    // require that the mint address isn't 0
    // require that the token has not already been minted
    function _mint(address to, uint256 tokenId) internal {
        // require that the mint address is not 0
        require(to != address(0), 'ERC721: minting to the zero address');
        // requires that the token does not already exist
        require(!_exists(tokenId), 'ERC721: token already minted');
        // we are adding a new address with a token id for minting
        _tokenOwner[tokenId] = to;
        // keeping track of each address that is missing and the 
        // number of tokens
        _OwnedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    } 
}