import React, { Component } from 'react';

class Navbar extends Component {

  render() {
    return (
      <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
        <a
          className="navbar-brand col-sm-3 col-md-2 mr-0"
          href="/page2"
          rel="noopener noreferrer"
        >
        BitAssetly
        </a>
       
          <a className="navbar-text col-sm-0 col-md-0 mr-0" href= "/page2">
            <small className="text-white"><span id="account" >Home</span></small>
          </a>
          <a className="navbar-text col-sm-0 col-md-0 mr-0" href= "/add">
            <small className="text-white"><span id="account" >Add Commodity</span></small>
          </a>
         <a className="navbar-text col-sm-0 col-md-0 mr-0" href= "/update">
            <small className="text-white"><span id="account" >Update Commodity</span></small>
          </a> <a className="navbar-text col-sm-2 col-md-4 mr-0" href= "/search">
            <small className="text-white"><span id="account" >Search Commodity</span></small>
          </a>

          <a className="navbar-text col-sm-0 col-md-1 mr-0" href= "/Home">
            <small className="text-white"><span id="account" >Logout</span></small>
          </a>
       


      </nav>
    );
  }
}

export default Navbar;
