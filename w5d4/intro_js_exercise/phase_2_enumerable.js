Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i++) {
    callback(this[i], i);
  }
};

Array.prototype.myMap = function(callback) {
  let result = [];

  this.myEach( (el) => {
      result.push(callback(el));
  });

  return result;
};

Array.prototype.myReduce = function(callback, initialValue) {
  let acc = this[0];
  let index = 1;
  if (initialValue !== undefined) {
    index = 0;
    acc = initialValue;
  }

  this.slice(index).myEach(function(el) {
    acc = callback(acc, el);
  });

  return acc;
};
