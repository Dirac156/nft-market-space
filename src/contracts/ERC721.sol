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

    event Approval (
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );

    // mapping in solidity creates a hash table of key pair values
    // mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;

    // mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    // mapping from token id to approved addresses
    mapping(uint256 => address) private _tokenApproval;

    function _exists(uint256 tokenId) internal view returns(bool) {
        // setting the address of nft owner to check the mapping
        // of the address from tokenOwner at the tokenId.
        address owner = _tokenOwner[tokenId];
        // return truthiness the address is not zero
        return owner != address(0);
    }

    // require that the mint address isn't 0
    // require that the token has not already been minted
    function _mint(address to, uint256 tokenId) virtual internal {
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

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid,
    /// and function throws for queries abount the zero address.
    /// @param _owner Address for whom to query the balance
    /// @return uint256 The number of NFTs owned by _owner possib;u zero. 

    function balanceOf(address _owner) public view returns(uint256) {
        require(_owner != address(0), 'ERC721: balanceOf to the zero address');
        return _OwnedTokensCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid,
    /// and query about then do throw.
    /// @param _tokenId the id ok the nft we want to check.
    /// @return address owner of the token

    function ownerOf(uint256 _tokenId) public view returns(address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'ERC721: ownerOf to the zero address');
        return owner;
    }

    /// @notice transfer nft from one address to another
    /// @param _from The current owner of the NFT
    /// @param _to The NFT's receiver (The new owner)
    /// @param _tokenId The NFT to transfer

    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_to != address(0), 'ERC721: Transfer To Invalid Receiver Address');
        require(ownerOf(_tokenId) == _from, 'ERC721: Invalid token Id owner address');
        // update balance of address _from and _to
        _OwnedTokensCount[_from] -= 1;
        _OwnedTokensCount[_to] += 1;
        // add the token id to the address receiiving the token
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function approveTransfer(address _to, uint256 _tokenId) public {
        require(msg.sender == ownerOf(_tokenId), 'ERC721: current caller is not the owner of the token');
        require(msg.sender != _to, 'ERC721: approval to current owner');
        _tokenApproval[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }

    function isTransferApproved(address spender, uint256 tokenId) internal view returns(bool) {
        require(_exists(tokenId), 'ERC721!: Token does not exist');
        address owner = ownerOf(tokenId);
        return (spender == owner);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external {
        require(isTransferApproved(msg.sender, _tokenId), 'ERC721: Transfer is not approved');
        _transferFrom(_from, _to, _tokenId);
    }

}