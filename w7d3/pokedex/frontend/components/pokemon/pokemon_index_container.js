import {connect} from 'react-redux';
import {selectAllPokemon} from '../../reducers/selectors';
import PokemonIndex from './pokemon_index';
import {requestAllPokemon} from '../../actions/pokemon_actions';



const mapStateToProps = state => ({
  pokemon: selectAllPokemon(state)
});

const mapDispatchToProps = dispatch => ({
  requestAllPokemon: () => dispatch(requestAllPokemon()),
  dispatch: dispatch
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonIndex);

// connect(fn1, fn2)(component);
//
// 1. build the props
// 2. passes the props to component
