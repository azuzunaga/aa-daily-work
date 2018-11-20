import React from 'react';
import {requestAllPokemon} from '../../actions/pokemon_actions';
import PokemonIndexItem from './pokemon_index_item';

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    // this.props.requestAllPokemon();

    const fetchAllPokemon = () => (
      $.ajax({
        method: 'GET',
        url: '/api/pokemon',
      })
    );

    const receiveAllPokemon = pokemon => ({
      type: 'RECEIVE_ALL_POKEMON',
      pokemon
    });

    fetchAllPokemon().then(pokemon => this.props.dispatch(receiveAllPokemon(pokemon)));
  }

  render() {
    const pokemonItems = this.props.pokemon.map(poke => <PokemonIndexItem key={poke.id} poke={poke} />);

    return (
      <section className="pokedex">
        <ul>
          {pokemonItems}
        </ul>
      </section>
    );
  }
}

export default PokemonIndex;
