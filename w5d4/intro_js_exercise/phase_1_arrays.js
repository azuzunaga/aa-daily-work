Array.prototype.uniq = function () {
  let elements = {};
  let i;
  for ( i = 0; i < this.length; i++) {
    elements[this[i]] = this[i] ;
  }
  return Object.values(elements);
};

Array.prototype.twoSum = function() {
  let indices = {};
  let ourResult = [];
  let i;
  for ( i = 0; i < this.length; i++) {
    let difference = 0 - this[i];
    if (this[i] in indices) {
      ourResult.push([indices[this[i]], i]);
    }
    indices[difference] = i;
  }
  return ourResult;
};

Array.prototype.transpose = function() {
  let transposed = [];
  for (let num_cols = 0; num_cols < this[0].length; num_cols ++) {
    transposed.push([]);
  }

  for(let row = 0; row < this.length; row++) {
    for (let col = 0; col < this[row].length; col++) {
      transposed[col].push(this[row][col]);
    }
  }

  return transposed;
};
