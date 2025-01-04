//things to do here
//Collect funds from users thorigh crowdfunding
//Withdraw collected funds
//Set a minimum funding threshold

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";
contract FundMe{
    //make function payable to allow it to accept ether
    using PriceConverter for uint256;

    uint256 public constant MIN_USD_LIMIT=5e18;

    address[] public funders;
    mapping(address funder=>uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;
    constructor(){
        i_owner=msg.sender;
    }

    function fund() public payable{
        //Allow users to send money
        //Have a minimum limit
        //1.How do we send ETH to this contract?
        require(msg.value.getConversionRate() >= MIN_USD_LIMIT,"Sorry,you need to send a minimum of 1 ETH!");//here the ETH sent along with transaction can be accessed using msg.value
        //also 1ETH=1e18 wei=1000000000000000000 wei
        //if condition is not met,transaction is reverted
        //What is revert?=>Undoes any actions done previously(basically every statement executed till now is undone)
        // and sends back the remaining gas(basically the gas meant for execution of statements that never actually got executed
        //due to revert done by require statement)

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=addressToAmountFunded[msg.sender]+msg.value;


    }

    function withdraw() public onlyOwner{
        //require(msg.sender==owner,"Only owner can withdraw funds!");
        //rather than writing above line for every function we wish to be accessed by the owner only,we can create a function
        //modifier
        for(uint256 funderIndex=0;funderIndex<funders.length;funderIndex++){
            address funder=funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        funders=new address[](0);
        //ways of sending ETH to whoever is withdrawing:
        //transfer
        //send
        //call

        // payable(msg.sender).transfer(address(this).balance);//2300 gas,throws error

        // bool sendSuccess=payable(msg.sender).send(address(this).balance);//2300 gas,returns bool
        // require(sendSuccess,"Send failed");

        (bool callSuccess,)=payable(msg.sender).call{value:address(this).balance}("");//forwards all ags orset gas,
        require(callSuccess,"Call failed");
    }

    modifier onlyOwner(){
        require(msg.sender==i_owner,"Only owner can withdraw funds!");//you can use custom errors here as well
        _;//underscore basically implies that when you add this modifier in the definition of a function,_ tells compiler 
        //to execute the code in the function
    }

    //now what to do if user sends ETH to contract without calling the fund function?
    //two special functions:
    //receive()=>it gets triggered when some ETH is sent to contract while calldata field is empty
    //fallback()=>it gets triggered when some ETH is sent to contract while calldata field may/may not be empty

    receive() external payable {
        fund();
    }

    fallback() external payable{
        fund();
    }
}
 