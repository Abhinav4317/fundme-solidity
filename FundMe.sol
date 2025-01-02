//things to do here
//Collect funds from users thorigh crowdfunding
//Withdraw collected funds
//Set a minimum funding threshold

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
contract FundMe{
    //make function payable to allow it to accept ether
    function fund() public payable{
        //Allow users to send money
        //Have a minimum limit
        //1.How do we send ETH to this contract?
        require(msg.value > 1e18,"Sorry,you need to send a minimum of 1 ETH!");//here the ETH sent along with transaction can be accessed using msg.value
        //also 1ETH=1e18 wei=1000000000000000000 wei
        //if condition is not met,transaction is reverted
        //What is revert?=>Undoes any actions done previously(basically every statement executed till now is undone)
        // and sends back the remaining gas(basically the gas meant for execution of statements that never actually got executed
        //due to revert done by require statement)


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



    }

    function withdraw() public {

    }
}
 