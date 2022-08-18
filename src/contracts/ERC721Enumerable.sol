// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to list of all owned token ids
    mapping(address => uint256[]) private _ownedTokens;

    // mapping from token ID index to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    /// @notice add tokens to the _allTokens array 
    /// and set the position of the token indexes
    function _addTokenToAllTokensToEnumerable(uint256 tokenId) private {
        // keep track of the tokenId in the list of all tokens
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    /// @notice add the address and token id to the _ownedTokens
    /// ownedTokensIndex tokenId set to address of ownedTokens position.
    /// execute the function with minting
    function _addTokenToOwnerEnumeration(address owner, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[owner].length;
        _ownedTokens[owner].push(tokenId);
    }

    /// @notice count NFTs tracked by thus contract
    /// @return uint256 A count of valid NFTs tracked by this contract,
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /// @notice Enumerate valid NFTs
    /// @dev throws if `index` >= `totalSupply()`.
    /// @param index A counter less than `totoalSupply`
    /// @return uint256 The token identifier for the `_index`th NFT,
    /// (sort order not specified)
    function tokenByIndex(uint256 index) external view returns(uint256) {
        // make sure thr index is not out of range
        require(index < totalSupply(), 'global index is out of bounds');
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns(uint256){
        require(index < balanceOf(owner), 'owner index is out of bounds');
        return _ownedTokens[owner][index];
    }

    // overide _mint from ERC721
    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        _addTokenToAllTokensToEnumerable(tokenId);
        _addTokenToOwnerEnumeration(to, tokenId);
    }

}