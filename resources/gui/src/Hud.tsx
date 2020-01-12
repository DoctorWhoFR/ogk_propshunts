import React from "react";
import { useSelector } from "react-redux";
import { IAppState } from "./redux/reducer";

export const Hud = () => {
    const player = useSelector((appState: IAppState) => appState.player);

    return (
        <div>
            <div className="player-hud content ogk-shadowbox ">
            <div className="hud-top">
                <div className="column">
                    <span className="hud-title" id="health">{player.health}</span><br />
                    <span className="hud-subtitle">HEALTH</span>
                </div>
            </div>
            <div>
                Current Weapon: <span id="weaponsName"></span> <br />
                Next: <span id="weaponsNext"></span>
            </div>
                <div className="hud-bottom column">
                </div>
            </div>
        </div>
    )
}
