import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import SidebarModule from './module.js';
import { MaterialIcon } from '../../../lib/materialicon.js';
import { setupCursorHover } from '../../../lib/cursorhover.js';
import PomodoroService from '../../../services/pomodoro.js';

const { Box, Button, Label } = Widget;

export default () => {
  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
  };

  const timerLabel = Label({
    className: 'txt txt-large',
    setup: self => 
      self.hook(PomodoroService, (self)=>{
        self.label = formatTime(PomodoroService.timeLeft);
      })
  });

   const startButton = Button({
    child: MaterialIcon('play_arrow', 'norm'),
    className: 'spacing-h-5 txt',
    onClicked: () => PomodoroService.start(),
    setup: setupCursorHover,
  });

  const pauseButton = Button({
    child: MaterialIcon('pause', 'norm'),
    className: 'spacing-h-5 txt',
    onClicked: () => PomodoroService.pause(),
    setup: setupCursorHover,
  });

  const resetButton = Button({
    child: MaterialIcon('refresh', 'norm'),
    className: 'spacing-h-5 txt',
    onClicked: () => PomodoroService.reset(),
    setup: setupCursorHover,
  });

  const controls = Box({
    className: 'spacing-h-5',
    children: [startButton, pauseButton, resetButton],
  });

  return SidebarModule({
    icon: MaterialIcon('timer', 'norm'),
    name: 'Pomodoro Timer',
    child: Box({
      vertical: true,
      className: 'spacing-v-5',
      children: [timerLabel, controls],
    }),
  });
};
