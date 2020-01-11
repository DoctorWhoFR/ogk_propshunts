import React from "react";
import { useSelector } from "react-redux";
import { IAppState } from "./redux/reducer";

export const GuiRouter = () => {
    const currentPage = useSelector((appState: IAppState) => appState)
}
