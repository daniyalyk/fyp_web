import React, { Component } from 'react';
import Web3 from 'web3'
import logo from '../logo.png';
import './App.css';
import Marketplace from '../abis/Marketplace.json'
import Commodity from '../abis/Commodity.json'

import User from '../abis/User.json'

import { Router } from 'react-router-dom'
import Routes from '../routes'
import history from '../services/history';

import { Link } from "react-router-dom";


import Navbar from './Navbar'
import Main from './Main'

class addcommodity extends Component {

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
    const networkData_commodity = Commodity.networks[networkId]
    const networkData_user = User.networks[networkId]

    if(networkData_commodity) {
      const marketplace = web3.eth.Contract(Marketplace.abi, networkData.address)
      this.setState({ marketplace })
      const productCount = await marketplace.methods.productCount().call()
      this.setState({ productCount })
      
      const commodity = web3.eth.Contract(Commodity.abi, networkData_commodity.address)
      this.setState ({ commodity })

      const user = web3.eth.Contract(User.abi, networkData_user.address)
      this.setState ({ user })

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
    this.createCommodity = this.createCommodity.bind(this)
    // this.createProduct = this.createProduct.bind(this)
    // this.purchaseProduct = this.purchaseProduct.bind(this)
    this.Return= this.Return.bind(this)
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
  createCommodity(name , quantity)
  {
    console.log("createCommodity called ")
    console.log(name)
    console.log(quantity)
    
    this.setState({loading: true})
    console.log(this.state.account)
    this.state.user.methods.addcommodity(this.state.account, name, Number.parseInt(quantity)).send({ from: this.state.account })
    .once('receipt', (receipt) => {this.setState({ loading: true })})
    console.log("commodity for sale called")

    this.state.commodity.methods.addforSaleCommodities(name, quantity, this.state.account).send({ from: this.state.account })
    .once('receipt', (receipt) => {this.setState({ loading: false })})
    console.log(this.state.account)
  }

  Return()
  {
         window.location.href="/page2"


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
                <h1> Add a Commodity</h1>
                <p></p>
                <h2> Please enter Commodity Details </h2>
                <form onSubmit={(event) => {
                  event.preventDefault()
                  const name = this.commodity_name.value
                  const quantity = this.commodity_quantity.value
                  this.createCommodity(name, quantity)
                }}>
                 <div className="form-group mr-sm-2">
                    <input
                      id="commodity_name"
                      type="text"
                      ref={(input) => { this.commodity_name = input }}
                      className="form-control"
                      placeholder="Commodity Name"
                      required />
                  </div>
                  <div className="form-group mr-sm-2">
                    <input
                      id="commodity_quantity"
                      type="number"
                      ref={(input) => { this.commodity_quantity = input }}
                      className="form-control"
                      placeholder="Commodity Quantity"
                      required />
                  </div>
                  <button type="submit" className="btn btn-primary" > Add </button>

                  </form>
                  <p></p>
                <form onSubmit={(event) => {
                  event.preventDefault()
                  this.Return()
                   }}>

                  <button type="submit" className="btn btn-primary" > Back </button>
                  </form>


              </div> 
                   
            </main>
          </div>
        </div>
      </div>
    );
  }
}
export default addcommodity;
