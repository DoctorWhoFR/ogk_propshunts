import { createAction, AnyAction, createReducer } from "@reduxjs/toolkit";
import { wrapAction } from "../onset";
import { INotification } from "../notifications/Notifications";

// Here I create an action that takes no argument
export const incrementCounter = createAction("INCREMENT_COUNTER");

// I want this action to be available to Onset so I attach it globally
(window as any).incrementCounter = wrapAction(incrementCounter);

export const addNotification = createAction("ADD_NOTIFICATION");
export const cleanNotification = createAction("CLEAN_NOTIFICATIONS");
(window as any).addNotification = wrapAction(addNotification);
(window as any).clearNotification = wrapAction(cleanNotification);

// Here I declare the state of my whole application
// I only have one of course because this is only counting
export interface IAppState {
    counter: number;
    notifications: INotification[];
}

const initialState: IAppState = {
    counter: 0,
    notifications: []
};

// Here it is my reducer, his tasks is to merge the future state with
export const counterReducer = createReducer(initialState, {
    [incrementCounter.type]: (state) => ({ ...state, counter: state.counter + 1 }),
    [addNotification.type]: (state, action) => ({...state, notifications: [...state.notifications, {...JSON.parse(action.payload)}]}),
    [cleanNotification.type]: (state, action) => {
        const now = Date.now();
        return {...state, notifications: state.notifications.filter(n => n.id !== action.payload)};
    }
});
