import React from "react";
import { useSelector } from "react-redux";
import { IAppState } from "../redux/reducer";

export interface INotification {
    id: string;
    timestamp: number;
    title: string;
    message: string;
}

const Notification = (props: {notification: INotification}) => {
    return (
        <div className="ogk-shadowbox notification">
            <div className="notification-title">
                <h1>{props.notification.title}</h1>
            </div>
            <div className="notification-message">
                {props.notification.message}
            </div>
        </div>
    );
}

export const Notifications = () => {
    const notifications = useSelector((appState: IAppState) => appState.notifications);
    return (<>
        {notifications.map(n => <Notification notification={n} />)}
    </>);
}
