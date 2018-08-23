#!/bin/bash
# Run command and store PID
python unstoppable_bastard.py& 
PID=$!
echo "Running unstoppable bastard with PID: ${PID}"

# Kill unstoppable bastard after WAIT time
WAIT="5s"
echo "Send SIGINT signal to unstoppable bastard in ${WAIT}"
sleep ${WAIT}

echo "Sending SIGINT to process: ${PID}"
kill -2 ${PID}
