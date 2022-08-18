// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

    uint256[] private _allTokens;

    /// @notice count NFTs tracked by thus contract
    /// @return uint256 A count of valid NFTs tracked by this contract,
    function totalSupply() external view returns (uint256) {
        return _allTokens.length;
    }

    /// @notice Enumerate valid NFTs
    /// @dev throws if `_index` >= `totalSupply()`.
    /// @param _index A counter less than `totoalSupply`
    /// @return uint256 The token identifier for the `_index`th NFT,
    /// (sort order not specified)
    function tokenByIndex(uint256 _index) external view returns(uint256) {

    }

    // overide _mint from ERC721
    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
    }
}