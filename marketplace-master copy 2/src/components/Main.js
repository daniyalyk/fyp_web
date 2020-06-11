import React, { Component } from 'react';
import { Link } from "react-router-dom";

class Main extends Component {


  render() {
    
    return (
      <div id="content">
        <Link to="/Home">Click Me</Link>;
       
      </div>
    );
  }
}

export default Main;
