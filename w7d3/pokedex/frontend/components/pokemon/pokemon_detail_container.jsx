
import {connect} from 'react-redux';
import PokemonDetail from './pokemon_detail';
import {requestSinglePokemon} from '../../actions/pokemon_actions';

const mapStateToProps = state => ({
  pokemon:
});

const mapDispatchToProps = dispatch => ({
  requestSinglePokemon: () => dispatch(requestSInglePokemon())
});
