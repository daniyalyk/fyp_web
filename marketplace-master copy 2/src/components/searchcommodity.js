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

      const commodityCount = await this.state.commodity.methods.commoditiesforSaleCount().call()
      this.setState({ commodityCount })
      console.log(commodityCount);
      
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
      commodityCount: 0,
      forSalecommodities: [],
      loading: true
    }
    //this.createCommodity = this.createCommodity.bind(this)
    // this.createProduct = this.createProduct.bind(this)
    // this.purchaseProduct = this.purchaseProduct.bind(this)
    this.searchCommodity= this.searchCommodity.bind(this)
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
  
  async searchCommodity(name)
  {
    // const commodity = web3.eth.Contract(Commodity.abi, networkData_commodity.address)
    //   this.setState ({ commodity })
        

    console.log(name)
    this.setState({loading: true})
// Load commodities
        console.log(this.state.commodityCount)
        for (var i = 0; i <= this.state.commodityCount; i++) {
        const commodity2 = await this.state.commodity.methods.forSalecommodities(i).call()
        if (commodity2.name==name)
        {
        this.setState({
          forSalecommodities: [...this.state.forSalecommodities, commodity2]
        })

      }
            this.setState(commodity2);

        }

         

        this.setState({loading: false});


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
                <h1> Search for a Commodity</h1>
                <p></p>
                <h2> Please enter Commodity Details </h2>
                <form onSubmit={(event) => {
                  event.preventDefault()
                  const name = this.commodity_name.value

                  this.searchCommodity(name)
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
                  
                  <button type="submit" className="btn btn-primary" > Search </button>

                  </form>
                  <p></p>
                <form onSubmit={(event) => {
                  event.preventDefault()
                  this.Return()
                   }}>

                  <button type="submit" className="btn btn-primary" > Back </button>
                  </form>
          <table className="table">
          <thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">Name</th>
              <th scope="col">Quantity</th>
            </tr>
          </thead>
          <tbody id="commodityList">
            { this.state.forSalecommodities.map((commodity, key) => {
              return(
                <tr key={key}>
                  <th scope="row">{commodity.id.toString()}</th>
                  <td>{commodity.name}</td>
                  <td>{commodity.quantity.toString()}</td>

                </tr>
              )
            })}
          </tbody>
        </table>


              </div> 
                   
            </main>
          </div>
        </div>
      </div>
    );
  }
}
export default addcommodity;
