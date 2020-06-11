import React, { Component } from 'react';
import Web3 from 'web3'
import logo from '../logo.png';
import './App.css';
import Marketplace from '../abis/Marketplace.json'
import User from '../abis/User.json'

import { Router } from 'react-router-dom'
import Routes from '../routes'
import history from '../services/history';

import { Link } from "react-router-dom";


import Navbar from './Navbar'
import Main from './Main'

class Home extends Component {

  async componentWillMount() {
    await this.loadWeb3()
    await this.loadBlockchainData()
  }

  async loadWeb3() {
    if (window.ethereum) {
      window.web3 = new Web3(window.ethereum)
      await window.ethereum.enable()
    }
    else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider)
    }
    else {
      window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!')
    }
  }

  async loadBlockchainData() {
    const web3 = window.web3
    // Load account
    const accounts = await web3.eth.getAccounts()
    this.setState({ account: accounts[0] })
    const networkId = await web3.eth.net.getId()

    const networkData = Marketplace.networks[networkId]
    const networkData_user = User.networks[networkId]


    if(networkData_user) {
      const marketplace = web3.eth.Contract(Marketplace.abi, networkData.address)
      this.setState({ marketplace })
      const productCount = await marketplace.methods.productCount().call()
      this.setState({ productCount })
      
      this.setState ({ User })
      // // Load products
      // for (var i = 1; i <= productCount; i++) {
      //   const product = await marketplace.methods.products(i).call()
      //   this.setState({
      //     products: [...this.state.products, product]
      //   })
      // }
      this.setState({ loading: false})
    } else {
      window.alert('Marketplace contract not deployed to detected network.')
    }
  }

  constructor(props) {
    super(props)
    this.state = {
      account: '',  //account[0] which is the admin account!
      // productCount: 0,
      // products: [],
      userCount: 0,
      users: [],
      loading: true
    }

    // this.createProduct = this.createProduct.bind(this)
    // this.purchaseProduct = this.purchaseProduct.bind(this)
    this.CreateUser= this.LoginUser.bind(this)
  }

  // createProduct(name, price) {
  //   this.setState({ loading: true })
  //   this.state.marketplace.methods.createProduct(name, price).send({ from: this.state.account })
  //   .once('receipt', (receipt) => {
  //     this.setState({ loading: false })
  //   })
  // }

  // purchaseProduct(id, price) {
  //   this.setState({ loading: true })
  //   this.state.marketplace.methods.purchaseProduct(id).send({ from: this.state.account, value: price })
  //   .once('receipt', (receipt) => {
  //     this.setState({ loading: false })
  //   })
  // }

  LoginUser(username, password)
  {
    this.setState({loading: true})
    this.state.marketplace.methods.LoginUser(username, password).send({from: this.state.account})
    .once ('receipt', (receipt)=> {this.setState({loading: false})})

  }
  render() {
    function clickHandler(){
    console.log('Button pressed')

  }
    return (
      <div>
        <Navbar account={this.state.account} />
        <div className="container-fluid mt-5">
          <div className="row">
            <main role="main" className="col-lg-12 d-flex">
              <div id="content">
                <h1> Welcome to BitAssetly Admin </h1>
                <h4> What do you want to do? </h4>

             	<Link variant="dark" to='/add'> Add Commodity </Link>
             	<p></p>
          		<Link variant="dark" to='/update'> Delete Commodity </Link>
				<p></p>
             	<Link variant="dark" to='/search'> Search Commodity </Link>
                 
              </div>        
            </main>
          </div>
        </div>
      </div>
    );
  }
}
export default Home;
