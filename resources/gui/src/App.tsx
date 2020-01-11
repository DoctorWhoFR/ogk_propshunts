import React from 'react';
import './App.css';
import { Provider } from 'react-redux';
import {store} from "./redux/store";
import {Counter} from "./Counter";
import { Notifications } from './notifications/Notifications';

// CSS
import "./assets/css/nuclearbulma.css"
import "./assets/css/ogk_commons.css"
import "./assets/css/ogk_hud.css"
import "./assets/css/ogk_leaderboard.css"
import "./assets/css/ogk_ui.css"
import "./assets/css/ogk_votemap.css"
import "./assets/css/ogk_notifications.css"

// This is the main part of the application that will run as soon as the cef is ready and javascript loaded
const App: React.FC = () => {
  return (
    <Provider store={store}>
      <div className="content">
        <Notifications/>
      </div>
    </Provider>
  );
}

export default App;
