import './App.css';
import { useState } from "react"
import { connect } from "get-starknet"
import { Contract } from "starknet"
import { toBN } from "starknet/dist/utils/number"

import contractAbi from "./storage_abi.json"

const contractAddress = "0x06e44b1a9d6b3732090723e2baf1b182c5c1ecc772596c318664e7c550361b32"


function App() {
  const [provider, setProvider] = useState('')
  const [address, setAddress] = useState('')
  const [retrievedBalance, setRetrievedBalance] = useState('')
  const [isConnected, setIsConnected] = useState(false)

  const [stringBalance, setStringBalance] = useState("");
  const [balance, setBalance] = useState(0);

  const connectWallet = async() => {
    try{
      // connect the wallet
      const starknet = await connect()
      await starknet?.enable({ starknetVersion: "v4" })
      // set up the provider
      setProvider(starknet.account)
      // set wallet address
      setAddress(starknet.selectedAddress)
      // set connection flag
      setIsConnected(true)
      
    }
    catch(error){
      alert(error.message)
    }
  }

  const submitBalance =(e) => {
    const length = e.target.value.length
    const value = parseInt(e.target.value, 10)

    if (length === 0) {
      setStringBalance("")
      setBalance(0)
    } else if(!isNaN(value)) {
      setStringBalance(e.target.value)
      setBalance(value)
    }
  }

  const setBalanceFunction = async() => {
    try{
      // create a contract object based on the provider, address and abi
      const contract = new Contract(contractAbi, contractAddress, provider)
      
      // call the increase_balance function
      await contract.set_balance(balance)

      setBalance(0);
    }
    catch(error){
      alert(error.message)
    }
  }

  const getBalanceFunction = async() => {
    try{
      // create a contract object based on the provider, address and abi
      const contract = new Contract(contractAbi, contractAddress, provider)
      // call the function
      const _bal = await contract.get_balance()
      // decode the result
      const _decodedBalance = toBN(_bal.res, 16).toString()
      // display the result
      setRetrievedBalance(_decodedBalance)
    }
    catch(error){
      alert(error.message)
    }
  }

  return (
    <div className="App">
      <header className="App-header">
        <main className="main">
          <h1 className="title">
            Minimal Starknet JS DEMO
          </h1>
          {
            isConnected ?
            <button className="connect">{address.slice(0, 5)}...{address.slice(60)}</button> :
            <button className="connect" onClick={() => connectWallet()}>Connect wallet</button>
          }

          <p className="description">
            Using Starknet JS with a simple contract
          </p>

          <div className="grid">
            <div href="#" className="card">
              <h2>Use Alpha-goerli test net! &rarr;</h2>


              <div className="cardForm">
                <input type="number" className="input" placeholder="Balance" value={stringBalance} onChange={(e) => submitBalance(e)} />
                <input type="submit" className="button" value="Add ETH" onClick={() => setBalanceFunction()} />
              </div>

              <hr />

              {/* <p>Insert a wallet address, to retrieve its name.</p> */}
              <div className="cardForm">
               
                <input type="submit" className="button" value="Get Balance " onClick={() => getBalanceFunction()} />
              </div>
              <p>Balance: {retrievedBalance} ETH</p>
            </div>
          </div>
        </main>
      </header>
    </div>
  );
}

export default App;
