const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(bodyParser.json());

// Object to store connected device IDs and their last update timestamp
const connectedDevices = {};

// Object to store session IDs and their counts for each beacon
const beaconSessionCounts = {};

// Array to store received values
const receivedValues = [];

function getSessionId(deviceId, beaconIdentifier) {
  return `${deviceId}-${beaconIdentifier}`; // Use a combination of deviceId and beaconIdentifier as the session ID
}

function cleanupDevices() {
  const now = Date.now();
  const timeout = 5000; // Timeout value in milliseconds (adjust as needed)

  for (const deviceId in connectedDevices) {
    const device = connectedDevices[deviceId];
    if (!device.connected && now - device.timestamp > timeout) {
      delete connectedDevices[deviceId];
      console.log(`Device ${deviceId} removed due to inactivity`);
    }
  }
}

app.post('/beacon', (req, res) => {
  const deviceId = req.body.deviceId;
  console.log(`Received data from device: ${deviceId}`);

  // Verify the received deviceId
  console.log("Received deviceId: ", deviceId);

  console.log("Received data payload: ", req.body); // Verify the entire payload received

  const value = req.body.value;
  const beaconIdentifier = req.body.beaconIdentifier;

  // Get the session ID for the device and beacon
  const sessionId = getSessionId(deviceId, beaconIdentifier);

  // Initialize the count for the session if it doesn't exist
  if (!beaconSessionCounts[beaconIdentifier]) {
    beaconSessionCounts[beaconIdentifier] = {};
  }

  if (!beaconSessionCounts[beaconIdentifier][sessionId]) {
    beaconSessionCounts[beaconIdentifier][sessionId] = {
      count: 1,
      receivedOne: true,
      receivedZero: false
    };
  }

  // Implement the algorithm
  if (value === 0) {
    beaconSessionCounts[beaconIdentifier][sessionId].receivedZero = true;
    beaconSessionCounts[beaconIdentifier][sessionId].receivedOne = false;
    beaconSessionCounts[beaconIdentifier][sessionId].count -= 1;
  }

  if (value === 1 && beaconSessionCounts[beaconIdentifier][sessionId].receivedZero && !beaconSessionCounts[beaconIdentifier][sessionId].receivedOne) {
    beaconSessionCounts[beaconIdentifier][sessionId].count += 1;
    beaconSessionCounts[beaconIdentifier][sessionId].receivedOne = true;
  }

  receivedValues.push(value); // Store the received value in the array

  // Update the device's timestamp and connection status
  if (connectedDevices[deviceId]) {
    connectedDevices[deviceId].timestamp = Date.now();
    connectedDevices[deviceId].connected = true;
  } else {
    connectedDevices[deviceId] = { timestamp: Date.now(), connected: true };
    console.log(`New device connected: ${deviceId}`);
  }

  res.sendStatus(200);
});

app.get('/beacon', (req, res) => {
  // Run cleanup before returning the count
  cleanupDevices();

  const beaconCounts = {};
  for (const beaconIdentifier in beaconSessionCounts) {
    const sessionCounts = beaconSessionCounts[beaconIdentifier];
    const count = Object.values(sessionCounts).reduce((acc, session) => acc + session.count, 0); // Calculate the count for each beacon
    beaconCounts[beaconIdentifier] = count;
  }
  res.json(beaconCounts); // Send the beacon counts as JSON
  const count = Object.values(connectedDevices).filter(device => device.connected).length;
  const totalCount = Object.values(beaconCounts).reduce((acc, count) => acc + count, 0); // Calculate the total count without device IDs

  // Generate heat map data
  const heatMapData = Object.entries(beaconCounts).map(([beaconIdentifier, count]) => ({
    beaconIdentifier,
    count,
  }));

  // Basic HTML layout for the dashboard
  const dashboard = `
    <html>
      <head>
      <meta http-equiv="refresh" content="30">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
          body {
            display: flex;
            height: 100vh;
            margin: 0;
            padding: 0;
          }

          #sidebar {
            width: 200px;
            background-color: #f0f5ff;
            padding: 20px;
          }

          #content {
            flex: 1;
            padding: 20px;
          }

          h1 {
            margin-top: 0;
          }

          h2 {
            margin-bottom: 10px;
          }

          table {
            width: 100%;
            border-collapse: collapse;
          }

          th,
          td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
          }
        </style>
      </head>
      <body>
        <div id="sidebar">
          <h2>Navigation</h2>
          <ul>
            <li><a href="#beacon1">Beacon 1</a></li>
            <li><a href="#beacon2">Beacon 2</a></li>
          </ul>
        </div>
        <div id="content">
          <h1>Dashboard</h1>
          <h2 id="beacon1">Beacon 1 Count: ${beaconCounts['Beacon1']}</h2>
          <h2 id="beacon2">Beacon 2 Count: ${beaconCounts['Beacon2']}</h2>
          <h2>Total Count: ${totalCount}</h2>
          <h2>Peak Connection: ${count}</h2>
          <h2>Received Values</h2>
          <table>
            <thead>
              <tr>
                <th>Value</th>
              </tr>
            </thead>
            <tbody>
              ${receivedValues.map(value => `<tr><td>${value}</td></tr>`).join('')}
            </tbody>
          </table>
          <h2>Bar Graph: Beacon Counts</h2>
          <canvas id="barChart"></canvas>
          <h2>Line Graph: Total Count</h2>
          <canvas id="lineChart"></canvas>
          <h2>Heat Map: Beacon Counts</h2>
          <canvas id="heatMap"></canvas>
      

        </div>
        <script>
          const beacon1CountData = ${beaconCounts['Beacon1'] || 0};
          const beacon2CountData = ${beaconCounts['Beacon2'] || 0};
          const totalCountData = ${totalCount};
          let peakCount = totalCountData;

          // Bar Graph
          const barChart = new Chart(document.getElementById('barChart').getContext('2d'), {
            type: 'bar',
            data: {
              labels: ['Beacon 1', 'Beacon 2'],
              datasets: [
                {
                  label: 'Beacon Counts',
                  data: [beacon1CountData, beacon2CountData],
                  backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(54, 162, 235, 0.5)',
                  ],
                  borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                  ],
                  borderWidth: 1,
                },
              ],
            },
            options: {
              responsive: true,
              maintainAspectRatio: false,
              scales: {
                x: {
                  display: true,
                  title: {
                    display: true,
                    text: 'Beacon Identifier',
                  },
                },
                y: {
                  display: true,
                  title: {
                    display: true,
                    text: 'Count',
                  },
                },
              },
            },
          });

          // Line Graph
const lineChart = new Chart(document.getElementById('lineChart').getContext('2d'), {
  type: 'line',
  data: {
    labels: [],
    datasets: [
      {
        
        label: 'Total Count',
        data: [{ x: new Date().toLocaleTimeString(), y: totalCountData }],
        borderColor: 'rgba(75, 192, 192, 1)',
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        pointRadius: 20,
        pointBackgroundColor: 'rgba(75, 192, 192, 1)',
        fill: true,
        tension: 0.3,
        showLine: true, // Add this property to show the line
      },
    ],
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      x: {
        display: true,
        title: {
          display: true,
          text: 'Time',
        },
      },
      y: {
        display: true,
        title: {
          display: true,
          text: 'Count',
        },
      },
    },
  },
});

const totalCountHistory = [{ x: new Date().toLocaleTimeString(), y: 0 }];

function updateTotalCountHistory() {
  const currentTime = new Date().toLocaleTimeString();
  const currentTotalCount = Object.values(beaconCounts).reduce((acc, count) => acc + count, 0);
  totalCountHistory.push({ x: currentTime, y: currentTotalCount });

  // Limit the history array to the last 10 data points
  if (totalCountHistory.length > 10) {
    totalCountHistory.shift();
  }
}

function updateLineChart() {
  updateTotalCountHistory();
  lineChart.data.labels = totalCountHistory.map(dataPoint => dataPoint.x);
  lineChart.data.datasets[0].data = totalCountHistory.map(dataPoint => dataPoint.y);
  lineChart.update();
}

updateTotalCountHistory();
setInterval(updateLineChart, 5000);







          // Heat Map
          const heatMap = new Chart(document.getElementById('heatMap').getContext('2d'), {
            type: 'heatmap',
            data: {
              datasets: [{
                data: ${JSON.stringify(heatMapData)},
                borderWidth: 1,
              }],
            },
            options: {
              responsive: true,
              maintainAspectRatio: false,
              plugins: {
                legend: false,
              },
              scales: {
                x: {
                  display: true,
                  title: {
                    display: true,
                    text: 'Beacon Identifier',
                  },
                },
                y: {
                  display: true,
                  title: {
                    display: true,
                    text: 'Count',
                  },
                },
              },
            },
          });

          

          setInterval(updateLineChart, 5000);
        </script>
      </body>
    </html>
  `;

  res.send(dashboard);
});






app.delete('/beacon/:deviceId', (req, res) => {
  const deviceId = req.params.deviceId;
  console.log(`Device disconnected: ${deviceId}`);

  // Update the device's connection status
  if (connectedDevices[deviceId]) {
    connectedDevices[deviceId].connected = false;
  }

  // Remove the session counts for the device across all beacons
  for (const beaconIdentifier in beaconSessionCounts) {
    const sessionId = getSessionId(deviceId, beaconIdentifier);
    delete beaconSessionCounts[beaconIdentifier][sessionId];
  }

  // Run cleanup after device disconnection
  cleanupDevices();

  res.sendStatus(200);
});

// Periodically run the cleanup function
setInterval(cleanupDevices, 1000); // Cleanup every second (adjust as needed)

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
