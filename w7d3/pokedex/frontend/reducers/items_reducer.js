import { RECEIVE_SINGLE_POKEMON } from '../actions/pokemon_actions';
import merge from 'lodash/merge';


const itemsReducer = (state={}, action) => {
  Object.freeze(state);
  let newState;

  switch (action.type) {
    case RECEIVE_SINGLE_POKEMON:
      return action.pokemon.items;
    default:
      return state;
  }
};

export default itemsReducer;
