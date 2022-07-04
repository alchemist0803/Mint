//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFTCollectible is ERC721Enumerable, Ownable {
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    uint256 public constant MAX_SUPPLY = 100;
    uint256 public constant PRICE = 0.01 ether;
    uint256 public constant MAX_PER_MINT = 5;

    string public baseTokenURI;
    constructor(string memory baseURI) ERC721("NFT Collectible", "NFTC") {
        setBaseURI(baseURI);
    }
    function reserveNFTs() public onlyOwner {
       uint totalMinted = _tokenIds.current();
        require(
            totalMinted.add(10) < MAX_SUPPLY, "Not enough NFTs"
        );
        for (uint i = 0; i < 10; i++) {
            _mintSingleNFT();
        }
    }
    function _baseURI() internal 
                    view 
                    virtual 
                    override 
                    returns (string memory) {
        return baseTokenURI;
    }

    function setBaseURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }
}
