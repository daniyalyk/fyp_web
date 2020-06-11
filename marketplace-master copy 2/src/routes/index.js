import React from 'react';
import { Switch, Route } from 'react-router-dom';
import Home from '../components/Home';
import Page2 from '../components/page2';
import Main from '../components/Main';
import App from '../components/App.js';
import addcommodity from '../components/addcommodity.js';
import updatecommodity from '../components/updatecommodity.js';
import searchcommodity from '../components/searchcommodity.js';


export default function Routes() {
  return (
    <Switch>

		<Route path="/page2" exact component={Page2} />

		<Route path="/Home" exact component={Home} />
		<Route path="/add" exact component={addcommodity} />
		<Route path="/update" exact component={updatecommodity} />
		<Route path="/search" exact component={searchcommodity} />



      <Route component={Main} />
    </Switch>
  );
}