import React from 'react';
import { Link } from 'react-router-dom';

const PokemonIndexItem = ({ poke }) => {
  return (
    <li>
      <Link to={`/pokemon/${poke.id}`}>
        <img src={poke.image_url} width="30" height="30"></img>
        {poke.name}
      </Link>
    </li>
  );
};

export default PokemonIndexItem;
