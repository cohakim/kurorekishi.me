import React from 'react';
import { Container } from 'unstated'

class AppState extends Container {
  state = {
    credentials: {
      applicationToken: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMDE2NDEyMjEyLCJpYXQiOiIyMDE5LTA4LTEzIDE2OjA5OjQ3ICswOTAwIn0.ASZOp3OHHe4nm4urPoIpY55NUAervdAxsW7iafBpc4M',
    }
  }

  setApplicationToken = applicationToken => {
    this.setState({ applicationToken: applicationToken })
  }

  setCurrentOrder = order => {
    this.setState({ order: order });
  }
}

export default AppState;
