import React, { Component } from "react";
import Web3 from 'web3';
import detectEthereumProvider from "@metamask/detect-provider";
import KryptoBird from "../abis/KryptoBird.json";

class App extends Component {

    constructor(props) {
        super(props);
        this.state = {
            account: "",
        }
    }

    // first up is to detect metamask is connected
    async loadWeb3() {
        const provider = await detectEthereumProvider();
        // modern browsers
        if (provider){
            console.log('ethereum wallet is connected');
            window.web3 = new Web3(provider)
        } else {
            console.log("No wallet provided");
        }
    }

    async loadBlockchainData() {
        const web3 = window.web3;
        const accounts = await web3.eth.getAccounts();
        this.setState({ account: accounts[0]});

    }

    async componentDidMount() {
        await this.loadWeb3();
        await this.loadBlockchainData()
    }

    render(){
        return(
            <div>
                <h1>NFT Market Space</h1>
            </div>
        )
    }
}

export default App;