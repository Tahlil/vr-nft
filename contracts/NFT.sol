// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";


import "hardhat/console.sol";


contract SpaceToken is ERC721, Ownable, ReentrancyGuard {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    // uint value multiple of 1000000
    struct SpaceObjDetails{
        string description;
        bool minted;
        uint256 gravityValue;
        uint256 massValue;
        uint256 radiusValue;
        uint256 velocityValue;
        uint256 distanceValue;
        int256 temperatureValue;
        uint256 dayValue;
        uint256 yearValue; 
    }
    mapping (uint256=>string) nftDetails;

    mapping (string=>SpaceObjDetails) private whitelistedNFT;

    constructor() ERC721("SpaceToken", "SPC") {
       whitelistedNFT["mercury"] = SpaceObjDetails(
       "I am the smallest planet and closest to the sun",
       false,
       3700000,
       55300,
       2439700000,
       47400000,
       57900000,
       167000000,
       4222600000,
       88000000
       );
        whitelistedNFT["venus"] = SpaceObjDetails(
        "I have a thick atmosphere full of the greenhouse gas carbon dioxide and clouds made of sulfuric acid. The gas traps heat and makes me the hottest planet.",
        false,
        8900000,
        815000,
        6051800000,
        35000000,
        108200000,
        464000000,
        2802000000,
        224700000
        );

        whitelistedNFT["earth"] = SpaceObjDetails(
        "I am special because I,m an ocean planet. Water covers 70% of my surface.",
        false,
        9800000,
        1000000,
        6371000000,
        29800000,
        149600000,
        15000000,
        24000000,
        365200000
        );

        whitelistedNFT["mars"] = SpaceObjDetails(
        "I'm a cold desert world.I'm red because of rusty iron in my ground.There are signs of ancient floods on me, but now water mostly exists in icy dirt and thin clouds.",
        false,
        3700000,
        107000,
        3389500000,
        24100000,
        227900000,
        -65000000,
        24700000,
        687000000
        );

        whitelistedNFT["jupiter"]= SpaceObjDetails(
        "I'm the biggest planet in the solar system.I'm a gas giant and doesn't have a solid surface",
        false,
        23100000,
        317830000,
        69911000000,
        13100000,
        778600000,
        -110000000,
        9900000,
        4331000000
        );

        whitelistedNFT["saturn"] = SpaceObjDetails(
        "I'vethe most beautiful rings.I'm mostly a ball of hydrogen and helium",
        false,
        9000000,
        95162000,
        58232000000,
        9700000,
        1433500000,
        -140000000,
        10700000,
        10747000000
        );

        whitelistedNFT["uranus"] = SpaceObjDetails(
        "I'm surrounded by a set of 13 rings.I'm an ice giant with blue color.I'm the only planet that spins on my side ",
        false,
        8700000,
        14536000,
        25362000000,
        6800000,
        2872500000,
        -195000000,
        17200000,
        30589000000
        );

        whitelistedNFT["neptune"] = SpaceObjDetails(
        "It's pretty cold out here.I look like Uranus(Blue and Icy)",
        false,
        11000000,
        17147000,
        24622000000,
        5400000,
        4495100000,
        -200000000,
        16100000,
        59800000000
        );

        whitelistedNFT["JamesWebbTelescope"] = SpaceObjDetails(
        "As the largest optical telescope in space, its greatly improved infrared resolution and sensitivity allow it to view objects too early, distant, or faint for the Hubble Space Telescope",
        false,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
        );
    }

    function checkEmptyString(string memory s) public pure returns(bool){
       return keccak256(abi.encode("")) ==keccak256(abi.encode(s));
    }

    modifier isInWhiteListNFT(string memory nameToCheck) {
        require(!checkEmptyString(whitelistedNFT[nameToCheck].description), "Not in the whitlist");
        _;
    }

    modifier notMinted(string memory nameToCheck) {
        require(!whitelistedNFT[nameToCheck].minted, "Already minted");
        _;
    }

    function safeMint(address to, string memory name) public onlyOwner isInWhiteListNFT(name) notMinted(name) nonReentrant {
        uint256 tokenId = _tokenIdCounter.current();
        nftDetails[tokenId] = name;
        whitelistedNFT[name].minted = true;
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function getMintStatus(string memory nameToCheck) public view isInWhiteListNFT(nameToCheck) returns(bool){
        return whitelistedNFT[nameToCheck].minted;
    }
}


