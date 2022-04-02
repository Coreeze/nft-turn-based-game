// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "hardhat/console.sol";
import "./libraries/Base64.sol";

contract MyEpicGame is ERC721 {
  struct CharacterAttributes {
    uint characterIndex;
    string name;
    string imageURI;
    uint hp;
    uint maxHp;
    uint attackDamage;
  }

  struct BigBoss {
    string name;
    string imageURI;
    uint hp;
    uint maxHp;
    uint attackDamage;
  }

  BigBoss public bigBoss;

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  CharacterAttributes[] defaultCharacters;

  // mapping from the nft's tokenId => that NFTs attributes
  mapping(uint256 => CharacterAttributes) public nftHolderAttributes;

  // storing the owner of the NFT and reference it later.
  mapping(address => uint256) public nftHolders;

  constructor(
    string[] memory characterNames,
    string[] memory characterImageURIs,
    uint[] memory characterHp,
    uint[] memory characterAttackDmg,
    string memory bossName,
    string memory bossImageURI,
    uint bossHp,
    uint bossAttackDamage
  )
    ERC721("Heroes", "HERO")
  {

    bigBoss = BigBoss({
        name: bossName,
        imageURI: bossImageURI,
        hp: bossHp,
        maxHp: bossHp,
        attackDamage: bossAttackDamage
    });

    console.log("Done initializing boss %s w/ HP %s, img %s", bigBoss.name, bigBoss.hp, bigBoss.imageURI);

    for(uint i = 0; i < characterNames.length; i += 1) {
      defaultCharacters.push(CharacterAttributes({
        characterIndex: i,
        name: characterNames[i],
        imageURI: characterImageURIs[i],
        hp: characterHp[i],
        maxHp: characterHp[i],
        attackDamage: characterAttackDmg[i]
      }));

      CharacterAttributes memory c = defaultCharacters[i];
      console.log("Done initializing %s w/ HP %s, img %s", c.name, c.hp, c.imageURI);
    }
    _tokenIds.increment();
  }

  function mintCharacterNFT(uint _characterIndex) external {
      uint256 newItemId = _tokenIds.current();

      // Assigns the tokenId to the caller's wallet address (aka mint the NFT)
      _safeMint(msg.sender, newItemId);

      nftHolderAttributes[newItemId] = CharacterAttributes({
        characterIndex: _characterIndex,
        name: defaultCharacters[_characterIndex].name,
        imageURI: defaultCharacters[_characterIndex].imageURI,
        hp: defaultCharacters[_characterIndex].hp,
        maxHp: defaultCharacters[_characterIndex].maxHp,
        attackDamage: defaultCharacters[_characterIndex].attackDamage
      });

      console.log("Minted NFT /w tokenID %s and characterIndex %s", newItemId, _characterIndex);

      nftHolders[msg.sender] = newItemId;

      _tokenIds.increment();
  }

  function tokenURI(uint256 _tokenId) public view override returns (string memory) {
    CharacterAttributes memory charAttributes = nftHolderAttributes[_tokenId];

    string memory strHp = Strings.toString(charAttributes.hp);
    string memory strMaxHp = Strings.toString(charAttributes.maxHp);
    string memory strAttackDamage = Strings.toString(charAttributes.attackDamage);

    string memory json = Base64.encode(
        abi.encodePacked(
        '{"name": "',
        charAttributes.name,
        ' -- NFT #: ',
        Strings.toString(_tokenId),
        '", "description": "This is an NFT that lets people play in the game Metaverse Slayer!", "image": "',
        charAttributes.imageURI,
        '", "attributes": [ { "trait_type": "Health Points", "value": ',strHp,', "max_value":',strMaxHp,'}, { "trait_type": "Attack Damage", "value": ',
        strAttackDamage,'} ]}'
        )
    );

    string memory output = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    return output;
  }

  function attackBoss() public {
    console.log("Attacking boss!");
    uint256 playerNFTId = nftHolders[msg.sender];
    require(
        nftHolderAttributes[playerNFTId].hp > 0,
        "Player must be alive to attack"
    );
    // Make sure the boss has more than 0 HP.
    require(
        bigBoss.hp > 0,
        "Boss already dead!"
    );
    CharacterAttributes storage player = nftHolderAttributes[playerNFTId];
    console.log("\nPlayer w/ character %s about to attack. Has %s HP and %s AD", player.name, player.hp, player.attackDamage);
    console.log("Boss %s has %s HP and %s AD", bigBoss.name, bigBoss.hp, bigBoss.attackDamage);

    // player attacks boss
    if (bigBoss.hp <= player.attackDamage) {
        bigBoss.hp = 0;
        console.log("Boss %s is dead", bigBoss.name);
    } else {
        bigBoss.hp = bigBoss.hp - player.attackDamage;
        console.log("Boss %s was attacked! New HP: %s ", bigBoss.name, bigBoss.hp);
    }

    // boss attacks player
    if (player.hp <= bigBoss.attackDamage) {
        player.hp = 0;
        console.log("Player %s is dead", player.name);
    } else {
        player.hp = player.hp - bigBoss.attackDamage;
        console.log("Player %s was attacked! New HP: %s ", player.name, player.hp);
    }
  }
}