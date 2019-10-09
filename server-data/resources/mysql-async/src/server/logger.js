const fs = require('fs');

function wider(val) {
  let val2 = val.toString();
  while (val2.length < 2) {
    val2 = `0${val2}`;
  }
  return val2;
}

function timestamp() {
  const now = new Date();
  return `${now.getFullYear()}-${wider(now.getMonth())}-${wider(now.getDay())} ${wider(now.getHours())}:${wider(now.getMinutes())}:${wider(now.getSeconds())}`;
}

class Logger {
  constructor(output) {
    this.output = output;
    this.fileStream = null;
    if (this.output === 'file' || this.output === 'both') {
      this.fileStream = fs.createWriteStream('./mysql-async.log', { flags: 'a' });
    }
    this.writeConsole = msg => console.log(msg);
  }

  writeFile(msg) {
    const ts = timestamp();
    this.fileStream.write(`${ts} ${msg}\n`);
  }

  log(msg) {
    switch (this.output) {
      default:
      case 'console':
        this.writeConsole(msg);
        break;
      case 'file':
        this.writeFile(msg);
        break;
      case 'both':
        this.writeConsole(msg);
        this.writeFile(msg);
        break;
    }
  }

  error(msg) {
    let errorMsg = msg;
    if (this.output !== 'file') {
      errorMsg = `\x1b[31m${msg}\x1b[0m`;
    }
    this.log(errorMsg);
  }
}

module.exports = Logger;
