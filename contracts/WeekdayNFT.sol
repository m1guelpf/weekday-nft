//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import 'base64-sol/base64.sol';
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";


contract WeekdayNFT is ERC721Burnable, Ownable {
    using Address for address;
    using Strings for uint256;
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

	uint256 public secondsInDay = 1 * 60 * 60 * 24;
	uint256 public secondsInWeek = secondsInDay * 7;

	string[] public daysOfWeek = ['Thursday', 'Wednesday', 'Tuesday', 'Monday', 'Sunday', 'Saturday', 'Friday'];

	constructor() ERC721('WeekDayNFT', 'WEEK') {
        claim();
        claim();
    }

    function claim() public returns (uint256) {
        _tokenIds.increment();
        uint256 tokenID = _tokenIds.current();

        require(tokenID < 10, "no tokens left");

        _mint(_msgSender(), tokenID);

        return tokenID;
    }

	function getWeekDay() public view returns (string memory) {
		uint256 startDayTimestamp = block.timestamp / secondsInDay * secondsInDay * 1000;

		uint256 dayIndex = ((startDayTimestamp % secondsInWeek) + secondsInWeek) % secondsInWeek / secondsInDay;

		return daysOfWeek[dayIndex];
	}

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "token does not exist");

        string[3] memory parts;
        // solhint-disable-next-line max-line-length
        parts[0] = '<svg viewBox="0 0 350 350" xmlns="http://www.w3.org/2000/svg"><path fill="#000000" fill-rule="nonzero" d="M0 0h350v350H0z"/><text font-family="Helvetica" font-size="12" fill="#FFFFFF"><tspan x="65" y="145">Today is...</tspan></text><text fill="#FFFFFF" font-family="Helvetica" font-size="50"><tspan x="70" y="194">';
        parts[1] = this.getWeekDay();
        parts[2] = '</tspan></text></svg>';
        bytes memory output = abi.encodePacked(parts[0], parts[1], parts[2]);

        // solhint-disable-next-line max-line-length
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "WeekDay NFT #', tokenId.toString(), '", "description": "A simple generative NFT that displays the current day of the week.", "image": "data:image/svg+xml;base64,', Base64.encode(output), '"}'))));
        output = abi.encodePacked('data:application/json;base64,', json);

        return string(output);
    }
}
