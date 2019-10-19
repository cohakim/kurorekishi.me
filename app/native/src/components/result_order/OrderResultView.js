import React from 'react';
import { Button } from 'react-native';

import AppState from '../../models/AppState'
import OrderRepository from '../../repositories/OrderRepository'

class OrderResultView extends React.Component {
  render() {
    return (
      <Button title="Order Result" />
    );
  }
}

export default OrderResultView;
