class Clock {
  constructor() {
      this.startDate = new Date();
      this._tick();
  }

  printTime() {
    console.log(`${this.startDate.toTimeString()}`);
  }

  _tick() {
    setInterval(() => {
      this.startDate.setSeconds(this.startDate.getSeconds() + 1);
      this.printTime();
    }, 1000);

  }
}

const clock = new Clock();
