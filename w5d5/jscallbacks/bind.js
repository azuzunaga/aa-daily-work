

Function.prototype.myBind = function(context) {
  return () => {
    this.apply(context);
  };
};

class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function() {
   console.log("Turning on " + this.name);
};

const lamp = new Lamp();

console.log("\nTrying turnOn()");
turnOn(); // should not work the way we want it to

const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

console.log("\nTrying boundTurnOn()");
boundTurnOn(); // should say "Turning on a lamp"

console.log("\nTrying myBoundTurnOn()");
myBoundTurnOn(); // should say "Turning on a lamp"
