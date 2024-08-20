const { GLib, GObject } = imports.gi;
import Service from 'resource:///com/github/Aylur/ags/service.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

const PomodoroService = GObject.registerClass(
  {
    Signals: {
      'updated': {},
    },
  },
  class PomodoroService extends Service {
    _init() {
      super._init();
      this._timer = null;
      this._timeLeft = 25 * 60; // 25 minutes in seconds
      this._isRunning = false;
      log('PomodoroService initialized');
    }

    get timeLeft() {
      return this._timeLeft;
    }

    get isRunning() {
      return this._isRunning;
    }

    _updateTimer() {
      this.emit('updated');
      log(`Timer updated: ${this._timeLeft} seconds left`);
    }

    start() {
      if (this._isRunning) return;
      this._isRunning = true;
      log('Pomodoro timer started');
      this._timer = Utils.timeout(1000, () => {
        if (this._timeLeft > 0) {
          this._timeLeft--;
          this._updateTimer();
          return true; // Continue the timeout
        } else {
          this._isRunning = false;
          this._updateTimer();
          log('Pomodoro timer finished');
          return false; // Stop the timeout
        }
      });
    }

    pause() {
      if (!this._isRunning) return;
      this._isRunning = false;
      if (this._timer) {
        GLib.source_remove(this._timer);
        this._timer = null;
        log('Pomodoro timer paused');
      } else {
        log('No active timer to pause');
      }
      this._updateTimer();
    }

    reset() {
      this.pause();
      this._timeLeft = 25 * 60;
      this._updateTimer();
      log('Pomodoro timer reset');
    }
  }
);

// the singleton instance
const service = new PomodoroService();

// make it global for easy use with cli
globalThis.pomodoro = service;

// export to use in other modules
export default service;
