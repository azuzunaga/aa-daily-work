import { RECEIVE_ALL_POKEMON } from '../actions/pokemon_actions';
import { RECEIVE_SINGLE_POKEMON } from '../actions/pokemon_actions';
import merge from 'lodash/merge';

const pokemonReducer = (state={}, action) => {

  Object.freeze(state);
  let newState;

  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      return action.pokemon;

    case RECEIVE_SINGLE_POKEMON:
      newState = merge({}, state);
      newState[action.pokemon.pokemon.id] = action.pokemon.pokemon;
      return newState;
    default:
      return state;
  }
};

export default pokemonReducer;
