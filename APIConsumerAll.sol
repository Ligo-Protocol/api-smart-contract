// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

//import "@openzeppelin/contracts/utils/math/SafeMath.sol"; 

contract MultiVariableRequest is ChainlinkClient, ConfirmedOwner {
  using Chainlink for Chainlink.Request;

  uint256 constant private ORACLE_PAYMENT = 0 * LINK_DIVISIBILITY / 100 * 5;
  int256 public _endLongitude;
  int256 public _endLatitude;
  uint256 public _endOdometer;

  /* // For decimals
  int256 public _endLongitudeDecimal;
  int256 public _endLatitudeDecimal;
  uint256 public _endOdometerDecimal;
  */

  constructor() ConfirmedOwner(msg.sender){
    setChainlinkToken(0xa36085F69e2889c224210F603D836748e7dC0088); //Kovan link address
    setChainlinkOracle(0x89dca850F3C3BF8fB0209190CD45e4a59632C73D); //Deployed Oracle Operator.sol
  }

// This function calls the EA from Job
  function requestdistanceAndlatitude(string memory _vehicleId, string memory _encToken)
    public
    onlyOwner
  {
    bytes32 _jobId = "65f26cc69fe2454eacf129aef846e65a"; //JobID in Chainlink Node. Remove dashes in the new jobID if you want to change it.
    Chainlink.Request memory req = buildChainlinkRequest(_jobId, address(this), this.fulfilldistanceAndlatitudeAndlongitude.selector);
    req.add("vehicleId", _vehicleId); //vehicleId parameter sent
    req.add("encToken", _encToken); //encToken parameter sent
    sendOperatorRequest(req, ORACLE_PAYMENT);
  }

// This function receives the data from API
  function fulfilldistanceAndlatitudeAndlongitude(
    bytes32 requestId,
    uint256 _distance,
    int256 _latitude,
    int256 _longitude
    
  )
    public
    recordChainlinkFulfillment(requestId)
  {
    _endOdometer = _distance/1000000000000000;
    _endLatitude = _latitude/1000000000000000;
    _endLongitude = _longitude/1000000000000000;
    /* // For decimals
    _endOdometerDecimal = _distance%1000000000000000;
    _endLatitudeDecimal = _latitude%1000000000000000;
    _endLongitudeDecimal = _longitude%1000000000000000;
    */
  }

  function stringToBytes32(string memory source) private pure returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
      return 0x0;
    }

    assembly { // solhint-disable-line no-inline-assembly
      result := mload(add(source, 32))
    }
  }

}