function range(start, end) {
  if (start === end) {
    return [start];
  }

  let result = range(start + 1, end);
  result.unshift(start);
  return result;
}

function sumRec(arr) {
  if (arr.length === 0) {
    return 0;
  }
  if (arr.length === 1) {
    return arr[0];
  }

  return sumRec(arr.slice(1)) + arr[0];
}

function exponent1(base, exp) {
  if (exp === 0) {
    return 1;
  }

  return base * exponent1(base, exp-1);
}

function exponent2(base, exp) {
  if (exp === 0) {
    return 1;
  }

  if (exp % 2 === 0) {
    return exponent2(base, exp/2) ** 2;
  }
  return base * (exponent2(base, (exp-1)/2) ** 2);
}

function fibonacci(n) {
  if (n === 1) {
    return [1];
  }

  if (n === 2) {
    return [1, 1];
  }
  let prevFib = fibonacci(n -1);
  prevFib.push(prevFib[prevFib[prevFib.length - 2]] + prevFib[prevFib[prevFib.length - 1]]);
  return prevFib;
}

function isArray(obj) {
  return Object.prototype.toString.call(obj) === '[object Array]';
}

function deepDup(arr) {
  let dupArray = [];

  for (let i = 0; i < arr.length; i++) {
    if (isArray(arr[i])) {
      dupArray.push(deepDup(arr[i]));
    } else {
      dupArray.push(arr[i]);
    }
  }
  return dupArray;
}

function bsearch(arr, target) {
  if (arr.length === 0) {
    return -1;
  }
  if (arr.length === 1) {
    if (arr[0] === target) {
      return 0;
    } else {
      return -1;
    }
  }

  let mid = Math.floor(arr.length/2);

  if (arr[mid] === target) {
    return mid;
  } else if (arr[mid] < target) {
    let rightBsearch = bsearch(arr.slice(mid+1), target);
    if (rightBsearch === -1) {
      return -1
    } else {
      return rightBsearch + mid + 1;
    }
  } else {
    return bsearch(arr.slice(0, mid), target);
  }
}

function merge(leftArr, rightArr) {
  let mergedArr = [];
  let leftIdx = 0;
  let rightIdx = 0;

  while (leftIdx < leftArr.length && rightIdx < rightArr.length) {
    let left = leftArr[leftIdx];
    let right = rightArr[rightIdx];
    if (right < left) {
      mergedArr.push(right);
      rightIdx++;
    } else {
      mergedArr.push(left);
      leftIdx ++;
    }
  }

  for (; leftIdx < leftArr.length; leftIdx++) {
    mergedArr.push(leftArr[leftIdx]);
  }

  for (; rightIdx < rightArr.length; rightIdx++) {
    mergedArr.push(rightArr[rightIdx]);
  }

  return mergedArr;
}

function mergesort(arr) {
  if(arr.length < 2) return arr;

  let mid = Math.floor(arr.length/2);

  let leftArr = mergesort(arr.slice(0, mid));
  let rightArr = mergesort(arr.slice(mid));

  return  merge(leftArr, rightArr);
}

function subsets(arr) {
  // debugger
  if (arr.length < 1) return [];

  if (arr.length < 2) return [[], arr];

  let subsetsArr = [];

  let nMinusOneSubsets = subsets(arr.slice(0, arr.length - 1));

  for (let i = 0; i < nMinusOneSubsets.length; i++) {
    for(let nMIndex = 0; nMIndex < nMinusOneSubsets.length; nMIndex ++) {
      subsetsArr.push(nMinusOneSubsets[nMIndex]);
    }

    let nMinusOneCopy = deepDup(nMinusOneSubsets);

    for (let j = 0; j < nMinusOneCopy.length; j++) {
      nMinusOneCopy[j].push(arr[arr.length - 1])
    }

    for(let nMIndex = 0; nMIndex < nMinusOneCopy.length; nMIndex ++) {
      subsetsArr.push(nMinusOneCopy[nMIndex]);
    }
  }

  return subsetsArr;

}
