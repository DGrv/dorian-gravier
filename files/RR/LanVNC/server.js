const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const screenshot = require('screenshot-desktop');
const robot = require('robotjs');
const os = require('os');

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: '*',
    methods: ['GET', 'POST']
  },
  maxHttpBufferSize: 1e8 // 100MB for large screenshots
});

// Serve static files
app.use(express.static('public'));

// Get local IP address
function getLocalIP() {
  const interfaces = os.networkInterfaces();
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      if (iface.family === 'IPv4' && !iface.internal) {
        return iface.address;
      }
    }
  }
  return 'localhost';
}

// Screen streaming
let streamingClients = new Set();
let streamInterval = null;

async function captureAndSendScreen() {
  if (streamingClients.size === 0) return;
  
  try {
    const img = await screenshot({ format: 'jpg', quality: 60 });
    const base64 = img.toString('base64');
    
    streamingClients.forEach(clientId => {
      io.to(clientId).emit('screen', base64);
    });
  } catch (error) {
    console.error('Screenshot error:', error);
  }
}

io.on('connection', (socket) => {
  console.log('Client connected:', socket.id);
  
  // Get screen dimensions
  const screenSize = robot.getScreenSize();
  socket.emit('screen-size', screenSize);
  
  // Start streaming
  socket.on('start-stream', () => {
    streamingClients.add(socket.id);
    
    if (!streamInterval) {
      streamInterval = setInterval(captureAndSendScreen, 100); // ~10 FPS
    }
    
    console.log('Started streaming to:', socket.id);
  });
  
  // Stop streaming
  socket.on('stop-stream', () => {
    streamingClients.delete(socket.id);
    
    if (streamingClients.size === 0 && streamInterval) {
      clearInterval(streamInterval);
      streamInterval = null;
    }
    
    console.log('Stopped streaming to:', socket.id);
  });
  
  // Mouse move
  socket.on('mouse-move', ({ x, y, screenWidth, screenHeight }) => {
    const actualX = Math.round((x / screenWidth) * screenSize.width);
    const actualY = Math.round((y / screenHeight) * screenSize.height);
    robot.moveMouse(actualX, actualY);
  });
  
  // Mouse click
  socket.on('mouse-click', ({ button }) => {
    robot.mouseClick(button || 'left');
  });
  
  // Mouse double-click
  socket.on('mouse-dblclick', ({ button }) => {
    robot.mouseClick(button || 'left', true);
  });
  
  // Mouse scroll
  socket.on('mouse-scroll', ({ deltaY }) => {
    const scrollAmount = Math.round(deltaY / 10);
    robot.scrollMouse(0, scrollAmount);
  });
  
  // Keyboard input
  socket.on('key-press', ({ key, modifiers }) => {
    try {
      if (modifiers && modifiers.length > 0) {
        robot.keyTap(key, modifiers);
      } else {
        robot.keyTap(key);
      }
    } catch (error) {
      console.error('Key press error:', error);
    }
  });
  
  // Type text
  socket.on('type-text', ({ text }) => {
    try {
      robot.typeString(text);
    } catch (error) {
      console.error('Type text error:', error);
    }
  });
  
  // Disconnect
  socket.on('disconnect', () => {
    streamingClients.delete(socket.id);
    
    if (streamingClients.size === 0 && streamInterval) {
      clearInterval(streamInterval);
      streamInterval = null;
    }
    
    console.log('Client disconnected:', socket.id);
  });
});

const PORT = process.env.PORT || 3000;
const localIP = getLocalIP();

server.listen(PORT, '0.0.0.0', () => {
  console.log('\n╔═══════════════════════════════════════════╗');
  console.log('║   LAN Remote Desktop Server Running   ║');
  console.log('╚═══════════════════════════════════════════╝\n');
  console.log(`  Local:   http://localhost:${PORT}`);
  console.log(`  Network: http://${localIP}:${PORT}\n`);
  console.log('  Share the Network URL with devices on your LAN');
  console.log('  Press Ctrl+C to stop\n');
});
