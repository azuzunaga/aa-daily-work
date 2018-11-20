Array.prototype.bubbleSort = function() {
  if (this.length === 0) {
    return [];
  }

  let swapped = true;

  while(swapped) {
    swapped = false;
    for (let i = 1; i < this.length; i++) {
        if (this[i] < this[i-1]) {
          swapped = true;
          let tmp = this[i];
          this[i] = this[i-1];
          this[i-1] = tmp;
        }
    }
  }

  return this;
};

String.prototype.substrings = function() {
  let mySubstrings = [];

  for (let windowIndex = 0; windowIndex < this.length; windowIndex++) {
    let windowSlice = this.slice(windowIndex);

    for (let substringLength = 1; substringLength < windowSlice.length; substringLength++) {
      mySubstrings.push(windowSlice.slice(0, substringLength));
    }

  }
  return mySubstrings;
};
