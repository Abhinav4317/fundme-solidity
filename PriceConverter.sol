// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


//libraries in solidity do not have any state variable,also if all library functions are internal,then library is embedded 
//in contract itself otherwise we have to deploy the library first and then use it

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
library PriceConverter{
    //now here instead of limit in ETH,if i want to set the limit in usd=>conversion of usd to ETH is not fixed and regularly
        //varies,so you constantly need to fetch data from real world regarding current conversion rate
        //interaction of blockchain contracts with real world is done throigh oracles since blockchain itself is deterministic
        //simple bacause they work thorugh consensus->if we start using random values or fetched data,different blocks might start getting
        //different results

        //ORACLES->system that interacts with off-chain world to provide external data or computation to blockchain
        //now centralized oracles defeat the purpose of blochchain in itself
        //so we use CHAINLINK->modular decentralized oracle network that can be customised to bring external data or computation
        //into the blockchain system

        //CHAINLINK+TRADITIONAL SMART CONTRACTS=HYBRID SMART CONTRACTS 
    //working with oracles:
    function getPrice() internal view returns(uint256){
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI - compile its interface to know about its functions
        //basically interacting with external reference contract
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        (,int256 price,,,)=priceFeed.latestRoundData();
        return uint256(price*1e10);
         
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice=getPrice();
        uint256 ethAmoutUsd=(ethPrice*ethAmount)/1e18;
        return ethAmoutUsd;
    }

}